# ASCII Art Grammar for Treebender

A playful exploration of using treebender's symbolic parsing for ASCII emoticons and decorative patterns!

## What is this?

This grammar (`ascii-art.fgr`) demonstrates how treebender can parse non-linguistic "languages" like ASCII art emoticons. It showcases:

- **Feature structures** to capture semantic meaning (mood, emotion type)
- **Recursive rules** for emphasis (multiple exclamation marks)
- **Constraint-based parsing** (you can't have just eyes or just a mouth!)

## Grammar Overview

### Emoticon Structure

Emoticons follow this basic structure:
```
Face -> Eyes [Nose] Mouth [Emphasis]
```

Where:
- **Eyes** (required): `:`, `;`, `o`, `O`
- **Nose** (optional): `-`, `^`
- **Mouth** (required): `)`, `D`, `(`, `|`, `P`
- **Emphasis** (optional, recursive): `!`, `!!`, `!!!`, ...

### Features

The grammar captures semantic information via features:

- `Eyes[type: normal|wide|caps]` - Different eye types
- `Mouth[type: smile|frown|neutral|tongue|surprised]` - Emotion in the mouth
- `Face[mood: happy|sad]` - Overall mood (when Emphasis is present, mood becomes "happy")

### Examples

#### Valid Emoticons

| ASCII | Tokens | Features | Tree Structure |
|-------|--------|----------|----------------|
| `:-)` | `colon dash rparen` | Eyes[normal], Mouth[smile] | Simple face with nose |
| `:)` | `colon rparen` | Eyes[normal], Mouth[smile] | Simple face without nose |
| `;-P` | `semi dash capp` | Eyes[normal], Mouth[tongue] | Winking with tongue |
| `:-D!` | `colon dash capd bang` | Face[mood: happy] | Big smile with excitement! |
| `:-D!!!` | `colon dash capd bang bang bang` | Face[mood: happy], recursive Emphasis | VERY excited! |
| `o(` | `oeye lparen` | Eyes[wide], Mouth[frown] | Sad with wide eyes |
| `O\|` | `ocap vbar` | Eyes[caps], Mouth[neutral] | Stoic/surprised |

#### Decorative Patterns

| ASCII | Tokens | Description |
|-------|--------|-------------|
| `*` | `asterisk` | Single star |
| `**` | `asterisk asterisk` | Multiple stars (recursive) |
| `[cool]` | `lbrack cool rbrack` | Framed content |
| `{wow}` | `lbrace wow rbrace` | Alternative brackets |

#### Invalid Combinations

The grammar enforces structural constraints:

- `:` (just eyes) → **Parsed 0 trees** ❌ - Need a mouth!
- `)` (just mouth) → **Parsed 0 trees** ❌ - Need eyes!
- `!` (just emphasis) → **Parsed 0 trees** ❌ - Can't emphasize nothing!

## How It Works

### Token Translation

ASCII characters → token names:
```
:  → colon      )  → rparen     !  → bang
;  → semi       (  → lparen     *  → asterisk
o  → oeye       D  → capd       [  → lbrack
O  → ocap       P  → capp       ]  → rbrack
-  → dash       |  → vbar       {  → lbrace
^  → caret                      }  → rbrace
```

### Parse Trees

For `:-D!` (colon dash capd bang), treebender generates:

```
(0..4: Art ((0..4: Face
  (0..1: Eyes (0..1: colon))
  (1..2: Nose (1..2: dash))
  (2..3: Mouth (2..3: capd))
  (3..4: Emphasis (3..4: bang)))))
```

### Feature Structure

The same emoticon has this feature structure:
```
[ child-0: [
  mood: happy          ← Semantic annotation!
  child-0: [
    type: normal       ← Eye type
    child-0: [ word: colon ]
  ]
  child-2: [
    type: smile        ← Mouth type
    child-0: [ word: capd ]
  ]
  child-3: [ child-0: [ word: bang ] ]
] ]
```

The `mood: happy` feature is automatically inferred by the grammar rule:
```fgr
Face[ mood: happy ] -> Eyes Nose Mouth[ type: smile ] Emphasis
```

### Recursive Structures

Emphasis can be recursive, creating a nested tree structure for `!!!`:
```
Emphasis
  ├─ bang (!)
  └─ Emphasis
      ├─ bang (!)
      └─ Emphasis
          └─ bang (!)
```

## Running the Demo

```bash
# Interactive mode
cargo run -p cli examples/ascii-art.fgr

# Try these inputs:
> colon dash rparen
> colon dash capd bang bang bang
> lbrack cool rbrack

# Run the full demo script
./examples/ascii-art-demo.sh
```

## Why This Matters

This demonstrates treebender's versatility beyond natural language:

1. **Symbolic parsing** works for any structured sequential data
2. **Features** can encode domain-specific semantics
3. **Constraints** ensure structural validity
4. **Recursion** handles variable-length patterns elegantly

While parsing emoticons is playful, the same techniques apply to:
- Programming language constructs
- Musical notation
- Chemical formulas
- Game move notation (chess, Go)
- Custom DSLs

## Grammar Design Notes

### Challenges Adapting Treebender to 2D ASCII Art

Treebender is designed for sequential token parsing (like natural language). ASCII art is inherently 2D, which presents challenges:

- **Solution**: Focus on linear patterns (emoticons) rather than 2D structures (boxes, images)
- **Future idea**: Treat each line as a token for simple 2D structures

### Feature Unification

The grammar uses treebender's feature unification to ensure consistency:
- Happy faces require `Mouth[type: smile]` + `Emphasis`
- This constraint is checked at parse time, rejecting `:-(!` as invalid

### Extensibility

Easy to extend with:
- More eye types: `*` (starry eyes), `^` (closed eyes)
- More mouths: `O` (surprised), `3` (kiss)
- New decorations: borders, arrows, simple shapes
- Compound structures: emoticon followed by text

## Conclusion

Who knew parsing `:-)` could be this sophisticated?

Thanks to treebender's powerful feature system, we can not only parse ASCII art but also extract semantic meaning (mood, emotion type) and enforce structural constraints. This showcases the flexibility of symbolic parsing beyond traditional NLP applications.

Now go forth and parse some emoticons! 🌳✨

---

*Created for the tree guardian by Claude*
*Part of the treebender examples collection*
