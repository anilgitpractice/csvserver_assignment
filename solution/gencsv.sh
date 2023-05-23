#!/bin/bash

start=$1
end=$2

for ((i=start; i<=end; i++))
do
  echo "$i, $((RANDOM % 100))"
done > inputFile

