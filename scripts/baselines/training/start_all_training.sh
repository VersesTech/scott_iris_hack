#!/bin/bash

cd $(dirname "$0")
for file in train_*.sbatch; do
  echo "dry run, not actually running sbatch -G 1 $file"
#  sbatch -G 1 "$file"
done
