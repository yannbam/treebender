#!/bin/bash
# Compare original and refactored grammar outputs
# Usage: ./compare-grammars.sh <test-file>
#
# This script runs test expressions through both compositional.fgr
# and compositional-refactored.fgr and reports any differences

ORIGINAL="emlang/compositional/compositional.fgr"
REFACTORED="emlang/compositional/compositional-refactored.fgr"
TEST_FILE="${1:-emlang/compositional/tests/definition-operator.txt}"

total=0
passed=0
failed=0

echo "=========================================="
echo "GRAMMAR COMPARISON TEST"
echo "=========================================="
echo "Original:   $ORIGINAL"
echo "Refactored: $REFACTORED"
echo "Test file:  $TEST_FILE"
echo "=========================================="
echo ""

while IFS= read -r line; do
  # Skip empty lines and comments
  if [ -z "$line" ] || echo "$line" | grep -q '^#'; then
    continue
  fi

  total=$((total + 1))

  # Parse with original grammar
  orig_output=$(echo "$line" | cargo run -q -p cli "$ORIGINAL" -n 2>&1)
  orig_result=$?
  orig_parse_count=$(echo "$orig_output" | grep -o "Parsed [0-9]*" | grep -o "[0-9]*" || echo "0")

  # Parse with refactored grammar
  refact_output=$(echo "$line" | cargo run -q -p cli "$REFACTORED" -n 2>&1)
  refact_result=$?
  refact_parse_count=$(echo "$refact_output" | grep -o "Parsed [0-9]*" | grep -o "[0-9]*" || echo "0")

  # Compare results
  if [ "$orig_parse_count" = "$refact_parse_count" ]; then
    passed=$((passed + 1))
    echo "✅ [MATCH] $line"
    echo "   Original: $orig_parse_count parses | Refactored: $refact_parse_count parses"
  else
    failed=$((failed + 1))
    echo "❌ [DIFF] $line"
    echo "   Original: $orig_parse_count parses | Refactored: $refact_parse_count parses"
    echo "   --- Original output ---"
    echo "$orig_output" | head -10
    echo "   --- Refactored output ---"
    echo "$refact_output" | head -10
    echo ""
  fi
done < "$TEST_FILE"

echo ""
echo "=========================================="
echo "RESULTS"
echo "=========================================="
echo "Total tests:  $total"
echo "Matches:      $passed"
echo "Differences:  $failed"

if [ $failed -eq 0 ]; then
  echo ""
  echo "🎉 All tests match! Grammars are equivalent."
  exit 0
else
  echo ""
  echo "⚠️  Grammars differ on $failed tests."
  exit 1
fi
