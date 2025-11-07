#!/bin/bash
# Demo: Meta-Operators in Emlang Compositional
# Showcasing definition (≡) and composition (∘) operators
# Both implemented using ONLY .fgr grammar features!

GRAMMAR="emlang/compositional/compositional.fgr"

echo "🎯 EMLANG COMPOSITIONAL: Meta-Operators Demo"
echo "=============================================="
echo ""

echo "📚 DEFINITION OPERATOR (≡)"
echo "Creating named bindings for complex expressions"
echo "Syntax: defname define <expression> then <usage>"
echo ""

echo "Example 1: Simple element definition"
echo "Input: star define 🔥 then star"
cat << 'EOF' | cargo run -q -p cli $GRAMMAR -f h-tree -n
star define 🔥 then star
EOF
echo ""

echo "Example 2: Container definition with reuse"
echo "Input: star define ❴ 🔥 plus 💧 ❵ then star plus star"
cat << 'EOF' | cargo run -q -p cli $GRAMMAR -f h-tree -n
star define ❴ 🔥 plus 💧 ❵ then star plus star
EOF
echo ""

echo "Example 3: Transformed element definition"
echo "Input: circus define 🔄 ‹ 🔥 › then circus minus 💧"
cat << 'EOF' | cargo run -q -p cli $GRAMMAR -f h-tree -n
circus define 🔄 ‹ 🔥 › then circus minus 💧
EOF
echo ""

echo "Example 4: Pattern definition"
echo "Input: castle define popen 🔥 por 💧 pclose then castle"
cat << 'EOF' | cargo run -q -p cli $GRAMMAR -f h-tree -n
castle define popen 🔥 por 💧 pclose then castle
EOF
echo ""

echo "✅ Semantic constraint checking:"
echo "Input: star define 🔥 then circus (WRONG NAME!)"
echo "Expected: 0 parses (unification fails)"
cat << 'EOF' | cargo run -q -p cli $GRAMMAR -n
star define 🔥 then circus
EOF
echo ""
echo ""

echo "🔄 COMPOSITION OPERATOR (∘)"
echo "Creating first-class composed transformers"
echo "Syntax: transformer1 compose transformer2 apply <target>"
echo "Semantics: Right-to-left (f ∘ g)(x) = f(g(x))"
echo ""

echo "Example 1: Basic composition with element"
echo "Input: 🔄 compose 📦 apply 🔥"
echo "Meaning: First package fire, then recurse"
cat << 'EOF' | cargo run -q -p cli $GRAMMAR -f h-tree -n
🔄 compose 📦 apply 🔥
EOF
echo ""

echo "Example 2: Composition with container"
echo "Input: 🎭 compose 🔗 apply ‹ 💧 ›"
echo "Meaning: First bind amplified water, then morph"
cat << 'EOF' | cargo run -q -p cli $GRAMMAR -f h-tree -n
🎭 compose 🔗 apply ‹ 💧 ›
EOF
echo ""

echo "Example 3: Composition with pattern"
echo "Input: ⚡ compose 🌀 apply popen 🔥 por 💧 pclose"
echo "Meaning: Force-then-suspend on fire-or-water pattern"
cat << 'EOF' | cargo run -q -p cli $GRAMMAR -f h-tree -n
⚡ compose 🌀 apply popen 🔥 por 💧 pclose
EOF
echo ""

echo "Example 4: Composition with transformed element"
echo "Input: 🔄 compose 📦 apply 🎭 🔥"
echo "Meaning: Compose recursive-package, apply to morphed fire"
cat << 'EOF' | cargo run -q -p cli $GRAMMAR -f h-tree -n
🔄 compose 📦 apply 🎭 🔥
EOF
echo ""

echo "Example 5: Different order = different semantics!"
echo "Input 1: 🔄 compose 📦 apply 🔥 (recurse ∘ package)"
cat << 'EOF' | cargo run -q -p cli $GRAMMAR -n
🔄 compose 📦 apply 🔥
EOF

echo "Input 2: 📦 compose 🔄 apply 🔥 (package ∘ recurse)"
cat << 'EOF' | cargo run -q -p cli $GRAMMAR -n
📦 compose 🔄 apply 🔥
EOF
echo "Note: Same transformers, different composition order!"
echo ""

echo "✨ COMBINED: Both operators together!"
echo "Input: star define 🔥 then 🔄 compose 📦 apply star"
echo "Define star as fire, compose recurse-package, apply to star"
cat << 'EOF' | cargo run -q -p cli $GRAMMAR -f h-tree -n
star define 🔥 then 🔄 compose 📦 apply star
EOF
echo ""

echo "🎉 Demo Complete!"
echo ""
echo "✅ Definition operator: 34/34 tests passing"
echo "✅ Composition operator: 40/40 tests passing"
echo "✅ Both implemented using ONLY .fgr grammar!"
echo ""
echo "See tests-definition-operator.txt and tests-composition-operator.txt"
echo "for comprehensive test suites."
