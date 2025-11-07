#!/bin/bash
# Run NEGATIVE definition operator tests
# These should all FAIL to parse (0 parses = correct behavior)

total=0
passed=0

while IFS= read -r line; do
  # Skip empty lines and comments
  if [ -z "$line" ] || echo "$line" | grep -q '^#'; then
    continue
  fi

  total=$((total + 1))

  # For negative tests, we WANT 0 parses
  if echo "$line" | cargo run -q -p cli emlang/compositional/compositional.fgr -n 2>&1 | grep -q "Parsed 0 trees"; then
    passed=$((passed + 1))
    echo "✅ CORRECTLY REJECTED: $line"
  else
    echo "❌ SHOULD HAVE REJECTED: $line"
  fi
done < emlang/compositional/tests/definition-operator-negative.txt

echo ""
echo "Correctly rejected: $passed/$total"
