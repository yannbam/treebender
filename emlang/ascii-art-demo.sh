#!/bin/bash
# ASCII Art Parser Demo for treebender
# This shows how to "translate" emoticons into tokens for parsing

echo "=== ASCII ART GRAMMAR DEMO ==="
echo ""
echo "Welcome to the ASCII Art Parser!"
echo "This grammar can parse emoticons and simple decorative patterns."
echo ""
echo "Token Legend (how to translate ASCII art):"
echo "  :    -> colon"
echo "  ;    -> semi"
echo "  o    -> oeye"
echo "  O    -> ocap"
echo "  -    -> dash"
echo "  ^    -> caret"
echo "  )    -> rparen     [smile]"
echo "  D    -> capd       [big smile]"
echo "  (    -> lparen     [frown]"
echo "  |    -> vbar       [neutral]"
echo "  P    -> capp       [tongue out]"
echo "  !    -> bang       [emphasis]"
echo "  *    -> asterisk   [star]"
echo "  [    -> lbrack"
echo "  ]    -> rbrack"
echo ""
echo "=== Test Cases ==="
echo ""

run_test() {
    local ascii="$1"
    local tokens="$2"
    echo "ASCII Art: $ascii"
    echo "Tokens:    $tokens"
    echo "$tokens" | cargo run -q -p cli examples/ascii-art.fgr -n 2>/dev/null | head -3
    echo ""
}

echo "--- Happy Faces ---"
run_test ":-)"  "colon dash rparen"
run_test ":)"   "colon rparen"
run_test ":D"   "colon dash capd"
run_test ":-D!" "colon dash capd bang"

echo "--- Sad/Other Faces ---"
run_test ";-P"  "semi dash capp"
run_test "o("   "oeye lparen"

echo "--- Decorations ---"
run_test "[cool]" "lbrack cool rbrack"
run_test "*"      "asterisk"
run_test "**"     "asterisk asterisk"

echo "--- Invalid Combinations (should fail) ---"
echo "Just eyes (no mouth):"
echo "colon" | cargo run -q -p cli examples/ascii-art.fgr -n 2>/dev/null | head -2
echo ""
echo "Just mouth (no eyes):"
echo "rparen" | cargo run -q -p cli examples/ascii-art.fgr -n 2>/dev/null | head -2
echo ""

echo "=== Feature Structure Example ==="
echo "Let's see the full feature structure for a happy excited face: :-D!!"
echo ""
echo "colon dash capd bang bang" | cargo run -q -p cli examples/ascii-art.fgr 2>/dev/null

echo ""
echo "=== Grammar Rules Summary ==="
echo "Face -> Eyes Mouth           (simple face)"
echo "Face -> Eyes Nose Mouth      (face with nose)"
echo "Face[mood: happy] -> Eyes Nose Mouth[type: smile] Emphasis"
echo ""
echo "Try it yourself: cargo run -p cli examples/ascii-art.fgr"
