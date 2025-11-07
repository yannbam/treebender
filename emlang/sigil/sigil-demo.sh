#!/bin/bash
# ASCII Sigil Language - Interactive Demonstration
# Shows the power of compositional semantic parsing!

echo "╔══════════════════════════════════════════════════════════════════╗"
echo "║                    ASCII SIGIL LANGUAGE                           ║"
echo "║           An Artificial Language for Symbolic Art                 ║"
echo "╚══════════════════════════════════════════════════════════════════╝"
echo ""
echo "This language demonstrates DEEP compositional semantics:"
echo "  - Elements have inherent properties (energy, state, aspect)"
echo "  - Containers modify their contents semantically"
echo "  - Nesting creates complex emergent meaning"
echo "  - Features propagate through the parse tree"
echo ""
echo "═══════════════════════════════════════════════════════════════════"

demo_sigil() {
    local visual="$1"
    local tokens="$2"
    local meaning="$3"
    local show_features="${4:-no}"

    echo ""
    echo "-------------------------------------------------------------------"
    echo "Visual:  $visual"
    echo "Meaning: $meaning"
    echo "Tokens:  $tokens"
    echo "-------------------------------------------------------------------"

    if [ "$show_features" = "yes" ]; then
        echo "$tokens" | cargo run -q -p cli emlang/sigil/sigil.fgr 2>&1 | grep -v "warning:" | head -50
    else
        echo "$tokens" | cargo run -q -p cli emlang/sigil/sigil.fgr -n 2>&1 | grep -v "warning:" | head -30
    fi
}

echo ""
echo "═══ LEVEL 1: BASE ELEMENTS ═══"
demo_sigil "*" "asterisk" "Raw fire - volatile, aggressive energy"

echo ""
echo "═══ LEVEL 2: SIMPLE CONTAINERS ═══"
demo_sigil "<*>" "langle asterisk rangle" "Amplified fire - power increased"
demo_sigil "[~]" "lbrack tilde rbrack" "Stabilized water - flowing energy grounded"

echo ""
echo "═══ LEVEL 3: ELEMENT FUSION ═══"
demo_sigil "{*+~}" "lbrace asterisk plus tilde rbrace" "STEAM - fire and water combine!"
demo_sigil "{*+^}" "lbrace asterisk plus caret rbrace" "LIGHTNING - fire and air unite!"

echo ""
echo "═══ LEVEL 4: NESTED CONTAINERS ═══"
demo_sigil "[<*>]" "lbrack langle asterisk rangle rbrack" "Controlled power - amplified then stabilized"
demo_sigil "<{*+~}>" "langle lbrace asterisk plus tilde rbrace rangle" "Superheated steam - fusion then amplified"

echo ""
echo "═══ LEVEL 5: POWER MULTIPLICATION ═══"
demo_sigil "<***>" "langle asterisk asterisk asterisk rangle" "EXTREME FIRE - triple flames amplified!"

echo ""
echo "═══ LEVEL 6: ULTIMATE COMPLEXITY ═══"
demo_sigil "<{@+{*+~}}>" "langle lbrace at plus lbrace asterisk plus tilde rbrace rbrace rangle" \
    "Void absorbs steam, then amplified - 4 levels of nesting!" "yes"

echo ""
echo "═══════════════════════════════════════════════════════════════════"
echo ""
echo "Notice how the parse tree shows:"
echo "  - 4 levels of nesting (Sigil > Container > Container > Container)"
echo "  - Elements preserved at the deepest level"
echo "  - Each container adds semantic meaning"
echo "  - Feature structures capture properties at each level"
echo ""
echo "This demonstrates:"
echo "  ✓ Compositional semantics (meaning from structure)"
echo "  ✓ Feature propagation (properties flow through tree)"
echo "  ✓ Recursive nesting (arbitrary depth)"
echo "  ✓ Type-safe composition (grammar enforces valid combinations)"
echo ""
echo "Try it yourself:"
echo "  cargo run -p cli emlang/sigil/sigil.fgr"
echo ""
echo "Explore the gallery:"
echo "  cat emlang/sigil/sigil-gallery.txt"
echo ""
echo "Read the documentation:"
echo "  cat emlang/sigil/SIGIL-README.md"
echo ""
echo "May your sigils be deeply nested! 🌳✨"
echo "═══════════════════════════════════════════════════════════════════"
