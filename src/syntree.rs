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

  /// Format the tree as Unicode box-drawing with branches at the bottom
  pub fn format_unicode(&self) -> String
  where
    T: fmt::Display,
    U: fmt::Display,
  {
    let mut output = String::new();
    self.format_unicode_helper(&mut output, 0);
    output
  }

  fn format_unicode_helper(&self, output: &mut String, depth: usize)
  where
    T: fmt::Display,
    U: fmt::Display,
  {
    match self {
      Self::Leaf(word) => {
        output.push_str(&"  ".repeat(depth));
        output.push_str(&format!("{}\n", word.value));
      }
      Self::Branch(constituent, children) => {
        output.push_str(&"  ".repeat(depth));
        output.push_str(&format!("{}\n", constituent));

        if !children.is_empty() {
          // Draw the branches
          output.push_str(&"  ".repeat(depth));
          let num_children = children.len();

          if num_children == 1 {
            output.push_str("│\n");
          } else {
            // Draw the connectors: ┌─┬─┬─┐
            for i in 0..num_children {
              if i == 0 {
                output.push_str("┌─");
              } else if i == num_children - 1 {
                output.push_str("┐");
              } else {
                output.push_str("┬─");
              }
            }
            output.push('\n');
          }

          // Recursively format children
          for child in children {
            child.format_unicode_helper(output, depth + 1);
          }
        }
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
