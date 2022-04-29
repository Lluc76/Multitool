#Import the functions from functions file
. .\functions.ps1

#Read the csv file and save it in the variable $csv
read_csv("task_scheduler.csv")


$name = "BoomHeadshot"
$file = "backups.ps1"
$path = "C:\Users\llucr\Desktop\Projecte Final Grau\Multitool\backups"

$User= $env:USERNAME


$Trigger= New-ScheduledTaskTrigger -At 15:41pm –Daily
$Action= New-ScheduledTaskAction -Execute "powershell.exe" -Argument "-file `"$file`"" -WorkingDirectory $path
$Settings= New-ScheduledTaskSettingsSet -AllowStartIfOnBatteries -DontStopIfGoingOnBatteries -DontStopOnIdleEnd -StartWhenAvailable
Register-ScheduledTask -TaskName $name -Trigger $Trigger -User $User -Action $Action -RunLevel Highest -Settings $Settings –Force