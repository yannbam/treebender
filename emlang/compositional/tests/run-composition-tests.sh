#!/bin/bash
# Run composition operator tests
# Each non-empty, non-comment line is parsed

total=0
passed=0

while IFS= read -r line; do
  # Skip empty lines and comments (starting with #)
  if [ -z "$line" ] || echo "$line" | grep -q '^#'; then
    continue
  fi

  total=$((total + 1))

  if echo "$line" | cargo run -q -p cli emlang/compositional/compositional.fgr -n 2>&1 | grep -q "Parsed [1-9]"; then
    passed=$((passed + 1))
    echo "✅ $line"
  else
    echo "❌ $line"
  fi
done < emlang/compositional/tests/composition-operator.txt

echo ""
echo "Passed: $passed/$total"
