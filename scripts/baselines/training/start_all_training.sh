#!/bin/bash

cd $(dirname "$0")
for file in train_*.sbatch; do
  echo "running sbatch -G 1 $file"
  sbatch -G 1 "$file"
done
