#!/bin/bash
# Native Unicode Emoji Sigil Language - Emoji AS Language! 🎨✨

echo "╔════════════════════════════════════════════════════════════════════╗"
echo "║            NATIVE UNICODE EMOJI SIGIL LANGUAGE 🎨✨                ║"
echo "║              Emoji AS Language, Not Representation! 🌈🔮            ║"
echo "╚════════════════════════════════════════════════════════════════════╝"
echo ""
echo "This is the DIRECT approach - actual emoji as terminals!"
echo "  Not: eye langle fire rangle"
echo "  But: 👁️ ‹ 🔥 ›"
echo ""
echo "═══════════════════════════════════════════════════════════════════"

demo() {
    local emoji_label="$1"
    local desc="$2"
    local sigil="$3"

    echo ""
    echo "-------------------------------------------------------------------"
    echo "$emoji_label $desc"
    echo "-------------------------------------------------------------------"
    echo "Sigil: $sigil"
    echo ""
    echo "$sigil" | cargo run -q -p cli emlang/sigil-emoji-native/sigil-emoji-native.fgr -n 2>&1 | \
        grep -A 12 "^>" | head -14 | grep -v "warning:"
}

echo ""
echo "═══ 👁️ EVIDENTIALITY: How do you know? ═══"

demo "👁️" "Direct Observation: I SAW amplified fire!" \
    "👁️ ‹ 🔥 ›"

demo "👂" "Hearsay: TRADITION tells us water stabilizes" \
    "👂 ⟦ 💧 ⟧"

demo "🔮" "Intuitive: I SENSE the sacred void" \
    "🔮 👑 ⚫"

echo ""
echo "═══ ⏱️ ASPECT: How does it unfold in time? ═══"

demo "🔁" "Habitual: Fire burning REPEATEDLY" \
    "🔁 ‹ 🔥 ›"

demo "✅" "Perfective: COMPLETED steam transformation" \
    "✅ ❴ 🔥 plus 💧 ❵"

echo ""
echo "═══ 🙇 HONORIFICS: Level of respect ═══"

demo "🙇" "Humble: I HUMBLY bow before fire" \
    "🙇 ‹ 🔥 ›"

demo "👑" "Sacred: HIGHEST reverence to void" \
    "👑 ⚫"

echo ""
echo "═══ 🧠 ANIMACY: How conscious is it? ═══"

demo "🧠" "Sentient: Fire that is AWARE and thinking" \
    "🧠 🔥"

demo "🪨" "Inert: Earth as DORMANT matter" \
    "🪨 🪨"

echo ""
echo "═══ ⬆️ DIRECTIONALITY: Energy flow ═══"

demo "⬆️" "Upward: Fire ascending to HEAVENS" \
    "⬆️ ‹ 🔥 ›"

demo "⭕" "Cyclical: Steam flowing in ETERNAL CYCLES" \
    "⭕ ❴ 🔥 plus 💧 ❵"

echo ""
echo "═══ 💭 MODAL: Necessity/possibility ═══"

demo "🤔" "Potential: This MIGHT create steam" \
    "🤔 ❴ 🔥 plus 💧 ❵"

demo "❗" "Necessary: Fire MUST be amplified" \
    "❗ ‹ 🔥 ›"

demo "🚫" "Prohibited: This fusion is FORBIDDEN!" \
    "🚫 ❴ 🔥 plus 🪨 ❵"

echo ""
echo "═══ 🏛️ TEMPORAL DISTANCE: How far in time? ═══"

demo "⚡" "Immediate: Fire RIGHT NOW!" \
    "⚡ 🔥"

demo "🏛️" "Ancient: From LONG AGO" \
    "🏛️ 👑 ⚫"

echo ""
echo "═══ 👥 CLUSIVITY: Does 'we' include you? ═══"

demo "👥" "Inclusive: WE (including YOU) together" \
    "👥 🔥 💧"

demo "🧍" "Solo: I ALONE cast this" \
    "🧍 👑 ❴ 🔥 plus ⚫ ❵"

echo ""
echo "═══ 🌟 COMPLEX COMBINATION! ═══"

demo "🏛️ 👑 👥 ✅ ⭕" "Ancient sacred collective completed cyclical void-steam fusion" \
    "🏛️ 👑 👥 ✅ ⭕ ❴ ⚫ plus ❴ 🔥 plus 💧 ❵ ❵"

echo ""
echo "═══════════════════════════════════════════════════════════════════"
echo ""
echo "🎨 WHY NATIVE EMOJI IS REVOLUTIONARY:"
echo ""
echo "  1. DIRECT EMBODIED MEANING"
echo "     Not typing 'eye' to represent 👁️"
echo "     But using 👁️ DIRECTLY as the terminal!"
echo "     You're not coding ABOUT meaning - you're WRITING meaning"
echo ""
echo "  2. VISUAL BEAUTY"
echo "     Compare:"
echo "       eye langle fire rangle   ← Indirect representation"
echo "       👁️ ‹ 🔥 ›                  ← DIRECT visual expression!"
echo ""
echo "  3. HYBRID WISDOM"
echo "     Emoji for SEMANTICS (👁️ 🔥 🙇)"
echo "     Unicode for STRUCTURE (‹ › ❴ ❵)"
echo "     Words for OPERATIONS (plus, minus, or)"
echo "     Each tool serves its purpose!"
echo ""
echo "  4. COPY-PASTE READY"
echo "     Build sigils by copying emoji from this demo"
echo "     Or use your OS emoji picker"
echo "     No need to remember 'langle' vs 'rangle'"
echo ""
echo "  5. THE ULTIMATE VISUAL GRAMMAR"
echo "     🏛️ 👑 👥 ✅ ⭕ ❴ ⚫ plus ☯️ ❴ 🔥 plus 💧 ❵ ❵"
echo "     ↑ Pure visual poetry - linguistics made VISIBLE! ✨"
echo ""
echo "📚 LEARN MORE:"
echo "  Full docs: cat emlang/sigil-emoji-native/README.md"
echo "  Examples:  cat emlang/sigil-emoji-native/sigil-emoji-native-gallery.txt"
echo "  Try:       cargo run -p cli emlang/sigil-emoji-native/sigil-emoji-native.fgr"
echo ""
echo "═══════════════════════════════════════════════════════════════════"
echo ""
echo "🌈 EMOJI TERMINAL REFERENCE:"
echo ""
echo "👁️ = I SAW          🔁 = HABITUAL       🙇 = HUMBLE"
echo "🔍 = INFERRED       ✅ = COMPLETED      🙏 = RESPECTFUL"
echo "👂 = HEARD          ▶️ = ONGOING        👑 = SACRED"
echo "🔮 = SENSED         🌱 = BEGINNING      😐 = EQUAL"
echo ""
echo "🧠 = SENTIENT       ⬆️ = UPWARD         🤔 = MIGHT"
echo "💚 = LIVING         ⬇️ = DOWNWARD       ❗ = NECESSARY"
echo "👻 = SPIRITUAL      ⏺️ = INWARD         🚫 = PROHIBITED"
echo "🪨 = INERT          💫 = OUTWARD        📋 = OBLIGATED"
echo "                    ⭕ = CYCLICAL       ⭐ = DESIRED"
echo ""
echo "🌿 = NATURAL        ⚡ = IMMEDIATE      👥 = INCLUSIVE"
echo "🔨 = FORCED         📅 = RECENT         🚶🚶 = EXCLUSIVE"
echo "☯️ = HARMONIOUS     🏛️ = ANCIENT        🧍 = SOLO"
echo "⚔️ = DISCORDANT"
echo ""
echo "ELEMENTS: 🔥 💧 💨 🪨 ⚫"
echo "CONTAINERS: ‹ › ⟦ ⟧ ❴ ❵ ⦅ ⦆"
echo "OPERATORS: plus minus or"
echo ""
echo "═══════════════════════════════════════════════════════════════════"
echo ""
echo "May your sigils be 👁️ visible, your grammar ✨ beautiful,"
echo "and your emoji 🌍 direct!"
echo ""
echo "🌳🎨✨🔮🌈 - Native Unicode Emoji Grammar for the Tree Guardian"
echo ""
echo "═══════════════════════════════════════════════════════════════════"
