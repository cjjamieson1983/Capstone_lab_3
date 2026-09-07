# Debugging Log 
### It walks the system and lists the chsnges
---
These are changes I made to ensure quality execution
Additionally, this is a log of bug fixes and / or logic structural changes made to run the application as requested.
The goal stated was NOT to rearchitect the solution, just get it up and running.

<br /><br />
Change #1 - Pre and Post mkdir check
![alt text](Eirik-Artifacts/Pre_Directory_mkdir_check.png)

I added the mkdir -p check to ensure both directories that are referenced but not provisioned were actually
present to stop an error that hits without them being created.
I suppose you could consider it a logic error, the code works provided you actually have the spot to place files in.
<br /><br />

![alt text](Eirik-Artifacts/Post_Directory_mkdir_check.png)

<br /><br />
For all the scripts calling python by using python3, that does not work on windows. <br />
I used py as a shortcut for python which does work on windows. the commasnd using python3 is for<br />
those who have macs.
<br />
Made a change to allow the menu choice option to actually be read and stored in the $choice, as selection<br />
is not a valid variable.

Change #2 - license_menu.sh makmenu option work successfully

![alt text](Eirik-Artifacts/Pre_Choice_variable_modification.png)

![alt text](Eirik-Artifacts/Post_Choice_variable_modification.png)

