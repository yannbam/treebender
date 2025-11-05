use std::fmt;

#[derive(Debug, Clone, PartialEq, Eq)]
pub struct Constituent<T> {
  pub value: T,
  pub span: (usize, usize),
}

impl<T> fmt::Display for Constituent<T>
where
  T: fmt::Display,
{
  fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
    write!(f, "{}..{}: {}", self.span.0, self.span.1, self.value)
  }
}

#[derive(Debug, Clone, PartialEq, Eq)]
pub struct Word<U> {
  pub value: U,
  pub span: (usize, usize),
}

impl<U> fmt::Display for Word<U>
where
  U: fmt::Display,
{
  fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
    write!(f, "{}..{}: {}", self.span.0, self.span.1, self.value)
  }
}

#[derive(Debug, PartialEq, Clone)]
pub enum SynTree<T, U> {
  Branch(Constituent<T>, Vec<SynTree<T, U>>),
  Leaf(Word<U>),
}

impl<T, U> SynTree<T, U> {
  pub fn is_leaf(&self) -> bool {
    matches!(self, Self::Leaf(_))
  }

  pub fn is_branch(&self) -> bool {
    matches!(self, Self::Branch(_, _))
  }

  pub fn get_leaf(&self) -> Option<&Word<U>> {
    match self {
      Self::Leaf(w) => Some(w),
      _ => None,
    }
  }

  #[allow(clippy::type_complexity)] // TODO
  pub fn get_branch(&self) -> Option<(&Constituent<T>, &Vec<SynTree<T, U>>)> {
    match self {
      Self::Branch(c, cs) => Some((c, cs)),
      _ => None,
    }
  }

  #[allow(clippy::type_complexity)] // TODO
  pub fn into_branch(self) -> Option<(Constituent<T>, Vec<SynTree<T, U>>)> {
    match self {
      Self::Branch(c, cs) => Some((c, cs)),
      _ => None,
    }
  }

  pub fn map<V, W>(
    &self,
    map_branch: fn(&Constituent<T>) -> V,
    map_leaf: fn(&Word<U>) -> W,
  ) -> SynTree<V, W> {
    match self {
      Self::Branch(t, children) => {
        let children = children
          .iter()
          .map(|c| c.map(map_branch, map_leaf))
          .collect::<Vec<_>>();
        SynTree::Branch(
          Constituent {
            span: t.span,
            value: map_branch(t),
          },
          children,
        )
      }
      Self::Leaf(u) => SynTree::Leaf(Word {
        span: u.span,
        value: map_leaf(u),
      }),
    }
  }

  /// Format the tree as ASCII with box-drawing characters (├── └──)
  pub fn format_ascii(&self) -> String
  where
    T: fmt::Display,
    U: fmt::Display,
  {
    let mut output = String::new();
    self.format_ascii_recursive(&mut output, "", true, true);
    output
  }

  fn format_ascii_recursive(
    &self,
    output: &mut String,
    prefix: &str,
    is_last: bool,
    is_root: bool,
  )
  where
    T: fmt::Display,
    U: fmt::Display,
  {
    match self {
      Self::Leaf(word) => {
        output.push_str(prefix);
        if !is_root {
          output.push_str(if is_last { "└── " } else { "├── " });
        }
        output.push_str(&format!("{}\n", word));
      }
      Self::Branch(constituent, children) => {
        // Print the branch indicator and constituent
        output.push_str(prefix);
        if !is_root {
          output.push_str(if is_last { "└── " } else { "├── " });
        }
        output.push_str(&format!("{}\n", constituent));

        // Calculate new prefix for children
        let child_prefix = if is_root {
          // Root node: children start fresh
          String::new()
        } else {
          // Non-root: add continuation bar or spaces
          format!("{}{}", prefix, if is_last { "    " } else { "│   " })
        };

        for (i, child) in children.iter().enumerate() {
          let is_last_child = i == children.len() - 1;
          child.format_ascii_recursive(output, &child_prefix, is_last_child, false);
        }
      }
    }
  }

  /// Format the tree as a vertical tree with children spread horizontally.
  /// Uses box-drawing characters: ┌──┬──┐ and │
  pub fn format_unicode(&self) -> String
  where
    T: fmt::Display,
    U: fmt::Display,
  {
    let lines = self.format_vertical_lines();
    lines.join("\n") + "\n"
  }

  fn format_vertical_lines(&self) -> Vec<String>
  where
    T: fmt::Display,
    U: fmt::Display,
  {
    match self {
      Self::Leaf(word) => {
        vec![format!("{}", word)]
      }
      Self::Branch(constituent, children) => {
        if children.is_empty() {
          return vec![format!("{}", constituent)];
        }

        // Step 1: Build all child lines recursively (bottom-up)
        let child_lines: Vec<Vec<String>> = children
          .iter()
          .map(|c| c.format_vertical_lines())
          .collect();

        // Step 2: Calculate child widths from actual rendered content
        let child_widths: Vec<usize> = child_lines
          .iter()
          .map(|lines| lines.iter().map(|l| l.len()).max().unwrap_or(0))
          .collect();

        // Step 3: Calculate child center positions as they'll appear in final layout
        let mut positions = vec![];
        let mut current_pos = 0;

        for (i, &width) in child_widths.iter().enumerate() {
          // Find the actual center of the text in this child's first line
          let first_line = &child_lines[i][0];
          let leading_spaces = first_line.len() - first_line.trim_start().len();
          let text = first_line.trim();
          let text_center_offset = leading_spaces + text.len() / 2;

          let center = current_pos + text_center_offset;
          positions.push(center);
          current_pos += width + 2; // width + 2-space gap
        }

        // Step 4: Determine total layout width and parent center
        let total_width: usize = child_widths.iter().sum::<usize>() + (children.len() - 1) * 2;

        // Determine parent connection position
        let branch_center = if positions.len() == 1 {
          positions[0]
        } else if positions.len() % 2 == 1 {
          // Odd children: use middle child position
          let middle_idx = positions.len() / 2;
          positions[middle_idx]
        } else {
          // Even children: calculate center, then snap to nearby child if within 1
          let center = (positions[0] + positions.last().unwrap()) / 2;
          positions.iter()
            .find(|&&pos| (pos as i32 - center as i32).abs() <= 1)
            .copied()
            .unwrap_or(center)
        };

        // Step 5: Build parent line centered above the branch center
        let parent_str = format!("{}", constituent);
        let parent_width = parent_str.len();
        let parent_start = if branch_center >= parent_width / 2 {
          branch_center - parent_width / 2
        } else {
          0
        };

        let mut parent_line = " ".repeat(parent_start);
        parent_line.push_str(&parent_str);

        // Ensure parent line is at least as wide as the branch line will be
        while parent_line.len() < total_width {
          parent_line.push(' ');
        }

        // Step 6: Build branch line
        let mut result = vec![parent_line];

        if positions.len() == 1 {
          // Single child: just one vertical line from parent to child
          let mut branch_line = String::new();
          for i in 0..total_width {
            if i == branch_center {
              branch_line.push('│');
            } else {
              branch_line.push(' ');
            }
          }
          result.push(branch_line);
        } else {
          // Multiple children: ┌──┬──┐ structure
          let mut branch_chars: Vec<char> = vec![' '; total_width];
          let first_pos = positions[0];
          let last_pos = *positions.last().unwrap();

          // Build standard branch structure with child connectors
          for i in 0..total_width {
            if i == first_pos {
              branch_chars[i] = '┌';
            } else if i == last_pos {
              branch_chars[i] = '┐';
            } else if positions.contains(&i) {
              branch_chars[i] = '┬';
            } else if i > first_pos && i < last_pos {
              branch_chars[i] = '─';
            }
          }

          // Add parent connector at branch center
          // branch_center is already snapped to nearby child if applicable
          if positions.contains(&branch_center) {
            // Parent aligns with a child → ┼ (4-way connector)
            branch_chars[branch_center] = '┼';
          } else {
            // Parent between children → ┴ (3-way: up + left + right, no child below)
            branch_chars[branch_center] = '┴';
          }

          result.push(branch_chars.iter().collect());
        }

        // Step 7: Add child lines below

        // Step 9: Merge child lines horizontally
        let max_child_height = child_lines.iter().map(|l| l.len()).max().unwrap_or(0);
        for row in 0..max_child_height {
          let mut line = String::new();
          for (i, child_line_set) in child_lines.iter().enumerate() {
            let text = if row < child_line_set.len() {
              child_line_set[row].clone()
            } else {
              " ".repeat(child_widths[i])
            };
            line.push_str(&format!("{:width$}", text, width = child_widths[i]));
            if i < children.len() - 1 {
              line.push_str("  ");
            }
          }
          result.push(line);
        }

        result
      }
    }
  }
}

impl<T, U> fmt::Display for SynTree<T, U>
where
  T: fmt::Display,
  U: fmt::Display,
{
  fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
    match self {
      Self::Leaf(t) => write!(f, "{}", t),
      Self::Branch(t, ts) => {
        write!(f, "({}", t)?;
        if ts.len() == 1 {
          write!(f, " ({}))", ts[0])
        } else {
          for t in ts.iter() {
            // TODO: is there a nice way to do this that doesn't allocate a String?
            let fmt = format!("{}", t);
            for line in fmt.lines() {
              write!(f, "\n  {}", line)?;
            }
          }
          write!(f, ")")
        }
      }
    }
  }
}
