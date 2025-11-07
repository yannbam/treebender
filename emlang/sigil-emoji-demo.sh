#!/bin/bash
# Sigil Emoji Language - The Most Beautiful Symbolic Language! 🎨✨

echo "╔════════════════════════════════════════════════════════════════════╗"
echo "║                  SIGIL EMOJI LANGUAGE 🎨✨                         ║"
echo "║           Linguistics Meets Unicode Art! 🌈🔮                      ║"
echo "╚════════════════════════════════════════════════════════════════════╝"
echo ""
echo "What if grammar was VISUAL? Instead of 'vis hab hum', we use:"
echo "  👁️ 🔁 🙇 - Intuitive emoji you can SEE and FEEL!"
echo ""
echo "═══════════════════════════════════════════════════════════════════"

demo() {
    local emoji="$1"
    local desc="$2"
    local tokens="$3"

    echo ""
    echo "-------------------------------------------------------------------"
    echo "$emoji $desc"
    echo "-------------------------------------------------------------------"
    echo "Tokens: $tokens"
    echo ""
    echo "$tokens" | cargo run -q -p cli examples/sigil-emoji.fgr -n 2>&1 | \
        grep -A 12 "^>" | head -14 | grep -v "warning:"
}

echo ""
echo "═══ 👁️ EVIDENTIALITY: How do you know? ═══"

demo "👁️" "Direct Observation: I SAW amplified fire!" \
    "eye langle fire rangle"

demo "👂" "Hearsay: TRADITION tells us water stabilizes" \
    "ear lbrack water rbrack"

demo "🔮" "Intuitive: I SENSE the sacred void" \
    "crystal crown void"

echo ""
echo "═══ ⏱️ ASPECT: How does it unfold in time? ═══"

demo "🔁" "Habitual: Fire burning REPEATEDLY" \
    "repeat langle fire rangle"

demo "✅" "Perfective: COMPLETED steam transformation" \
    "check lbrace fire plus water rbrace"

echo ""
echo "═══ 🙇 HONORIFICS: Level of respect ═══"

demo "🙇" "Humble: I HUMBLY bow before fire" \
    "bow langle fire rangle"

demo "👑" "Sacred: HIGHEST reverence to void" \
    "crown void"

echo ""
echo "═══ 🧠 ANIMACY: How conscious is it? ═══"

demo "🧠" "Sentient: Fire that is AWARE and thinking" \
    "brain fire"

demo "🪨" "Inert: Earth as DORMANT matter" \
    "rock earth"

echo ""
echo "═══ ⬆️ DIRECTIONALITY: Energy flow ═══"

demo "⬆️" "Upward: Fire ascending to HEAVENS" \
    "up langle fire rangle"

demo "⭕" "Cyclical: Steam flowing in ETERNAL CYCLES" \
    "circle lbrace fire plus water rbrace"

echo ""
echo "═══ 💭 MODAL: Necessity/possibility ═══"

demo "🤔" "Potential: This MIGHT create steam" \
    "maybe lbrace fire plus water rbrace"

demo "❗" "Necessary: Fire MUST be amplified" \
    "must langle fire rangle"

demo "🚫" "Prohibited: This fusion is FORBIDDEN!" \
    "forbidden lbrace fire plus earth rbrace"

echo ""
echo "═══ 🏛️ TEMPORAL DISTANCE: How far in time? ═══"

demo "⚡" "Immediate: Fire RIGHT NOW!" \
    "now fire"

demo "🏛️" "Ancient: From LONG AGO" \
    "ancient crown void"

echo ""
echo "═══ 👥 CLUSIVITY: Does 'we' include you? ═══"

demo "👥" "Inclusive: WE (including YOU) together" \
    "together fire water"

demo "🧍" "Solo: I ALONE cast this" \
    "alone crown lbrace fire plus void rbrace"

echo ""
echo "═══ 🌟 BEAUTIFUL COMBINATIONS! ═══"

demo "👁️ 🔁 🙇 ⬆️" "Direct + Habitual + Humble + Upward amplified fire" \
    "eye repeat bow up langle fire rangle"

echo ""
echo "═══════════════════════════════════════════════════════════════════"
echo ""
echo "🎨 WHY THIS IS REVOLUTIONARY:"
echo ""
echo "  1. UNIVERSAL VISUAL LANGUAGE"
echo "     👁️ means 'seeing' in ANY culture"
echo "     ⬆️ means 'up' everywhere"
echo "     🙏 means 'respect' worldwide"
echo ""
echo "  2. INSTANT INTUITION"
echo "     Compare:"
echo "       vis hab hum updir <*>    ← Requires training"
echo "       👁️ 🔁 🙇 ⬆️ <🔥>        ← IMMEDIATELY OBVIOUS!"
echo ""
echo "  3. BEAUTIFUL TO READ"
echo "     🏛️ 👑 👁️ ❗ 🔁 🙏 👻 🧠 ⬆️ ⭕ <{⚫+✅☯️{🔥+💧}}>"
echo "     ↑ This is not just code - it's ART! ✨"
echo ""
echo "  4. ACCESSIBLE"
echo "     ✓ Dyslexia-friendly (visual > text)"
echo "     ✓ Language-independent (transcends barriers)"
echo "     ✓ Screen reader compatible (emojis have names)"
echo "     ✓ Memorable (👁️ easier than 'vis')"
echo ""
echo "  5. SOCIAL MEDIA READY"
echo "     Tweet a spell: 🔮 ❗ 🙏 ⬆️ <{🔥+💧}> ✨"
echo ""
echo "📚 LEARN MORE:"
echo "  Full docs: cat examples/SIGIL-EMOJI-README.md"
echo "  Examples:  cat examples/sigil-emoji-gallery.txt"
echo "  Try:       cargo run -p cli examples/sigil-emoji.fgr"
echo ""
echo "═══════════════════════════════════════════════════════════════════"
echo ""
echo "🌈 THE COMPLETE EMOJI GRAMMAR KEY:"
echo ""
echo "👁️ eye = I SAW           🔁 repeat = HABITUAL      🙇 bow = HUMBLE"
echo "🔍 mag = INFERRED        ✅ check = COMPLETED      🙏 pray = RESPECTFUL"
echo "👂 ear = HEARD           ▶️ play = ONGOING         👑 crown = SACRED"
echo "🔮 crystal = SENSED      🌱 sprout = BEGINNING     😐 neutral = EQUAL"
echo ""
echo "🧠 brain = SENTIENT      ⬆️ up = UPWARD           🤔 maybe = MIGHT"
echo "💚 heart = LIVING        ⬇️ down = DOWNWARD       ❗ must = NECESSARY"
echo "👻 ghost = SPIRITUAL     ⏺️ center = INWARD       🚫 forbidden = PROHIBITED"
echo "🪨 rock = INERT          💫 radiate = OUTWARD     📋 should = OBLIGATED"
echo "                         ⭕ circle = CYCLICAL     ⭐ wish = DESIRED"
echo ""
echo "🌿 leaf = NATURAL        ⚡ now = IMMEDIATE       👥 together = INCLUSIVE"
echo "🔨 hammer = FORCED       📅 recent = RECENT       🚶🚶 apart = EXCLUSIVE"
echo "☯️ yin = HARMONIOUS      🏛️ ancient = ANCIENT     🧍 alone = SOLO"
echo "⚔️ sword = DISCORDANT"
echo ""
echo "═══════════════════════════════════════════════════════════════════"
echo ""
echo "May your grammar be 👁️ visual, your sigils ✨ beautiful,"
echo "and your understanding 🌍 universal!"
echo ""
echo "🌳🎨✨🔮🌈 - The Tree Guardian's Emoji Spellbook"
echo ""
echo "═══════════════════════════════════════════════════════════════════"
