#!/bin/bash

RESOURCE_TYPE=$1
NAMESPACE_PROVIDED=$2

printf "+-----------------------+------------------------------------------+-----------------------+----------------------+\n"
printf "| %-21s | %-40s | %-21s | %-20s |\n" "NAMESPACE" "NAME" "CPU(cores)" "MEMORY(bytes)"
printf "+-----------------------+------------------------------------------+-----------------------+----------------------+\n"

# Use kubectl top to get resource usage statistics for all pods in the specified namespace
kubectl top "$RESOURCE_TYPE" -n "$NAMESPACE_PROVIDED" | tail -n +2 | while read line
do
  # Extract CPU and memory usage from the output
  RESOURCE=$(echo "$line" | awk '{print $0}')
  NAME=$(echo "$line" | awk '{print $1}')
  CPU=$(echo "$line" | awk '{print $2}')
  MEMORY=$(echo "$line" | awk '{print $3}')

  # Debug: Print the extracted values
  # echo "RESOURCE=$RESOURCE, NAMESPACE=$NAMESPACE_PROVIDED, NAME=$NAME, CPU=$CPU, MEMORY=$MEMORY"

  # Output the statistics to the console in a table format with borders
  printf "| %-21s | %-40s | %-21s | %-20s |\n" "$NAMESPACE_PROVIDED" "$NAME" "$CPU" "$MEMORY"
  printf "+-----------------------+------------------------------------------+-----------------------+----------------------+\n"
done