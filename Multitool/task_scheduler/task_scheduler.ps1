#Import the functions from functions file
. .\functions.ps1

#Read the csv file and save it in the variable $csv
read_csv("task_scheduler.csv")

for ($i = 0; $i -lt $csv.Length; $i++){ 
    $task_counter = $i + 1

    #Setting up the variables to be more accessible
    $name = $csv[$i].Name
    $file = $csv[$i].Program
    $path = $csv[$i].Path
    
    $User= $env:USERNAME
    $taskExists = Get-ScheduledTask | Where-Object {$_.TaskName -like $name }

    if($taskExists) {

        Write-Host "$task_counter. FAILED: Task $name already exists"
         
    } else {      
    
        $Trigger= New-ScheduledTaskTrigger -At 12:14 –Daily
        $Action= New-ScheduledTaskAction -Execute "powershell.exe" -Argument "-file `"$file`"" -WorkingDirectory $path
        $Settings= New-ScheduledTaskSettingsSet -AllowStartIfOnBatteries -DontStopIfGoingOnBatteries -DontStopOnIdleEnd -StartWhenAvailable
        Register-ScheduledTask -TaskName $name -Trigger $Trigger -User $User -Action $Action -RunLevel Highest -Settings $Settings –Force > $null
   
        if($taskExists) {

            Write-Host "$task_counter. FAILED: Task $name couldn't be created"

        } else {

            Write-Host "$task_counter. SUCCESS: Task $name was successfully created" 
            
        }
    }  

}