#Reads the csv file and every row is inserted into array called $csv
Function read_csv{
    Param ($file)
    $global:csv = Import-Csv -Path .\$file
}

Function create_task{
    #Take the parameters from the csv and save it as a command in $Trigger
    $Trigger = "New-ScheduledTaskTrigger $parameters"
    $Trigger = Invoke-Expression $Trigger

    #Creates the task
    $Action= New-ScheduledTaskAction -Execute "powershell.exe" -Argument "-file `"$file`"" -WorkingDirectory $path
    $Settings= New-ScheduledTaskSettingsSet -AllowStartIfOnBatteries -DontStopIfGoingOnBatteries -DontStopOnIdleEnd -StartWhenAvailable
    Register-ScheduledTask -TaskName $name -Trigger $Trigger -User $User -Action $Action -RunLevel Highest -Settings $Settings –Force > $null
      
}