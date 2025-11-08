# Pattern Guards Design Document

**Status**: Initial design phase
**Session**: 5ee65491
**Date**: 2025-11-08

## 🎯 Concept: Pattern Guards

**Purpose**: Add conditional constraints to pattern matches

**Syntax idea**: `popen <pattern> guard <condition> pclose`

**Example use cases**:
```
# Only match fire if it's in amplified state
popen 🔥 guard ‹ 🔥 › pclose matches ‹ 🔥 ›  ✅
popen 🔥 guard ‹ 🔥 › pclose matches 🔥      ❌

# Only match water if it's stabilized
popen 💧 guard ⟦ 💧 ⟧ pclose matches ⟦ 💧 ⟧  ✅
popen 💧 guard ⟦ 💧 ⟧ pclose matches 💧      ❌

# Guard with transformation
popen 🔥 guard 🔄 🔥 pclose matches 🔄 🔥    ✅
```

## 🤔 Semantic Questions

**What does a guard mean?**

Option 1: **Structural constraint**
- Guard specifies a required structure
- Match succeeds only if target has that structure
- Example: `popen 🔥 guard ‹ 🔥 › pclose` = "match fire ONLY IF it's amplified"

Option 2: **Feature constraint**
- Guard specifies required features
- Match succeeds if features unify
- Example: `popen 🔥 guard high-energy pclose` = "match fire only if energy is high"

Option 3: **Context constraint**
- Guard specifies context in which match is valid
- More complex, might need evaluation engine

**☞ Recommendation: Start with Option 1 (structural constraint)**
- Most semantically clear
- Implementable via pure grammar
- Composes with existing features
- Can extend to Option 2 later if needed

## 🏗️ Grammar Approach

Following pure grammar paradigm, guards can be implemented via:

### 1. Guard Syntax

```fgr
// Guard terminals
GuardOp -> guard

// Guarded pattern: pattern with structural constraint
GuardedPattern[ pattern: #p, guard: #g ] ->
  POpen PatternContent GuardOp GuardCondition PClose

// Guard condition can be any Sigil
GuardCondition -> Element
GuardCondition -> Container
GuardCondition -> TransformedElement
GuardCondition -> Pattern
// etc.
```

### 2. Guard Matching Semantics

```fgr
// Add to top-level
Sigil -> GuardedMatch

// Guarded match: pattern with guard matches target
// Target must match BOTH the pattern AND satisfy the guard constraint
GuardedMatch[ matched: #m, guard_satisfied: true ] ->
  GuardedPattern[ pattern: #p, guard: #g ] MatchOp Sigil[ structure: #m ]
```

### 3. Constraint Checking

**Challenge**: How do we check if target "satisfies" the guard?

**Pure grammar approach**:
- Use feature unification on structure
- Guard specifies required structural property
- If target doesn't have that property, unification fails → 0 parses

**Example**:
```fgr
// Guard requiring amplified structure
GuardedPattern[ requires_amplified: true ] ->
  POpen Element[ type: fire ] GuardOp Container[ type: amplify ] PClose

// Match only succeeds if target is amplified
GuardedMatch[ satisfied: true ] ->
  GuardedPattern[ requires_amplified: true ] MatchOp Container[ type: amplify ]

// Matching plain element fails (no Container production for this)
```

## 🔬 Implementation Challenges

### Challenge 1: Multiple interpretations

A guarded pattern like `popen 🔥 guard ‹ 🔥 › pclose` could mean:
1. "Match fire, but only if it appears in amplified form"
2. "Match amplified fire specifically (redundant with nested patterns)"

**Resolution**: Guards are constraints, not alternatives
- Interpretation 1 is correct
- Guards narrow the match set, they don't expand it

### Challenge 2: Guard composition

What does this mean?
```
popen 🔥 guard ‹ 🔥 › guard 🔄 🔥 pclose
```

Multiple guards = ALL must be satisfied (AND logic)

**Grammar approach**:
```fgr
GuardCondition -> Sigil
GuardCondition -> Sigil GuardOp GuardCondition  // Chained guards
```

### Challenge 3: Guard matching vs pattern matching

Guard is not a pattern - it's a constraint!

- **Pattern**: "Match fire OR water"
- **Guard**: "Match ONLY IF amplified"

**Key difference**: Pattern offers alternatives, guard adds requirements

## 💡 Simplified Initial Approach

For MVP, start with simplest useful case:

**Simple structural guards**:
```
# Guard requiring specific container type
popen 🔥 guard ‹ 🔥 › pclose  = match only amplified fire
popen 💧 guard ⟦ 💧 ⟧ pclose  = match only stabilized water
```

**Grammar**:
```fgr
// Simple guarded element pattern
SimpleGuard[ element: #e, container: #c ] ->
  POpen Element[ type: #e ] GuardOp Container[ type: #c, contains: #e ] PClose

// Matching: target must be the specified container
GuardedMatch[ matched: #e, container: #c ] ->
  SimpleGuard[ element: #e, container: #c ] MatchOp Container[ type: #c ]
```

This creates a minimal working prototype that can be extended.

## 🎯 Next Steps

1. **Prototype simple guards** with just container constraints
2. **Test basic cases** to validate grammar approach
3. **Extend incrementally** to more complex guards
4. **Document semantics** through examples and tests

## 📝 Open Questions for janbam

1. **Semantic interpretation**: Is "guard as structural constraint" the right model?
2. **Syntax**: Is `guard` keyword good, or prefer something else?
3. **Guard chaining**: Should multiple guards be allowed?
4. **Guard scope**: Should guards work with all patterns or just simple ones?

---

*This is a living design document - collaborate through examining parse trees!* 🌳✨
