1. Which bugs were syntax errors?
Syntax errors were mistakes that prevented the Python scripts from running correctly. Such errors included such as incorrect formatting, missing punctuation, or incorrect Bash command structure. Ex. elif days_until_renewal <= 30; SyntaxError: expected ':' as in 30:

2. Which bugs were logic errors?
Logic errors were mistakes where the program could run, but it produced the wrong results. Ex. owner_counts[owner] == 1; owner_counts[owner] = 1 Other logic errors included counting inactive licenses.

3. Why should CSV input be validated before unpacking fields?
Without validating the csv file some rows may have missing information or contain too many fields. Checking the row first prevents the program from crashing when it tries to assign or add new variables to the list.

4. Why should automation tools skip bad records instead of crashing?
Automation tools should skip bad records so one incorrect entry does not stop the entire process with one single point of failure. The program can continue processing the valid records and still generate useful reports of what failed or is missing.

5. Why is it useful to test Python files directly before testing the Bash menu?
Testing the Python files isolate problems that need to be corrected. If a Python script doesn’t work by itself, you know the problem is more than likely in the script itself vs. the Bash menu.

6. Why should the evaluator restore the original data after testing?
The evaluator should restore the original data so every test starts with the same information. This prevents test records, reports, or archived files from affecting future tests.