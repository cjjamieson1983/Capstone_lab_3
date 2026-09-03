Lab3: CAPSTONE_Lab3_saas-license-troubleshooting

saas-license-troubleshoting primary changes made:
1. license_menu.sh
   a. Changed all instances of "python3" to "python" since my code is run on Windows.
   b. Line 22: Changed the variable "Choice" to "Selection" to match the case function reference to the same variable "selection".
   c. Line 33: Within option 2 of the case statement, "python scripts/license_audit.py > reports/owner_report.txt was changed to "python scripts/owner_summary.py > reports/owner_report.txt".

2. evaluate_lab.sh
   a. Changed all instances of "python3" to "python" since my code is run on Windows.

3. add_license.py
   a. add ":" character at the end of the first line of each "if" and "elif" clause that didn't have it.

4. license_aduit.py
   a. add ":" character at the end of the first line of each "if" and "elif" clause that didn't have it.
   b. lines 41-47, FOR clause: variables "seats_purhased" and "seats_used" have the value slot positions within the license_record group of values switched.  I switch them from [3] and [2] to [2] and [3].
   c. Added ":" at the end of first line of elif clause on line 53.

5. owner_summary.py
   a. else statement on lines 32-33: changed "owner_counts[owner] == 1" to "owner_counts[owner] = 1"