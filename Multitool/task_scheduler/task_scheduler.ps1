#Path must end with "\"
$path = ".\"
$log = "task_scheduler-"+(Get-Date -Format "dd-MM-yy--HH-mm") + ".log"
Start-Transcript -Path ($path+$log)

#Import the functions from functions file
. .\functions.ps1

#Read the csv file and save it in the variable $csv
read_csv("task_scheduler.csv")

for ($i = 0; $i -lt $csv.Length; $i++){ 
    $task_counter = $i + 1

    if ($csv[$i].Enabled -eq "Yes"){
    
        #Setting up the variables to be more accessible
        $name = $csv[$i].Name
        $file = $csv[$i].Program
        $path = $csv[$i].Path
        $parameters = $csv[$i].Parameters
        
        #Create the variable to see if the task already exists
        $User= "NT AUTHORITY\SYSTEM"
        $taskExists = Get-ScheduledTask | Where-Object {$_.TaskName -like $name }

        #If exists will show the error and will skip the creation
        if($taskExists) {

            Write-Host "$task_counter. FAILED: Task $name already exists"
        
        #Otherwise will proceed with the creation

        } else {        
            
            create_task

            #Check if exists to write the  correct output
            if($taskExists) {

                Write-Host "$task_counter. FAILED: Task $name couldn't be created"

            } else {

                Write-Host "$task_counter. SUCCESS: Task $name was successfully created" 
            
            }
        }
    #If the creation is disbled from the csv will save to the log that is disabled
    } else {
        
        $name = $csv[$i].Name
        Write-Host "$task_counter. DISABLED: Task $name is disabled, will not be created"
    }  

}

Stop-Transcript