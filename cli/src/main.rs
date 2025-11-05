extern crate tracing_subscriber;
extern crate treebender;

use std::env;
use std::io;
use std::io::Write;
use std::process;

use tracing_subscriber::EnvFilter;

use treebender::rules::Grammar;
use treebender::Err;

#[derive(Debug, Clone, Copy, PartialEq, Eq)]
enum TreeFormat {
  SExp,  // S-expression (default)
  HTree, // Horizontal tree with box-drawing
  VTree, // Vertical tree with box-drawing
}

impl TreeFormat {
  fn from_str(s: &str) -> Result<Self, String> {
    match s.to_lowercase().as_str() {
      "sexp" | "s-exp" | "sexpr" => Ok(TreeFormat::SExp),
      "h-tree" | "htree" | "horizontal" | "ascii" | "box" => Ok(TreeFormat::HTree),
      "v-tree" | "vtree" | "vertical" | "unicode" | "uni" => Ok(TreeFormat::VTree),
      _ => Err(format!(
        "Unknown format '{}'. Valid formats: sexp, h-tree, v-tree",
        s
      )),
    }
  }
}

fn usage(prog_name: &str) -> String {
  format!(
    r"Usage: {} FILE [options]

Options:
  -h, --help         Print this message
  -c, --chart        Print the parse chart (defaults to not printing)
  -n, --no-fs        Don't print feature structures (defaults to printing)
  -f, --format FMT   Tree output format: sexp (default), h-tree, v-tree
                     - sexp: S-expression format (current default)
                     - h-tree: Horizontal tree with box-drawing (├── └── │)
                     - v-tree: Vertical tree with box-drawing (┌──┬──┐ │)",
    prog_name
  )
}

fn parse(
  g: &Grammar,
  sentence: &str,
  print_chart: bool,
  print_fs: bool,
  tree_format: TreeFormat,
) -> Result<(), Err> {
  let sentence = sentence.split(' ').collect::<Vec<_>>();

  let chart = g.parse_chart(&sentence);

  if print_chart {
    println!("chart:\n{}\n", chart);
  }

  let trees = g.parse(&sentence);

  println!(
    "Parsed {} tree{}",
    trees.len(),
    if trees.len() == 1 { "" } else { "s" }
  );

  for (t, idx, arena) in trees {
    // Print tree in selected format
    match tree_format {
      TreeFormat::SExp => println!("{}", t),
      TreeFormat::HTree => print!("{}", t.format_ascii()),
      TreeFormat::VTree => print!("{}", t.format_unicode()),
    }

    if print_fs {
      println!("{}", arena.display(idx));
    }
    println!();
  }

  Ok(())
}

struct Args {
  filename: String,
  print_fs: bool,
  print_chart: bool,
  tree_format: TreeFormat,
}

impl Args {
  fn make_error_message(msg: &str, prog_name: impl AsRef<str>) -> String {
    format!("argument error: {}.\n\n{}", msg, usage(prog_name.as_ref()))
  }

  fn parse(v: Vec<String>) -> Result<Self, String> {
    if v.is_empty() {
      return Err(Self::make_error_message(
        "bad argument vector",
        "treebender",
      ));
    }

    let args_len = v.len();
    let mut iter = v.into_iter();
    let prog_name = iter.next().unwrap();

    if args_len < 2 {
      return Err(Self::make_error_message("not enough arguments", prog_name));
    }

    let mut filename: Option<String> = None;
    let mut print_fs = true; // default to printing feature structures
    let mut print_chart = false; // default to *not* printing the chart
    let mut tree_format = TreeFormat::SExp; // default to S-expression format

    let mut iter = iter.peekable();
    while let Some(o) = iter.next() {
      if o == "-h" || o == "--help" {
        eprintln!("{}", usage(&prog_name));
        process::exit(0);
      } else if o == "-n" || o == "--no-fs" {
        print_fs = false;
      } else if o == "-c" || o == "--chart" {
        print_chart = true;
      } else if o == "-f" || o == "--format" {
        if let Some(format_str) = iter.next() {
          tree_format = TreeFormat::from_str(&format_str).map_err(|e| {
            Self::make_error_message(&e, prog_name.clone())
          })?;
        } else {
          return Err(Self::make_error_message(
            "missing format argument after -f/--format",
            prog_name,
          ));
        }
      } else if filename.is_none() {
        filename = Some(o);
      } else {
        return Err(Self::make_error_message("invalid arguments", prog_name));
      }
    }

    if let Some(filename) = filename {
      Ok(Self {
        filename,
        print_fs,
        print_chart,
        tree_format,
      })
    } else {
      Err(Self::make_error_message("missing filename", prog_name))
    }
  }
}

fn main() -> Result<(), Err> {
  let opts = match Args::parse(env::args().collect()) {
    Ok(opts) => opts,
    Err(msg) => {
      eprintln!("{}", msg);
      process::exit(255);
    }
  };

  tracing_subscriber::fmt()
    .with_env_filter(EnvFilter::from_default_env())
    .with_writer(std::io::stderr)
    .init();

  let g: Grammar = Grammar::read_from_file(&opts.filename)?;

  let mut input = String::new();
  loop {
    print!("> ");
    io::stdout().flush()?;

    match io::stdin().read_line(&mut input) {
      Ok(_) => {
        if input.is_empty() {
          // ctrl+d
          return Ok(());
        }
        input.make_ascii_lowercase();
        parse(
          &g,
          input.trim(),
          opts.print_chart,
          opts.print_fs,
          opts.tree_format,
        )?;
        input.clear();
      }
      Err(error) => return Err(error.into()),
    }
  }
}
