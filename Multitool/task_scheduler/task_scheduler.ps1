#Import the functions from functions file
. .\functions.ps1

#Read the csv file and save it in the variable $csv
read_csv("task_scheduler.csv")



$name = "BoomHeadshot"

$Trigger= New-ScheduledTaskTrigger -At 10:00am –Daily # Specify the trigger settings
$User= "NT AUTHORITY\SYSTEM" # Specify the account to run the script
$Action= New-ScheduledTaskAction -Execute "PowerShell.exe" -Argument "C:\Users\llucr\Desktop\scheduled_tasks\backups.ps1" # Specify what program to run and with its parameters
$Settings= New-ScheduledTaskSettingsSet -AllowStartIfOnBatteries -DontStopIfGoingOnBatteries -DontStopOnIdleEnd
Register-ScheduledTask -TaskName $name -Trigger $Trigger -User $User -Action $Action -RunLevel Highest -Settings $Settings –Force # Specify the name of the task