#Path must end with "\"
$path = ".\"
$log = "delete_task-"+(Get-Date -Format "dd-MM-yy--HH-mm") + ".log"
Start-Transcript -Path ($path+$log)

#Import the functions from functions file
. .\functions.ps1

#Read the csv file and save it in the variable $csv
read_csv("delete_task.csv")

for ($i = 0; $i -lt $csv.Length; $i++){ 
    $task_counter = $i + 1

    if ($csv[$i].Enabled -eq "Yes"){
    
        #Setting up the variables to be more accessible
        $name = $csv[$i].Name        
        $taskExists = Get-ScheduledTask | Where-Object {$_.TaskName -like $name }

        #If exists will show the error and will skip the creation
        if($taskExists) {

            Unregister-ScheduledTask -TaskName $name -Confirm:$false

            if(-Not(Get-ScheduledTask | Where-Object {$_.TaskName -like $name })){
                Write-Host "$task_counter. SUCCESS: The task $name was deleted"

            }

        
        #Otherwise will proceed with the creation

        } else {        
            
            Write-Host "$task_counter. FAILED: The task $name doesn't exist"

        }
    #If the creation is disbled from the csv will save to the log that is disabled
    } else {
        
        $name = $csv[$i].Name
        Write-Host "$task_counter. DISABLED: Task $name is disabled, will not be created"
    }  

}

Stop-Transcript