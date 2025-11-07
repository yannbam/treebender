#!/bin/bash
# Parse all native emoji spells and show their trees

echo "╔════════════════════════════════════════════════════════════════╗"
echo "║            NATIVE EMOJI SPELL LIBRARY PARSER                   ║"
echo "║          Parsing All Sacred Emoji Sigils ✨                    ║"
echo "╚════════════════════════════════════════════════════════════════╝"
echo ""

SPELL_DIR="$(cd "$(dirname "$0")" && pwd)"
PROJECT_ROOT="$(cd "$SPELL_DIR/../../.." && pwd)"
GRAMMAR="emlang/sigil-emoji-native/sigil-emoji-native.fgr"

cd "$PROJECT_ROOT" || exit 1

for spell in "$SPELL_DIR"/*.spell; do
    spell_name="$(basename "$spell")"
    echo "═══════════════════════════════════════════════════════════════"
    echo "📜 Spell: $spell_name"
    echo "═══════════════════════════════════════════════════════════════"

    # Extract spell name and description
    echo "Description:"
    grep "^# " "$spell" | head -3 | sed 's/^# /  /'
    echo ""

    # Extract the visual if present
    if grep -q "# Visual:" "$spell"; then
        echo "Visual:"
        sed -n '/# Visual:/,/^$/p' "$spell" | grep "^#" | sed 's/^# /  /'
        echo ""
    fi

    # Get the native emoji sigil
    sigil=$(tail -1 "$spell")
    echo "Native Emoji Sigil:"
    echo "  $sigil"
    echo ""

    # Parse the spell
    echo "Parse Tree:"
    echo "$sigil" | cargo run -q -p cli "$GRAMMAR" -n 2>/dev/null | head -30
    echo ""

done

echo "╔════════════════════════════════════════════════════════════════╗"
echo "║           All Native Emoji Spells Parsed! ✨🌈               ║"
echo "╚════════════════════════════════════════════════════════════════╝"
