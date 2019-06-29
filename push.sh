#!/bin/bash
echo "Will add ., git commit with message $1, and push"
git add . && git commit -m "$1" && git push