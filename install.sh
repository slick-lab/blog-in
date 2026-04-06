#!/bin/bash

echo " installing inkwell.."

mkdir -p ~/.inkwell
cd ~/.inkwell

curl -L https://gitlab.com/dart.co/inkwell/-/jobs/13283284522/artifacts/raw/inkwell-linux?inline=false -o inkwell

chmod +x inkwell

echo "inkwell installed.."
echo ""
echo "Run it"
echo " cd ~/.inkwell"
echo ""
echo " add path"