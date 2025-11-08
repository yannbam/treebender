#!/bin/bash
# Run nested pattern tests

cd /home/jan/src/treebender

count=0
passed=0

while read -r line; do
  # Skip comments and empty lines
  [[ -z "$line" ]] && continue
  [[ "$line" == \#* ]] && continue

  count=$((count + 1))
  echo "[$count] Testing: $line"

  # Run test
  result=$(cat > /tmp/test-input.txt << EOF
$line
EOF
  cargo run -q -p cli emlang/compositional/compositional.fgr -n < /tmp/test-input.txt 2>&1 | head -1)

  if echo "$result" | grep -q "Parsed [1-9]"; then
    echo "  ✅ PASS"
    passed=$((passed + 1))
  else
    echo "  ❌ FAIL: $result"
  fi
  echo
done < emlang/compositional/tests/nested-patterns.txt

echo "========================================"
echo "Results: $passed/$count tests passed"
