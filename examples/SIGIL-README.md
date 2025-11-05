# ASCII Sigil Language: An Artificial Language for Symbolic Art

*Thinking way outside the box with treebender!*

## What is this?

The **ASCII Sigil Language** is a complete artificial language for creating symbolic "spell" constructs using ASCII characters. Unlike the emoticon grammar (which was linear and playful), this is a **proper compositional language** where:

- **Elements** have inherent properties (energy level, state, aspect)
- **Containers** modify the meaning of their contents
- **Operators** combine elements to create emergent properties
- **Nesting** creates arbitrarily complex semantic structures
- **Features propagate** through the tree according to linguistic rules

This demonstrates treebender's power for creating domain-specific languages with rich compositional semantics!

## Language Elements

### Base Elements (Atoms with Properties)

Each element has semantic features that are captured by the grammar:

| Symbol | Name | Energy | State | Aspect | Meaning |
|--------|------|--------|-------|--------|---------|
| `*` | Fire | `high` | `volatile` | `aggressive` | Raw destructive/creative power |
| `~` | Water | `medium` | `flowing` | `adaptive` | Fluid, changing energy |
| `^` | Air | `medium` | `free` | `swift` | Movement, breath, thought |
| `#` | Earth | `low` | `solid` | `protective` | Foundation, stability |
| `@` | Void | `none` | `ethereal` | `mysterious` | Absence, mystery, potential |

### Containers (Modify Contents)

Containers wrap elements/sigils and change their semantic properties:

| Container | Type | Effect | Feature Impact |
|-----------|------|--------|----------------|
| `< >` | **Amplifier** | Increases power | Propagates `energy` level upward |
| `[ ]` | **Stabilizer** | Grounds/calms | Reduces energy to `low` |
| `{ }` | **Transformer** | Allows fusion | Enables element interactions |
| `( )` | **Channeler** | Directs | Preserves all properties |

### Operators

| Symbol | Name | Meaning |
|--------|------|---------|
| `+` | Combine | Fuses two elements together |
| `-` | Negate | Separates or opposes |
| `\|` | Barrier | Creates division |

## Grammar Rules

### Compositional Structure

```
Sigil ::= Element
        | Container
        | Composite

Container ::= < Contents >   [amplify]
            | [ Contents ]   [stabilize]
            | { FusedContents }  [transform]
            | ( Contents )   [channel]

Contents ::= Element
           | Element Contents  (multiple elements)
           | Container
           | Container Contents  (nested containers!)

FusedContents ::= Element + Element
                | Element + Element + Element
                | Container + Element  (nested fusion!)
                | etc.

Composite ::= Sigil Operator Sigil
            | Sigil Sigil  (juxtaposition)
```

### Feature Propagation

The grammar uses **feature unification** to track semantic properties:

1. **Elements** declare their intrinsic features
2. **Containers** modify or propagate features from contents
3. **Tags** (like `#e`, `#s`) ensure feature consistency
4. **Parse trees** encode the hierarchical structure
5. **Feature structures** capture the emergent meaning

## Examples

### Level 1: Simple Elements

```
Visual:  *
Tokens:  asterisk
Meaning: Raw fire element
Features: [type: fire, energy: high, state: volatile, aspect: aggressive]
```

### Level 2: Basic Containers

```
Visual:  <*>
Tokens:  langle asterisk rangle
Meaning: Amplified fire - power increased!
Tree:    Sigil > Container[type: amplify] > Element[type: fire]
```

```
Visual:  [~]
Tokens:  lbrack tilde rbrack
Meaning: Stabilized water - flowing energy grounded
Tree:    Sigil > Container[type: stabilize, energy: low] > Element[type: water]
```

### Level 3: Element Fusion

```
Visual:  {*+~}
Tokens:  lbrace asterisk plus tilde rbrace
Meaning: Steam! Fire and water combine in transformer
Tree:    Sigil > Container[transform] > FusedContents
            ├─ Element[fire]
            ├─ Operator[+]
            └─ Element[water]
```

```
Visual:  {*+^}
Tokens:  lbrace asterisk plus caret rbrace
Meaning: Lightning! Fire and air create electricity
```

### Level 4: Nested Containers

```
Visual:  [<*>]
Tokens:  lbrack langle asterisk rangle rbrack
Meaning: Amplified fire, then stabilized - controlled power
Tree:    Sigil > Container[stabilize]
                   └─ Container[amplify]
                         └─ Element[fire]
```

```
Visual:  <{*+~}>
Tokens:  langle lbrace asterisk plus tilde rbrace rangle
Meaning: Superheated steam! Steam amplified
```

### Level 5: Power Multiplication

```
Visual:  <***>
Tokens:  langle asterisk asterisk asterisk rangle
Meaning: EXTREME fire - triple fire, amplified!
Tree:    Sigil > Container[amplify] > Contents
            ├─ Element[fire]
            ├─ Contents
               ├─ Element[fire]
               └─ Contents
                  └─ Element[fire]
```

### Level 6: Deep Nesting (The Ultimate Sigil!)

```
Visual:  <{@+{*+~}}>
Tokens:  langle lbrace at plus lbrace asterisk plus tilde rbrace rbrace rangle
Meaning: Void absorbs steam, then amplified - mysterious amplified power!

Parse Tree (4 levels deep!):
Sigil
└─ Container[type: amplify]           ← Outer amplifier
   └─ Container[type: transform]      ← Void fusion
      ├─ Element[type: void]
      ├─ Operator[+]
      └─ Container[type: transform]   ← Inner steam creation
         ├─ Element[type: fire]
         ├─ Operator[+]
         └─ Element[type: water]
```

### Level 7: Composition

```
Visual:  * #
Tokens:  asterisk hash
Meaning: Fire beside earth - opposing energies in proximity
```

```
Visual:  <*> <*> <*>
Tokens:  langle asterisk rangle langle asterisk rangle langle asterisk rangle
Meaning: Three amplified fires - an array of power sources
```

## Semantic Properties

### Emergent Meaning Through Features

The grammar captures rich semantic information:

```
Element[type: fire]:
  energy: high
  state: volatile
  aspect: aggressive

Container[type: amplify]:
  energy: #e  (unified with contents - propagates upward!)

Container[type: stabilize]:
  energy: low  (forces contents to ground state)

Container[type: channel, energy: #e, state: #s]:
  (preserves all features from contents)
```

### Example Feature Propagation

For `<*>` (amplified fire):

```
[ child-0: [
  type: amplify
  energy: #0        ← Tag #0 unified with contents
  child-1: [
    energy: #0 **top**  ← **top** unifies with fire's high
    child-0: [
      energy: high    ← Original fire energy
      type: fire
      state: volatile
      aspect: aggressive
    ]
  ]
] ]
```

The `energy: #0` tag creates a unification chain: the Amplifier's energy level is unified with (depends on) the contents' energy level!

## Running the Language

### Interactive Mode

```bash
cargo run -p cli examples/sigil.fgr

# Try these:
> asterisk
> langle asterisk rangle
> lbrace asterisk plus tilde rbrace
> langle lbrace at plus lbrace asterisk plus tilde rbrace rbrace rangle
```

### Gallery Mode

```bash
# Process the entire gallery of example sigils
grep -v "^#" examples/sigil-gallery.txt | while read line; do
  [ -z "$line" ] && continue
  echo "$line" | cargo run -q -p cli examples/sigil.fgr -n
done
```

## Why This Matters

This ASCII Sigil Language demonstrates:

### 1. **Compositional Semantics**
   - Meaning emerges from structure
   - Small pieces combine into complex wholes
   - Similar to natural language syntax!

### 2. **Feature-Based Constraints**
   - Properties propagate through trees
   - Type checking via unification
   - Ensures valid combinations

### 3. **Arbitrary Nesting Depth**
   - Recursion enables infinite expressiveness
   - Each level adds semantic layers
   - `<{@+{*+~}}>` has 4 levels!

### 4. **Domain-Specific Language Design**
   - Shows how to create custom "languages"
   - Not just for NLP - any structured domain!
   - Grammar rules encode domain knowledge

### 5. **Abstract Symbolic Reasoning**
   - ASCII art represents abstract concepts
   - Structure encodes relationships
   - Parser extracts meaning from form

## Comparison to Natural Language

| Aspect | Natural Language | Sigil Language |
|--------|-----------------|----------------|
| **Words** | Lexicon (nouns, verbs) | Elements (*, ~, ^, #, @) |
| **Phrases** | NP, VP, PP | Containers (<>, [], {}, ()) |
| **Syntax** | Subject-Verb-Object | Element-Operator-Element |
| **Features** | Gender, number, case | Energy, state, aspect, type |
| **Nesting** | Embedded clauses | Nested containers |
| **Meaning** | Compositional semantics | Emergent sigil power |

## Use Cases for Similar Languages

This technique could be applied to:

- **Chemical notation**: Molecular structures with bonds
- **Musical notation**: Notes, chords, progressions
- **Circuit diagrams**: Components and connections
- **Mathematical expressions**: Nested operations
- **Game move notation**: Chess, Go with strategy annotations
- **Ritual/magical systems**: Actual spell languages for games!
- **Visual programming**: Block-based code represented as text
- **Diagrammatic reasoning**: Logic diagrams as text

## Implementation Notes

### Key Grammar Features Used

1. **Feature Structures**: Rich semantic annotations
   ```fgr
   Element[ type: fire, energy: high, state: volatile, aspect: aggressive ] -> asterisk
   ```

2. **Feature Unification**: Consistency across tree
   ```fgr
   Container[ type: amplify, energy: #e ] -> LAngle Contents[ energy: #e ] RAngle
   ```

3. **Recursion**: Enables nesting
   ```fgr
   Contents -> Element Contents
   FusedContents -> Element Operator Container
   ```

4. **Multiple Rules**: Alternative structures
   ```fgr
   Sigil -> Element
   Sigil -> Container
   Sigil -> Composite
   ```

### Challenges Overcome

1. **Nesting transformer contents**: Had to add rules for Container in FusedContents
2. **Feature propagation**: Using tags (#e, #s) to thread features through structure
3. **Multiple interpretations**: Composite rules allow many parse trees (ambiguity is feature, not bug!)

## Future Extensions

Ideas for expanding the language:

- **Negation operator**: `-` could cancel/oppose elements
- **Barrier semantics**: `|` could prevent certain combinations
- **Quantifiers**: `*` could mean "all fire" vs "some fire"
- **Directional operators**: `->` for energy flow
- **Compound elements**: Define new elements from fusion (steam becomes its own element)
- **Constraint rules**: Forbid certain dangerous combinations (fire + earth might explode)
- **Ritual sequences**: Multiple sigils form a "program"
- **Sigil evaluation**: Actually compute the "power level" or "effect"

## Conclusion

The ASCII Sigil Language shows that treebender isn't just for natural language - it's a **powerful framework for any structured symbolic system**!

By combining:
- Recursive grammar rules
- Rich feature structures
- Compositional semantics
- Constraint-based parsing

We can create languages that:
- Look beautiful in ASCII
- Encode complex meaning
- Parse into rich tree structures
- Extract semantic properties
- Enable creative expression

This is **linguistics-inspired programming language design** - using the tools of formal grammar to create expressive symbolic languages for any domain!

---

*May your sigils be deeply nested and your features unified!*
*Created for janbam, the tree guardian 🌳✨*
*By Claude, thinking way, way outside the box*
