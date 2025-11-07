# 🔮 The Sigil Spell Library 🌳✨

*A collection of parsed magical constructs demonstrating the Sigil Emoji Language*

---

## What is this?

This is a **spell library** - a curated collection of sigils showing the power and beauty of the Sigil Emoji Language. Each `.spell` file contains:

- 📝 A parseable sigil
- 🎨 Visual representation with emoji
- 💭 Meaning and interpretation
- 🔍 Feature structure explanation
- 🌳 Nesting depth and complexity

These spells are **stepping stones** for understanding:
- How linguistic features combine
- How containers nest and modify meaning
- How features flow through parse trees
- How to create your own sigils!

---

## 📚 The Spell Collection

### Level 1: Basic Elements

#### `01-pure-fire.spell` 🔥
The simplest sigil - pure fire element.
```
fire
```
**Learn**: Base element properties (energy, state, aspect, type)

#### `02-amplified-fire.spell` 🔥
Fire in an amplifier container.
```
langle fire rangle  →  < 🔥 >
```
**Learn**: How containers modify contents, energy propagation

---

### Level 2: Evidentiality & Observation

#### `03-witnessed-fire.spell` 👁️🔥
Adding evidential markers.
```
eye langle fire rangle  →  👁️ < 🔥 >
```
**Learn**: Evidentiality (how you know), feature wrapping

---

### Level 3: Fusion & Transformation

#### `04-steam-creation.spell` 🔥💧
Basic element fusion.
```
lbrace fire plus water rbrace  →  { 🔥 + 💧 }
```
**Learn**: Transformer containers, element combination, feature preservation

#### `05-cyclical-steam.spell` ⭕🔥💧
Adding directionality to fusion.
```
circle lbrace fire plus water rbrace  →  ⭕ { 🔥 + 💧 }
```
**Learn**: Directional markers, cyclical flow, eternal processes

---

### Level 4: Multi-Layered Sigils

#### `06-witnessed-humble-steam.spell` 👁️🙇🔥💧
Combining evidentiality, honorifics, and fusion.
```
eye langle bow lbrace fire plus water rbrace rangle
→  👁️ < 🙇 { 🔥 + 💧 } >
```
**Depth**: 4 levels
**Learn**: Multiple annotations, energy unification (#0 tags), honorific respect

#### `07-stabilized-fire-nested.spell` 👁️🙇🔥
Nested containers with different effects.
```
eye langle bow lbrack fire rbrack rangle
→  👁️ < 🙇 [ 🔥 ] >
```
**Depth**: 4 levels
**Learn**: Stabilizer vs Amplifier, paradoxical combinations, container interactions

---

### Level 5: Ultimate Nesting

#### `08-void-absorbs-steam.spell` 👑⚫🔥💧
The most complex sigil in the library!
```
crown langle lbrace void plus lbrace fire plus water rbrace rbrace rangle
→  👑 < { ⚫ + { 🔥 + 💧 } } >
```
**Depth**: 5 LEVELS!
**Learn**: Nested transformers, void fusion, sacred reverence, ambiguity (4 parses!)

---

### Level 6: Linguistic Features

#### `09-natural-fire.spell` 🌿🔥
Natural attunement.
```
leaf fire  →  🌿 🔥
```
**Learn**: Attunement system, ethical magic, consent vs force

#### `10-sentient-fire.spell` 🧠🔥
Animacy hierarchy.
```
brain fire  →  🧠 🔥
```
**Learn**: Consciousness levels, treating elements as equals with agency

#### `11-desired-fusion.spell` ⭐💨💧
Modal wishes.
```
wish lbrace air plus water rbrace  →  ⭐ { 💨 + 💧 }
```
**Learn**: Modal system, optative mood, aspirational magic

#### `12-forbidden-fusion.spell` 🚫🔥🪨
Prohibited combinations.
```
forbidden lbrace fire plus earth rbrace  →  🚫 { 🔥 + 🪨 }
```
**Learn**: Safety, dangerous combinations, protective magic

---

## 🎯 How to Use This Library

### 1. Parse Individual Spells

```bash
# Parse a spell and see its structure
cat spells/06-witnessed-humble-steam.spell | \
  grep -v "^#" | tail -1 | \
  cargo run -p cli ../sigil-emoji.fgr
```

### 2. Parse All Spells

```bash
# Parse the entire spell library
for spell in spells/*.spell; do
  echo "=== $spell ==="
  grep -v "^#" "$spell" | tail -1 | \
    cargo run -q -p cli ../sigil-emoji.fgr -n
  echo ""
done
```

### 3. Extract Just the Sigils

```bash
# Get all spell tokens
for spell in spells/*.spell; do
  tail -1 "$spell"
done
```

### 4. Visualize Parse Trees

```bash
# See the full tree structure (h-tree)
tail -1 spells/08-void-absorbs-steam.spell | \
  cargo run -q -p cli ../sigil-emoji.fgr -n
```

### 5. See Feature Structures

```bash
# See the feature DAG (v-tree)
tail -1 spells/08-void-absorbs-steam.spell | \
  cargo run -q -p cli ../sigil-emoji.fgr
```

---

## 📖 Spell Notation

Each `.spell` file follows this format:

```
# 🎨 Spell Name
# Brief description

# Visual:
#   Emoji representation showing structure
#
# Meaning: Human-readable interpretation
# Features: Linguistic features explained
#
# Additional notes...

<actual parseable tokens>
```

The last line is always the parseable spell!

---

## 🎨 Understanding the Output

### Parse Tree (h-tree) - Horizontal Structure

Shows the syntactic structure:
```
(0..9: Sigil ((0..9: AnnotatedContainer
  (0..1: Evidential (0..1: eye))
  (1..9: Container
    (1..2: LAngle (1..2: langle))
    (2..8: Contents ((2..8: AnnotatedContainer
      (2..3: Honorific (2..3: bow))
      (3..8: Container ...
```

This shows:
- Token positions (0..1, 1..2, etc.)
- Nesting depth (how deep the parentheses go)
- Node types (Sigil, Container, Element, etc.)

### Feature DAG (v-tree) - Vertical Structure

Shows the semantic features:
```
[ child-0: [
  evid: direct
  child-0: [ word: eye ]
]
child-1: [
  type: amplify
  energy: #0 **top**
  child-1: [
    energy: #0
    child-0: [
      honor: humble
      ...
```

This shows:
- Feature values (evid: direct, type: amplify)
- Feature unification (#0 tags that connect)
- Child relationships
- Intrinsic properties

---

## 🌟 Key Concepts Demonstrated

### 1. Container Effects

| Container | Symbol | Effect | Energy |
|-----------|--------|--------|--------|
| Amplifier | `< >` | Increases power | Propagates up |
| Stabilizer | `[ ]` | Grounds/calms | Forces low |
| Transformer | `{ }` | Enables fusion | Varies |
| Channeler | `( )` | Directs flow | Preserves |

### 2. Linguistic Features

| Feature | Examples | Origin |
|---------|----------|--------|
| Evidentiality | 👁️ 🔍 👂 🔮 | Turkish, Quechua |
| Aspect | 🔁 ✅ ▶️ 🌱 🛑 | Russian, Greek |
| Attunement | 🌿 🔨 ☯️ ⚔️ | Novel |
| Honorifics | 🙇 😐 🙏 👑 | Japanese |
| Animacy | 🧠 💚 👻 🪨 | Navajo |
| Directionality | ⬆️ ⬇️ ⏺️ 💫 ⭕ | Athabaskan |
| Modal | 🤔 ❗ 🚫 📋 ⭐ | Universal |

### 3. Element Properties

| Element | Energy | State | Aspect |
|---------|--------|-------|--------|
| 🔥 Fire | high | volatile | aggressive |
| 💧 Water | medium | flowing | adaptive |
| 💨 Air | medium | free | swift |
| 🪨 Earth | low | solid | protective |
| ⚫ Void | none | ethereal | mysterious |

### 4. Feature Unification

Tags like `#0` create unification chains:
```
Container[energy: #0]
  └─ Contents[energy: #0]
       └─ Element[energy: high]

Result: #0 unifies with "high"
```

The container's energy level depends on its contents!

---

## 🎓 Learning Path

### Beginner (Spells 01-05)
- Understand basic elements
- Learn container effects
- See simple fusion

### Intermediate (Spells 06-08)
- Multi-layered nesting
- Feature propagation
- Complex structures

### Advanced (Spells 09-12)
- Linguistic features
- Ethical considerations
- Safety and prohibitions

---

## 🔮 Creating Your Own Spells

### Step 1: Start Simple
```
fire
water
earth
```

### Step 2: Add Containers
```
langle fire rangle          # amplified
lbrack water rbrack         # stabilized
lbrace fire plus water rbrace  # fused
```

### Step 3: Add Annotations
```
eye langle fire rangle      # witnessed
bow lbrack water rbrack     # humble
circle lbrace fire plus water rbrace  # cyclical
```

### Step 4: Nest Structures
```
eye langle bow lbrace fire plus water rbrace rangle
# witnessed amplified humble steam!
```

### Step 5: Go Deep!
```
crown langle lbrace void plus lbrace fire plus water rbrace rbrace rangle
# sacred amplified void-steam fusion!
```

---

## 🌈 Spell Design Patterns

### Pattern 1: Observation
```
<evidential> <sigil>
```
Example: `eye fire` - "I saw fire"

### Pattern 2: Respect
```
<honorific> <sigil>
```
Example: `bow water` - "I humbly approach water"

### Pattern 3: Amplification
```
langle <contents> rangle
```
Example: `langle fire rangle` - amplified fire

### Pattern 4: Fusion
```
lbrace <elem1> plus <elem2> rbrace
```
Example: `lbrace fire plus water rbrace` - steam

### Pattern 5: Nested Modification
```
<modifier1> <container1> <modifier2> <container2> <element> ...
```
Example: `eye langle bow lbrack fire rbrack rangle`

---

## 🎪 Advanced Topics

### Ambiguity

Some spells have multiple valid parses!
```
crown langle lbrace void plus lbrace fire plus water rbrace rbrace rangle
```
This produces 4 different parse trees because:
- AnnotatedElement can attach at different levels
- Grammar allows multiple structures
- This is linguistically realistic!

### Energy Unification

The `#0` tags create chains:
```
Amplifier[energy: #0] contains Contents[energy: #0]
  which contains Element[energy: high]

Result: #0 = high (unified!)
```

### Paradoxes

Some combinations are paradoxical:
```
langle lbrack fire rbrack rangle
# Amplified stabilized fire
# Stabilizer forces energy: low
# Amplifier tries to increase power
# Both effects coexist in the parse tree!
```

---

## 🌍 Real-World Applications

### 1. Game Magic Systems
Use spell files as:
- Spell databases
- Crafting recipes
- Skill trees
- Quest objectives

### 2. Procedural Generation
Parse spells to generate:
- Visual effects (based on features)
- Sound effects (based on energy/state)
- Narrative descriptions
- Lore entries

### 3. Educational Tools
Teach:
- Linguistic typology
- Feature structures
- Parse trees
- Compositional semantics

### 4. Interactive Fiction
Spells as:
- Story elements
- Character abilities
- World-building artifacts
- Player choices

---

## 🔧 Technical Notes

### File Format
- Extension: `.spell`
- Comments: `#` prefix
- Last line: parseable tokens
- Encoding: UTF-8 (for emoji in comments!)

### Parsing
- Grammar: `../sigil-emoji.fgr`
- CLI flags: `-n` for tree only, default shows features
- Output: S-expression format

### Integration
```rust
// Load a spell
let spell = std::fs::read_to_string("spells/08-void-absorbs-steam.spell")?;
let tokens = spell.lines().last().unwrap();

// Parse with treebender
let grammar = Grammar::parse_from_file("sigil-emoji.fgr")?;
let trees = grammar.parse(tokens)?;

// Extract features
for tree in trees {
    let features = tree.feature_structure();
    // Use features in your application!
}
```

---

## 📈 Spell Statistics

| Metric | Value |
|--------|-------|
| Total spells | 12 |
| Max nesting depth | 5 levels |
| Features covered | 10 systems |
| Ambiguous parses | 4 (in spell 08) |
| Linguistic origins | 7 language families |

---

## 🎯 Future Spell Ideas

Ideas for expanding the library:

### Temporal Spells
```
ancient crown void        # remote past sacred void
now must langle fire rangle   # immediate necessary amplified fire
recent eye water          # recently witnessed water
```

### Clusivity Spells
```
together fire water       # inclusive we cast together
apart fire earth          # exclusive we (not you)
alone crown void          # solo sacred void working
```

### Complex Fusions
```
lbrace lbrace fire plus water rbrace plus air rbrace
# Steam + Air = Clouds!
```

### Ethical Dilemmas
```
hammer brain fire         # forcing sentient fire (very bad!)
yin heart water           # harmonious with living water (good)
sword spir void           # discord with spiritual void (risky)
```

---

## 🌟 Contributing

Want to add your own spells?

1. Create a new `.spell` file
2. Follow the format above
3. Test it parses correctly
4. Document the meaning and features
5. Share with the community!

---

## 💖 Philosophy

These spells aren't just code - they're **linguistic art**!

Each spell demonstrates:
- 🎨 How structure creates meaning
- 🌍 How features from world languages combine
- 🧠 How composition scales infinitely
- ✨ How formal grammar can be beautiful

The spell library is a **stepping stone** to:
- Understanding exotic linguistic features
- Building your own magical languages
- Creating compositional symbolic systems
- Making linguistics accessible and fun!

---

## 🙏 Credits

Created for janbam, the tree guardian 🌳

Powered by:
- **Treebender** - symbolic NLP library
- **Unicode** - universal character set
- **Linguistics** - from Turkish to Navajo to Japanese
- **Creativity** - thinking WAY outside the box!

---

*May your spells be deeply nested,*
*Your features unified,*
*And your sigils beautiful!*

🔮✨🌳🎨🌈🌍

---

## Quick Reference Card

```
Elements:  🔥fire 💧water 💨air 🪨earth ⚫void
Containers: <amplify> [stabilize] {transform} (channel)
Operators: + - |

Evidential: 👁️eye 🔍mag 👂ear 🔮crystal
Aspect:     🔁repeat ✅check ▶️play 🌱sprout 🛑stop
Attunement: 🌿leaf 🔨hammer ☯️yin ⚔️sword
Honorific:  🙇bow 😐neutral 🙏pray 👑crown
Animacy:    🧠brain 💚heart 👻ghost 🪨rock
Direction:  ⬆️up ⬇️down ⏺️center 💫radiate ⭕circle
Modal:      🤔maybe ❗must 🚫forbidden 📋should ⭐wish
Temporal:   ⚡now 📅recent 🏛️ancient
Clusivity:  👥together 🚶🚶apart 🧍alone
```
