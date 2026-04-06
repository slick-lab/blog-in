#!/bin/bash

echo " installing blog-in.."

mkdir -p ~/.blog-in
cd ~/.blog-in

curl -L https://github.com/slick-lab/blog-in/actions/runs/24042004634/artifacts/6290682890 -o blog-in

chmod +x blog-in

echo "blog-in installed.."
echo ""
echo "Run it"
echo " cd ~/.blog-in"
echo ""
echo " add path"
