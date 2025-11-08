#!/bin/bash
# Test quotation compositions
# Usage: ./emlang/compositional/tests/run-quotation-tests.sh

GRAMMAR="emlang/compositional/compositional.fgr"
TESTS="emlang/compositional/tests/quotation-composition.txt"

echo "🧪 Testing Quotation Compositions..."
echo

passed=0
failed=0

while IFS= read -r line; do
  # Skip comments and empty lines
  [[ -z "$line" || "$line" =~ ^# ]] && continue

  echo "Testing: $line"

  if echo "$line" | cargo run -q -p cli "$GRAMMAR" -n > /dev/null 2>&1; then
    echo "  ✅ Parsed"
    ((passed++))
  else
    echo "  ❌ Failed to parse"
    ((failed++))
  fi
done < "$TESTS"

echo
echo "Results: $passed passed, $failed failed"
