#!/bin/bash
# ASCII Sigil Language - ULTRA VERSION
# Demonstrating exotic linguistic features from world languages!

echo "╔═══════════════════════════════════════════════════════════════════╗"
echo "║          ASCII SIGIL LANGUAGE - ULTRA VERSION                     ║"
echo "║        Exotic Linguistic Features from Around the World           ║"
echo "╚═══════════════════════════════════════════════════════════════════╝"
echo ""
echo "This version adds 10 NEW linguistic systems inspired by features"
echo "from Turkish, Japanese, Navajo, Quechua, and many other languages!"
echo ""
echo "═══════════════════════════════════════════════════════════════════"

demo() {
    local title="$1"
    local desc="$2"
    local visual="$3"
    local tokens="$4"

    echo ""
    echo "-------------------------------------------------------------------"
    echo "📚 $title"
    echo "-------------------------------------------------------------------"
    echo "Description: $desc"
    echo "Visual:      $visual"
    echo "Tokens:      $tokens"
    echo "-------------------------------------------------------------------"
    echo "$tokens" | cargo run -q -p cli examples/sigil-ultra.fgr -n 2>&1 | grep -A 15 "^>" | head -17 | grep -v "warning:"
}

echo ""
echo "═══ 1. EVIDENTIALITY (How do you know?) ═══"
demo "Direct Observation" \
    "Turkish -DI style: I saw it myself" \
    "vis <*>" \
    "vis langle asterisk rangle"

demo "Hearsay/Tradition" \
    "Turkish -miş style: I was told by elders" \
    "her [~]" \
    "her lbrack tilde rbrack"

echo ""
echo "═══ 2. ASPECT (How does it unfold in time?) ═══"
demo "Habitual Aspect" \
    "Like Spanish imperfect: happens regularly" \
    "hab *" \
    "hab asterisk"

demo "Perfective Aspect" \
    "Like Russian perfective: completed action" \
    "perf {*+~}" \
    "perf lbrace asterisk plus tilde rbrace"

echo ""
echo "═══ 3. ATTUNEMENT (Your relationship to magic) ═══"
demo "Natural Affinity" \
    "Born with innate connection" \
    "nat *" \
    "nat asterisk"

demo "Forced Magic" \
    "Compelling elements against their will" \
    "forcd #" \
    "forcd hash"

echo ""
echo "═══ 4. HONORIFICS (Level of respect) ═══"
demo "Humble Form" \
    "Like Japanese kenjōgo: I humble myself" \
    "hum <*>" \
    "hum langle asterisk rangle"

demo "Sacred/Reverential" \
    "Highest respect for cosmic forces" \
    "sac @" \
    "sac at"

echo ""
echo "═══ 5. ANIMACY (Level of consciousness) ═══"
demo "Sentient Fire" \
    "Like Navajo animate: aware and thinking" \
    "sent *" \
    "sent asterisk"

demo "Inert Earth" \
    "Like Navajo inanimate: dormant matter" \
    "inrt #" \
    "inrt hash"

echo ""
echo "═══ 6. DIRECTIONALITY (Energy flow) ═══"
demo "Upward Flow" \
    "Like Athabaskan directionals: ascending" \
    "updir <*>" \
    "updir langle asterisk rangle"

demo "Cyclical Flow" \
    "Eternal circular movement" \
    "cycdir {*+~}" \
    "cycdir lbrace asterisk plus tilde rbrace"

echo ""
echo "═══ 7. MODALITY (Possibility/necessity) ═══"
demo "Potential" \
    "Might happen, uncertain" \
    "pot {*+~}" \
    "pot lbrace asterisk plus tilde rbrace"

demo "Necessary" \
    "Must happen, required" \
    "nec <*>" \
    "nec langle asterisk rangle"

demo "Prohibited" \
    "Forbidden combination!" \
    "prh {*+#}" \
    "prh lbrace asterisk plus hash rbrace"

echo ""
echo "═══ 8. TEMPORAL DISTANCE (How far in time?) ═══"
demo "Immediate Present" \
    "Right now, this instant" \
    "imm *" \
    "imm asterisk"

demo "Remote/Ancient" \
    "From distant past, like Quechua -sqa" \
    "rem sac @" \
    "rem sac at"

echo ""
echo "═══ 9. CLUSIVITY (Does 'we' include you?) ═══"
demo "Inclusive We" \
    "Like Tok Pisin 'yumi': we including you" \
    "incl * ~" \
    "incl asterisk tilde"

demo "Exclusive We" \
    "Like Tok Pisin 'mipela': we excluding you" \
    "excl * #" \
    "excl asterisk hash"

echo ""
echo "═══ 10. COMPLEX COMBINATIONS ═══"
demo "Moderate Complexity" \
    "Direct + Habitual + Humble + Upward + Amplified Fire" \
    "vis hab hum updir <*>" \
    "vis hab hum updir langle asterisk rangle"

echo ""
echo "═══════════════════════════════════════════════════════════════════"
echo ""
echo "🌍 LINGUISTIC DIVERSITY SHOWCASE"
echo ""
echo "Sigil ULTRA incorporates features from:"
echo "  🇹🇷 Turkish    - Evidentiality (direct vs hearsay)"
echo "  🇯🇵 Japanese   - Honorific levels (humble/respectful/sacred)"
echo "  🇺🇸 Navajo     - Animacy hierarchy (sentient/inert)"
echo "  🇵🇪 Quechua    - Evidentials, temporal distance"
echo "  🇧🇬 Bulgarian  - Evidential system"
echo "  🇵🇬 Tok Pisin  - Clusivity (inclusive/exclusive we)"
echo "  Various      - Aspect, directionality, modality"
echo ""
echo "📊 STATISTICS"
echo "  • 10 new linguistic systems"
echo "  • 30+ grammatical markers"
echo "  • Hundreds of thousands of feature combinations"
echo "  • More complex than any single natural language!"
echo ""
echo "🎯 WHY THIS MATTERS"
echo "  ✓ Shows treebender can handle exotic linguistic features"
echo "  ✓ Demonstrates cognitive realism (features humans need)"
echo "  ✓ Enables precise magical/semantic distinctions"
echo "  ✓ Creates richness rivaling natural languages"
echo ""
echo "📚 LEARN MORE"
echo "  Read: examples/SIGIL-ULTRA-README.md"
echo "  Examples: examples/sigil-ultra-gallery.txt"
echo "  Try: cargo run -p cli examples/sigil-ultra.fgr"
echo ""
echo "May your evidentials be direct, your honorifics respectful,"
echo "and your features unified across the entire parse tree! 🌳✨"
echo ""
echo "═══════════════════════════════════════════════════════════════════"
