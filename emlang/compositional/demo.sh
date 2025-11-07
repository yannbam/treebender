#!/bin/bash
# Emlang Compositional Demo
# Showcases transformer emoji and pattern matching

set -e

GRAMMAR="emlang/compositional/compositional.fgr"
TREE_FORMAT="h-tree"  # horizontal tree for readability

echo "🌳✨ EMLANG COMPOSITIONAL DEMO 🌳✨"
echo "=================================="
echo ""
echo "Phase 1A: Transformer Emoji (Higher-Order Operators)"
echo "Phase 1B: Pattern Matching (Alternation)"
echo ""

# Function to parse and display
demo() {
    local description="$1"
    local input="$2"

    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo "📝 $description"
    echo "🔤 Input: $input"
    echo ""
    echo "$input" | cargo run -q -p cli "$GRAMMAR" -f "$TREE_FORMAT" -n
    echo ""
}

# === BASELINE ===
echo "═══════════════════════════════════════════════════════════"
echo "BASELINE: Elements"
echo "═══════════════════════════════════════════════════════════"
echo ""

demo "Fire Element" "🔥"
demo "Water Element" "💧"

# === PHASE 1A: TRANSFORMERS ===
echo "═══════════════════════════════════════════════════════════"
echo "PHASE 1A: Transformer Emoji"
echo "═══════════════════════════════════════════════════════════"
echo ""

demo "Recursion on Fire" "🔄 🔥"
demo "Morph on Water" "🎭 💧"
demo "Package Air" "📦 💨"

echo "─────────────────────────────────────────────────────────"
echo "Transformers + Containers"
echo "─────────────────────────────────────────────────────────"
echo ""

demo "Recursively Amplify Fire" "🔄 ‹ 🔥 ›"
demo "Morph Stabilized Water" "🎭 ⟦ 💧 ⟧"
demo "Package Steam (Fused Fire+Water)" "📦 ❴ 🔥 plus 💧 ❵"

echo "─────────────────────────────────────────────────────────"
echo "Composed Transformers"
echo "─────────────────────────────────────────────────────────"
echo ""

demo "Recursively Package Fire" "🔄 📦 🔥"
demo "Morph Lazy Water" "🎭 🌀 💧"

echo "─────────────────────────────────────────────────────────"
echo "Ultimate: Composed Transformers + Containers"
echo "─────────────────────────────────────────────────────────"
echo ""

demo "Recursively Package Amplified Fire" "🔄 📦 ‹ 🔥 ›"
demo "Morph Lazy Stabilized Water" "🎭 🌀 ⟦ 💧 ⟧"

echo "─────────────────────────────────────────────────────────"
echo "Deep Nesting"
echo "─────────────────────────────────────────────────────────"
echo ""

demo "Recursive Amplified Steam" "🔄 ‹ ❴ 🔥 plus 💧 ❵ ›"
demo "Nested Recursive Amplification" "🎭 ‹ 🔄 ‹ 🔥 › ›"

# === PHASE 1B: PATTERNS ===
echo "═══════════════════════════════════════════════════════════"
echo "PHASE 1B: Pattern Matching"
echo "═══════════════════════════════════════════════════════════"
echo ""

demo "Pattern: Fire OR Water" "popen 🔥 por 💧 pclose"
demo "Pattern: Fire OR Water OR Air" "popen 🔥 por 💧 por 💨 pclose"

# === INTEGRATION ===
echo "═══════════════════════════════════════════════════════════"
echo "INTEGRATION: Transformers + Patterns"
echo "═══════════════════════════════════════════════════════════"
echo ""

demo "Recursion on Pattern" "🔄 popen 🔥 por 💧 pclose"
demo "Package a Pattern" "📦 popen 🔥 por 💧 por 💨 pclose"

# === FINALE ===
echo "═══════════════════════════════════════════════════════════"
echo "FINALE: Maximum Compositional Depth"
echo "═══════════════════════════════════════════════════════════"
echo ""

demo "The Ultimate Expression" "🔄 📦 ‹ ❴ 🔥 plus 💧 plus 💨 ❵ ›"

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "🎉 Demo Complete! 🎉"
echo ""
echo "This demonstrates:"
echo "  ✓ 8 transformer emoji as higher-order operators"
echo "  ✓ Transformers composing with elements and containers"
echo "  ✓ Multiple transformers chaining together"
echo "  ✓ Pattern matching with alternation"
echo "  ✓ Deep nesting and compositional semantics"
echo ""
echo "May your transformations be elegant! 🌳✨"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
