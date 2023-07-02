#!/bin/bash

# Input log file
log_file="logfile.txt"

# Output CSV file
output_csv="output.csv"

# Use grep and tr to extract IP addresses from the log file
grep -Eo '([0-9]{1,3}\.){3}[0-9]{1,3}' "$log_file" | sort | uniq -c > tmp.txt

# Create the CSV header
echo "IP Address,Count" > "$output_csv"

# Read the temporary file and generate the CSV rows
while read -r line; do
  count=$(echo "$line" | awk '{print $1}')
  ip=$(echo "$line" | awk '{print $2}')
  
  # Check if the IP occurs only once
  if [[ $count -eq 1 ]]; then
    echo "$ip,1" >> "$output_csv"
  else
    echo "$line" | awk '{print $2 "," $1}' >> "$output_csv"
  fi
done < tmp.txt

# Clean up temporary file
rm tmp.txt

echo "CSV file generated: $output_csv"
