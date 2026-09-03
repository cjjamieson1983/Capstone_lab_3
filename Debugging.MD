Issue 1: Pylance Errors on initial inspection
  Pylance Error 1
    ![issue_1_Error](Artifacts/issue_1_Error.png)
    Fix:
    ![issue_1_Fix](Artifacts/issue_1_Fix.png)

  Pylance Error 2
    ![issue_2_Error](Artifacts/issue_2_Error.png)
     Fix:
     ![issue_2_Fix](Artifacts/issue_2_Fix.png)
     
  Pylance Error 3
    ![issue_3_Error](Artifacts/issue_3_Error.png)
    Fix:
    ![issue_3_Fix](Artifacts/issue_3_Fix.png)
    
Issue 2: Liscensce Menu.sh returns invalid selection for all entries

 ![initial_run_ls_Menu1](Artifacts/initial_run_ls_Menu1)
 ![initial_run_ls_Menu2](Artifacts/initial_run_ls_Menu2.png)

 Check: Verify variable references for accuracy
    ![ls_menu_debugging_choice_selection1](Artifacts/ls_menu_debugging_choice_selection1)

 Fix: Variable "$selection" is invalid. 
    ![ls_menu_debugging_choice_selection2](Artifacts/ls_menu_debugging_choice_selection2)

Issue 3:Python Execution Errors
    ![2nd_pass_menu_run](Artifacts/2nd_pass_menu_run.png)

 Check: Try to Execute the individual Python Files. Fail
 Python3 execution is not working. Use PY "script_name.py" to execute
   ![add_liscense_2nd_run](Artifacts/add_liscense_2nd_run.png)

Issue 4: liscense_audit.py table display discrepancies. Seats used and seats purchased are inverted. As well as the function to check seats used/seats purchased
   ![liscense_Audit_1st_run](Artifacts/liscense_Audit_1st_run.png)

   Fixes: Changed line 58 to-" if seats_used < seats_purchased:"
   Changend line 63      "  | {owner} | used={seats_purchased}/{seats_used} |"

   ![liscense_Audit_2nd_run](Artifacts/liscense_Audit_2nd_run.png)

   Checks out against Expected output
   ![liscense_Audit_check](Artifacts/liscense_Audit_Check.png)

Issue 5: liscensce_menu.py failing to copy owner_summary.txt to archive.
  ![final_Eval_Error](Artifacts/liscense_final_Eval_Error.png)

  Fix: Option 2 should be calling owner_summary.py

  ![final_Eval_Fix](Artifacts/liscense_final_Eval_Fix.png)



