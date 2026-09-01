# Lab 3 Troubleshooting & Debugging Documentation

## Initial Error(s) Encountered
* The bash menu (`license_menu.sh`) failed to read user input and created an infinite loop.
* The bash menu failed to execute Python scripts due to a `python3: command not found` error in the Windows Git Bash environment.
* `license_audit.py` crashed with a `SyntaxError: expected ':'` on line 53.
* `owner_summary.py` crashed with a `SyntaxError: expected ':'` on line 38, followed by a `KeyError: 'IT'` when attempting to count active licenses.
* `license_audit.py` failed to properly flag over-allocated seats during the evaluation script.

## Steps Taken to Diagnose
* Ran the menu script manually and used `Ctrl+C` to break the infinite loop, then reviewed the variable assignments in the `read` and `case` statements.
* Evaluated the terminal environment (MINGW64 on Windows 11) to understand why the standard `python3` command was failing to map to the local Python installation.
* Analyzed the Python stack traces to pinpoint the exact lines missing colons for `elif` and `for` loop statements.
* Traced the `license_record` tuple creation in `license_audit.py` and compared the index mapping during the unpack phase to identify why the seat allocation logic was failing. 

## Code Changes Made
* **Bash Menu:** Corrected the `case` statement variable from `$selection` to `$choice`. Updated the execution commands from `python3` to `python` to support the local environment, and corrected option 2 to point to `owner_summary.py`.
* **Python Syntax Fixes:** Added missing colons (`:`) to the `elif` statement in `license_audit.py` and the `for` loop in `owner_summary.py`.
* **Python Logic Fixes:** 
  * Changed the boolean comparison (`==`) to an assignment (`=`) in `owner_summary.py` to properly initialize the dictionary count and resolve the `KeyError`.
  * Swapped the index mapping for `seats_purchased` (to `[2]`) and `seats_used` (to `[3]`) in `license_audit.py` so the validation logic compared the correct integers.
* **Evaluator Script:** Replaced `python3` with `python` in `evaluate_lab.sh` so the automated grading tests could execute the scripts successfully.

## Final Successful Execution
After applying the syntax and logic fixes across the bash and Python scripts, the application was run against the automated grader (`evaluate_lab.sh`). The execution was fully successful, resulting in **18 passed, 0 failed** (with proper archiving, report generation, and data validation).