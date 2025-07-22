#!/bin/bash

# === Log File Analyzer Script ===

# ✅ 1. Validate Argument
LOGFILE="$1"
if [ -z "$LOGFILE" ] || [ ! -f "$LOGFILE" ]; then
  echo "Usage: $0 /path/to/logfile"
  exit 1
fi

# ✅ 2. Count Message Types
ERROR_COUNT=$(grep -c "ERROR" "$LOGFILE")
WARNING_COUNT=$(grep -c "WARNING" "$LOGFILE")
INFO_COUNT=$(grep -c "INFO" "$LOGFILE")

# ✅ 3. Top 5 Most Common ERROR Messages
TOP_ERRORS=$(grep "ERROR" "$LOGFILE" | cut -d']' -f2- | sort | uniq -c | sort -nr | head -5)

# ✅ 4. First and Last ERROR Messages
FIRST_ERROR=$(grep "ERROR" "$LOGFILE" | head -1)
LAST_ERROR=$(grep "ERROR" "$LOGFILE" | tail -1)

# ✅ 5. Display Summary Report
echo "===== LOG FILE ANALYSIS ====="
echo "File: $LOGFILE"
echo "-----------------------------"
echo "ERROR messages:   $ERROR_COUNT"
echo "WARNING messages: $WARNING_COUNT"
echo "INFO messages:    $INFO_COUNT"
echo
echo "----- TOP 5 ERROR MESSAGES -----"
echo "$TOP_ERRORS"
echo
echo "----- ERROR TIMELINE ---
