#!/bin/bash

# Log Analyzer Script
# Usage: ./my_log_analyzer.sh <log_file>

LOG_FILE="$1"

# ================================
# TODO: Validate input parameters
# ================================
if [[ -z "$LOG_FILE" ]]; then
  echo "Error: No log file provided."
  echo "Usage: $0 <log_file>"
  exit 1
fi

# ================================
# TODO: Check if the file exists
# ================================
if [[ ! -f "$LOG_FILE" ]]; then
  echo "Error: File '$LOG_FILE' not found."
  exit 1
fi

if [[ ! -r "$LOG_FILE" ]]; then
  echo "Error: File '$LOG_FILE' is not readable."
  exit 1
fi

# ================================
# TODO: Analyze the log file
# ================================

echo "===== Log File Analysis ====="
echo "Analyzing file: $LOG_FILE"
echo

# Total entries
TOTAL_LINES=$(wc -l < "$LOG_FILE")
echo "Total log entries: $TOTAL_LINES"

# Count log levels
INFO_COUNT=$(grep -c "INFO" "$LOG_FILE")
WARNING_COUNT=$(grep -c "WARNING" "$LOG_FILE")
ERROR_COUNT=$(grep -c "ERROR" "$LOG_FILE")

echo "INFO entries:    $INFO_COUNT"
echo "WARNING entries: $WARNING_COUNT"
echo "ERROR entries:   $ERROR_COUNT"

# Extract date range (assumes log starts with YYYY-MM-DD HH:MM:SS format)
START_DATE=$(head -n 1 "$LOG_FILE" | awk '{print $1}')
END_DATE=$(tail -n 1 "$LOG_FILE" | awk '{print $1}')
echo "Date range:      $START_DATE to $END_DATE"

# Top 5 IP addresses (if applicable)
echo
echo "Top 5 IP addresses:"
grep -oE '\b([0-9]{1,3}\.){3}[0-9]{1,3}\b' "$LOG_FILE" | \
  sort | uniq -c | sort -nr | head -5

# Top 5 frequent messages (removing date/time and level)
echo
echo "Top 5 frequent messages:"
awk '{$1=""; $2=""; $3=""; print $0}' "$LOG_FILE" | \
  sed 's/^ *//' | sort | uniq -c | sort -nr | head -5

echo
echo "===== End of Report ====="
