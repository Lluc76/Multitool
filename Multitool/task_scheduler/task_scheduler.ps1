#Import the functions from functions file
. .\functions.ps1

#Read the csv file and save it in the variable $csv
read_csv("task_scheduler.csv")


$name = "BoomHeadshot"
$file = "backups.ps1"
$path = "C:\Users\llucr\Desktop\Projecte Final Grau\Multitool\backups"
$User= $env:USERNAME

$Trigger= New-ScheduledTaskTrigger -At 10:00am –Daily # Specify the trigger settings
$Action= New-ScheduledTaskAction -Execute "powershell.exe" -Argument "-file `"$file`"" -WorkingDirectory $path # Specify what program to run and with its parameters
$Settings= New-ScheduledTaskSettingsSet -AllowStartIfOnBatteries -DontStopIfGoingOnBatteries -DontStopOnIdleEnd -StartWhenAvailable
Register-ScheduledTask -TaskName $name -Trigger $Trigger -User $User -Action $Action -RunLevel Highest -Settings $Settings –Force # Specify the name of the task