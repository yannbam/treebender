# EMLANG COMPOSITIONAL GRAMMAR REFACTORING STRATEGY

**Date**: 2025-11-08
**Grammar Version**: compositional.fgr (767 lines)
**Target**: Reduce repetitive patterns by 67% using treebender rewrite rules
**Outcome**: More elegant, maintainable grammar preserving all functionality

---

## Executive Summary

The compositional.fgr grammar contains **~200 lines of highly repetitive cross-product enumerations** that can be elegantly consolidated using treebender's rewrite rule capabilities. By introducing intermediate non-terminals that abstract common patterns, we can:

- **Reduce repetitive code by 67%** (199 lines → 65 lines)
- **Improve maintainability dramatically** (adding new features becomes trivial)
- **Preserve all functionality** (identical parse trees and semantics)
- **Align with feature grammar best practices** (like dative-shift.fgr pattern)

This document provides the complete technical strategy for this refactoring.

---

## Core Insight: Rewrite Rules as Abstraction

**The Pattern**: Throughout treebender examples (especially `dative-shift.fgr`), we see the power of intermediate non-terminals:

```fgr
V -> Vbare
V -> Vdative

Vdative -> Vbare
```

This simple pattern eliminates the need to enumerate every verb twice. The **same technique scales** to our grammar's cross-product enumerations.

**Our Application**: Everywhere we have:
```fgr
A -> X1 Y1
A -> X1 Y2
A -> X1 Y3
A -> X2 Y1
A -> X2 Y2
A -> X2 Y3
```

We can write:
```fgr
X_Type -> X1
X_Type -> X2
X_Type -> X3

Y_Type -> Y1
Y_Type -> Y2
Y_Type -> Y3

A -> X_Type Y_Type
```

This is **computational compositionality captured in grammar rules**.

---

## Pattern Analysis & Consolidation Strategies

### Pattern 1: Annotated Structures Cross-Product
**Location**: Lines 36-101
**Current**: 66 lines of explicit marker × structure combinations
**Target**: 13 lines using marker abstractions
**Reduction**: 80%

#### Current State
Every linguistic marker (Evidential, Honorific, Modal, etc.) is explicitly combined with every structure type:

```fgr
// 6 rules for AnnotatedContainer
AnnotatedContainer -> Evidential Container
AnnotatedContainer -> Honorific Container
AnnotatedContainer -> Modal Container
AnnotatedContainer -> Aspectual Container
AnnotatedContainer -> Directional Container
AnnotatedContainer -> SemanticRole Container

// 8 rules for AnnotatedElement (includes Element-specific markers)
AnnotatedElement -> Evidential Element
AnnotatedElement -> Honorific Element
AnnotatedElement -> Modal Element
AnnotatedElement -> Aspectual Element
AnnotatedElement -> Directional Element
AnnotatedElement -> Attunement Element
AnnotatedElement -> Animacy Element
AnnotatedElement -> SemanticRole Element

// Similar patterns for AnnotatedPattern (6 rules)
// and AnnotatedTransformed (28 rules)
```

#### Refactoring Strategy

**Step 1**: Create marker hierarchy
```fgr
// === MARKER ABSTRACTION ===
// Common markers that apply to most structures
CommonMarker -> Evidential
CommonMarker -> Honorific
CommonMarker -> Modal
CommonMarker -> Aspectual
CommonMarker -> Directional
CommonMarker -> SemanticRole

// Element-specific markers extend common markers
ElementMarker -> CommonMarker
ElementMarker -> Attunement
ElementMarker -> Animacy
```

**Step 2**: Consolidate annotation rules
```fgr
// === CONSOLIDATED ANNOTATION RULES ===
AnnotatedContainer -> CommonMarker Container
AnnotatedElement -> ElementMarker Element
AnnotatedPattern -> CommonMarker Pattern

// For transformed structures, create transform type abstraction
TransformType -> TransformedElement
TransformType -> TransformedContainer
TransformType -> TransformedQuotation
TransformType -> ComposedTransform

AnnotatedTransformed -> CommonMarker TransformType
```

**Impact**: 66 lines → 13 lines

**Benefit**: Adding a new linguistic marker now requires **1 line** instead of 10+

---

### Pattern 2: PatternContent Combinatorial Explosion
**Location**: Lines 266-339
**Current**: 74 lines of systematic X POr Y combinations
**Target**: 14 lines using Matchable abstraction
**Reduction**: 81%

#### Current State
Every structure type that can appear in patterns must be explicitly combined with `POr`:

```fgr
// Element combinations (6 rules)
PatternContent -> Element POr Element
PatternContent -> Element POr PatternContent
PatternContent -> Element POr Container
PatternContent -> Container POr Element
// etc.

// This pattern repeats for:
// - Container (6 rules)
// - Composite (6 rules)
// - TransformedElement (6 rules)
// - TransformedContainer (6 rules)
// - ComposedTransform (8 rules)
// - Pattern (6 rules)
// - AnnotatedContainer (6 rules)
// - PowerElement (5 rules)
```

#### Refactoring Strategy

**Key Insight**: Create a `Matchable` non-terminal representing **anything that can appear in a pattern**. Then define pattern content rules **once** using `Matchable`.

```fgr
// === MATCHABLE ABSTRACTION ===
// Anything that can appear in a pattern is Matchable
Matchable -> Element
Matchable -> AnnotatedElement
Matchable -> Container
Matchable -> AnnotatedContainer
Matchable -> Composite
Matchable -> TransformedElement
Matchable -> TransformedContainer
Matchable -> TransformedQuotation
Matchable -> ComposedTransform
Matchable -> Pattern              // meta-matching
Matchable -> PowerElement

// === CONSOLIDATED PATTERN CONTENT ===
PatternContent -> Matchable POr Matchable
PatternContent -> Matchable POr PatternContent
```

**Why This Works**: The recursive second rule handles all combinations!
- `A POr (B POr C)` expands to: A or (B or C)
- Feature unification still constrains what can actually match
- We get the full cross-product for free through recursion + alternation

**Impact**: 74 lines → 14 lines

**Benefit**: Adding a new matchable structure requires **1 line** instead of 15+

---

### Pattern 3: Pattern Can-Match Enumeration
**Location**: Lines 565-583
**Current**: 19 lines of manual type permutations
**Target**: 12 lines using feature propagation
**Reduction**: 37%

#### Current State
Explicit enumeration of which patterns can match which element types:

```fgr
// Manual enumeration of all combinations
Pattern[ can_match: fire ] -> POpen Element[ type: fire ] POr Element[ type: water ] PClose
Pattern[ can_match: water ] -> POpen Element[ type: fire ] POr Element[ type: water ] PClose

Pattern[ can_match: fire ] -> POpen Element[ type: water ] POr Element[ type: fire ] PClose
Pattern[ can_match: water ] -> POpen Element[ type: water ] POr Element[ type: water ] PClose

// Three-element patterns - all combinations
Pattern[ can_match: fire ] -> POpen Element[ type: fire ] POr Element[ type: water ] POr Element[ type: air ] PClose
// ... etc
```

#### Refactoring Strategy

**Key Insight**: Use **feature tag unification** to let the parser figure out what can match! Instead of manual enumeration, propagate features upward.

```fgr
// === ELEGANT PATTERN MATCHING VIA FEATURES ===

// Pattern extracts can_match from its content
Pattern[ can_match: #t ] -> POpen PatternContent[ can_match: #t ] PClose

// PatternContent for Elements - extracts the type
PatternContent[ can_match: #t ] -> Element[ type: #t ]

// PatternContent for alternation - can match EITHER alternative
// Use multiple productions for each possibility
PatternContent[ can_match: #t1 ] -> Element[ type: #t1 ] POr Element[ type: #t2 ]
PatternContent[ can_match: #t2 ] -> Element[ type: #t1 ] POr Element[ type: #t2 ]

// Recursive case - can match what the continuation can match
PatternContent[ can_match: #t ] -> Element[ type: #t1 ] POr PatternContent[ can_match: #t ]

// For non-Element matchables, use structural matching
PatternContent[ can_match: container ] -> Container
PatternContent[ can_match: composite ] -> Composite
// etc.
```

**Impact**: 19 lines → ~12 lines

**Benefit**: This approach **scales automatically** to new element types! No need to enumerate all combinations manually.

---

### Pattern 4: Contents Recursion
**Location**: Lines 372-383
**Current**: 12 lines of boilerplate (each type appears twice)
**Target**: 8 lines using ContentItem abstraction
**Reduction**: 33%

#### Current State
```fgr
Contents -> Element
Contents -> Element Contents
Contents -> Container
Contents -> Container Contents
Contents -> TransformedElement
Contents -> TransformedElement Contents
// ... etc (6 types × 2 rules each)
```

#### Refactoring Strategy
```fgr
// === CONTENT ITEM ABSTRACTION ===
ContentItem -> Element
ContentItem -> Container
ContentItem -> TransformedElement
ContentItem -> TransformedContainer
ContentItem -> AnnotatedElement
ContentItem -> AnnotatedContainer

// === CONSOLIDATED CONTENTS ===
Contents -> ContentItem
Contents -> ContentItem Contents
```

**Impact**: 12 lines → 8 lines

---

### Pattern 5: CompTarget Enumeration
**Location**: Lines 682-695
**Current**: 14 lines of explicit enumeration
**Target**: 10 lines using TargetStructure abstraction
**Reduction**: 29%

#### Refactoring Strategy
```fgr
// === TARGET ABSTRACTION ===
TargetStructure -> Element
TargetStructure -> Container
TargetStructure -> Pattern
TargetStructure -> TransformedElement
TargetStructure -> TransformedContainer
TargetStructure -> ComposedTransform
TargetStructure -> PowerElement
TargetStructure -> AnnotatedElement
TargetStructure -> AnnotatedContainer

// === CONSOLIDATED COMP TARGET ===
CompTarget[ applies_to: #type ] -> TargetStructure
```

**Impact**: 14 lines → 10 lines

---

### Pattern 6: FusedContents Operators
**Location**: Lines 388-401
**Current**: 14 lines of operator combinations
**Target**: 8 lines using Fuseable abstraction
**Reduction**: 43%

#### Refactoring Strategy
```fgr
// === FUSEABLE ABSTRACTION ===
Fuseable -> Element
Fuseable -> Container
Fuseable -> AnnotatedElement
Fuseable -> TransformedElement
Fuseable -> PowerElement

// === CONSOLIDATED FUSED CONTENTS ===
FusedContents -> Fuseable
FusedContents -> Fuseable Operator Fuseable
FusedContents -> Fuseable Operator Fuseable Operator Fuseable
```

**Impact**: 14 lines → 8 lines

---

## Consolidation Impact Summary

| Pattern | Current | Refactored | Saved | % Reduction |
|---------|---------|------------|-------|-------------|
| Annotated Structures | 66 | 13 | 53 | 80% |
| PatternContent | 74 | 14 | 60 | 81% |
| Pattern Can-Match | 19 | 12 | 7 | 37% |
| Contents Recursion | 12 | 8 | 4 | 33% |
| CompTarget | 14 | 10 | 4 | 29% |
| FusedContents | 14 | 8 | 6 | 43% |
| **TOTAL** | **199** | **65** | **134** | **67%** |

**Overall Grammar Impact**:
- Current grammar: 767 lines
- After refactoring: ~633 lines
- Total reduction: 134 lines (17% of total)

**More importantly**: Dramatically improved maintainability and elegance!

---

## Implementation Methodology

### Phase 1: Setup & Validation (Safety First)
1. **Create working copy**: `compositional-refactored.fgr`
2. **Establish baseline**: Run all tests on original grammar
3. **Set up comparison harness**: Script to verify equivalence

### Phase 2: Incremental Refactoring (One Pattern at a Time)

**Order of Implementation** (simplest → most complex):

1. ☞ **Contents** (simplest, no features)
   - Minimal risk, builds confidence
   - Clear abstraction with no feature complexity

2. **CompTarget** (similar to Contents)
   - Same pattern, still low risk

3. **FusedContents** (operators, but no complex features)
   - Straightforward abstraction

4. **AnnotatedStructures** (biggest impact, moderate complexity)
   - Most lines saved (80% reduction)
   - Requires careful marker hierarchy design
   - Test feature propagation thoroughly

5. **PatternContent** (complex recursion)
   - Most complex pattern (81% reduction)
   - Verify recursive expansion generates all combinations
   - Test with various pattern depths

6. **Pattern can-match** (feature unification changes)
   - Most semantic change (automatic vs manual matching)
   - Verify feature tag propagation
   - Test with all element type combinations

**After Each Step**:
- Run full test suite
- Verify parse trees match original
- Test edge cases manually
- Commit with descriptive WIP message

### Phase 3: Comprehensive Validation

**Testing Strategy**:
1. **Automated tests**: All existing test files must pass
2. **Parse tree comparison**: Verify identical structures
3. **Feature structure comparison**: Check feature DAGs match
4. **Negative tests**: Ensure invalid expressions still fail
5. **Edge cases**: Test complex nested structures
6. **Performance**: Benchmark parsing speed

**Acceptance Criteria**:
- ✅ All positive tests produce identical parse trees
- ✅ All negative tests produce 0 parses (semantic violations still caught)
- ✅ Feature unification behaves identically
- ✅ Performance is similar or better
- ✅ Grammar is 67% more concise in repetitive sections

### Phase 4: Finalization

1. **Backup original**: Save as `compositional-original-backup.fgr`
2. **Replace**: Move refactored version to `compositional.fgr`
3. **Documentation**: Update grammar documentation with new patterns
4. **Commit**: Comprehensive commit message explaining refactoring

---

## Risk Analysis & Mitigation

### Risk 1: Feature Propagation Changes
**Concern**: Intermediate non-terminals might affect feature unification in unexpected ways

**Mitigation**:
- Test extensively with feature-heavy expressions
- Use `#t` tags liberally to ensure proper propagation
- Compare feature DAGs between old and new grammars for identical expressions
- Pay special attention to `can_match`, `applies_to`, and `type` features

**Test Cases**:
- Annotated structures with multiple markers
- Nested patterns with type constraints
- Complex compositions with feature restrictions

### Risk 2: Parser Performance
**Concern**: More productions might slow down Earley parser

**Mitigation**:
- Benchmark before/after on representative inputs
- Intermediate non-terminals often **improve** Earley parser efficiency (fewer states)
- Expect similar or better performance due to reduced rule count

**Benchmark Suite**:
- Simple expressions (< 10 tokens)
- Medium expressions (10-50 tokens)
- Complex nested structures (50+ tokens)

### Risk 3: Error Messages Less Clear
**Concern**: Abstraction might make parse failures harder to understand

**Mitigation**:
- Test negative cases carefully (expressions that should fail)
- Ensure semantic violations still produce 0 parses
- May be acceptable trade-off for elegance and maintainability

**Test Cases**:
- Type mismatches
- Invalid marker combinations
- Malformed pattern syntax

### Risk 4: Semantic Changes from Abstraction
**Concern**: Consolidation might inadvertently change what's accepted/rejected

**Mitigation**:
- Careful analysis before each consolidation
- Verify abstractions cover exactly the same cases
- Test boundary cases where acceptance might differ

**Critical Verification**:
- Original: N explicit rules accepting specific combinations
- Refactored: Abstraction must generate **exactly** those N combinations
- Use parse tree comparison to verify equivalence

---

## Design Philosophy Alignment

This refactoring perfectly aligns with treebender's design principles (from PARADIGM-SHIFT.md):

### 1. Pure Grammar Techniques
Using rewrite rules and intermediate non-terminals (like `Vdative -> Vbare`) rather than external mechanisms.

### 2. Feature Tag Unification
Leveraging `#t` tags for automatic type checking and propagation instead of manual enumeration.

### 3. Multiple Productions
Each intermediate non-terminal expands to multiple alternatives, allowing the parser to explore all possibilities.

### 4. Compositionality
Abstraction maintains compositional semantics - complex structures compose from simpler ones in principled ways.

---

## Expected Outcomes

### Quantitative
- **67% reduction** in repetitive code sections
- **17% overall reduction** in grammar size
- **134 lines** saved from manual enumeration
- **Same or better** parser performance

### Qualitative
- **Dramatically improved maintainability**
  - Adding new linguistic marker: 1 line instead of 10+
  - Adding new matchable structure: 1 line instead of 15+
  - Adding new element type: automatic pattern matching

- **Better code organization**
  - Clear abstraction hierarchy
  - Patterns grouped by semantic purpose
  - Reduced visual clutter

- **Educational value**
  - Showcases advanced grammar techniques
  - Demonstrates power of feature grammars
  - Serves as reference for future language design

- **Preserved functionality**
  - All capabilities intact
  - Identical parse trees
  - Same feature structures

---

## Success Criteria

The refactoring is considered successful when:

1. ✅ **All tests pass**: Original test suite runs identically on refactored grammar
2. ✅ **Parse trees identical**: Same expressions produce same parse structures
3. ✅ **Features preserved**: Feature unification behaves identically
4. ✅ **Reduction achieved**: At least 60% reduction in repetitive sections
5. ✅ **Performance maintained**: Parsing speed within 10% of original
6. ✅ **Code review approved**: Grammar is more readable and maintainable

---

## Implementation Notes

### Organizational Structure

The refactored grammar should be organized into clear sections:

```fgr
// === CORE ABSTRACTIONS ===
// Define all intermediate non-terminals first

// === MARKERS ===
// Linguistic marker abstractions

// === STRUCTURES ===
// Structure type abstractions

// === MATCHABLES ===
// Pattern matching abstractions

// === GRAMMAR RULES ===
// Actual grammar productions using abstractions

// === FEATURE PROPAGATION ===
// Rules with feature tag unification

// === DICTIONARY ===
// Lexicon (unchanged)
```

### Commenting Strategy

Add strategic comments to explain the abstraction pattern:

```fgr
// === MARKER ABSTRACTION ===
// Instead of enumerating CommonMarker × Container, CommonMarker × Element, etc.,
// we define CommonMarker once and combine it with structure types.
// This is the rewrite rule pattern from dative-shift.fgr applied to our grammar.

CommonMarker -> Evidential
CommonMarker -> Honorific
// ... etc
```

### Version Control Strategy

- **Commit 1**: Create refactored file and test harness
- **Commit 2-7**: Each consolidation pattern (WIP commits)
- **Commit 8**: Final validation and documentation
- **Commit 9**: Replace original with refactored version

Each commit message should include:
- Which pattern was refactored
- Line count before/after
- Test status (all passing)

---

## Future Extensions

This refactoring opens doors for future enhancements:

### 1. New Features with Minimal Code
- **New linguistic marker**: Add 1 line to CommonMarker
- **New structure type**: Add 1 line to Matchable
- **New element type**: Automatic pattern matching via feature unification

### 2. Further Meta-Patterns
Could we abstract even higher? Possibilities:
- Meta-rule for "anything that can be annotated"
- Meta-rule for "anything that can be transformed"
- Recursive pattern matching abstraction

### 3. Grammar Generators
The abstraction patterns could inform tools that generate grammar rules from specifications:
- Define markers, generate annotation rules automatically
- Define structures, generate matching rules automatically

---

## Conclusion

This refactoring transforms compositional.fgr from a **verbose enumeration** into an **elegant meta-grammar** that better showcases the power of feature grammars.

By applying treebender's core techniques systematically:
- Rewrite rules for abstraction
- Feature tag unification for type safety
- Multiple productions for compositionality

We achieve:
- **67% reduction** in repetitive code
- **Dramatically improved maintainability**
- **Preserved functionality**
- **Better alignment** with treebender idioms

The grammar becomes not just more concise, but more **conceptually clear** - the abstractions reveal the underlying structure of the language more transparently.

---

**Ready to proceed with implementation following this strategy!** 🌳✨
