import re
import csv

# Input log file
log_file = 'logfile.txt'

# CSV file
output_csv = 'output.csv'

# Dictionary to store IP addresses and their counts
ip_counts = {}

# Regular expression pattern to match IP addresses
ip_pattern = r'\b(?:\d{1,3}\.){3}\d{1,3}\b'

# Open the log file and process each line
with open(log_file, 'r') as file:
    for line in file:
        ips = re.findall(ip_pattern, line)
        for ip in ips:
            if ip in ip_counts:
                ip_counts[ip] += 1
            else:
                ip_counts[ip] = 1

# Write IP addresses and counts to the CSV file
with open(output_csv, 'w', newline='') as file:
    writer = csv.writer(file)
    writer.writerow(['IP Address', 'Count'])
    for ip, count in ip_counts.items():
        writer.writerow([ip, count])

print('CSV file generated:', output_csv)
