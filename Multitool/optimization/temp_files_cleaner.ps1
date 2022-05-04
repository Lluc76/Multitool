#Path must end with "\"
$path = ".\"
$log = "temp_cleaner-"+(Get-Date -Format "dd-MM-yy--HH-mm") + ".log"
Start-Transcript -Path ($path+$log)

#Import the functions from functions file
. .\functions.ps1

#Read the csv file and save it in the variable $csv
read_csv("temp_paths.csv")

#Borra los archivos temporales
for ($i = 0; $i -lt $csv.Length; $i++){ 
    $temp_counter = $i + 1

    if ($csv[$i].Enabled -eq "Yes"){

        $path = $csv[$i].Path
        $userloggedin = (Get-WmiObject -Class Win32_ComputerSystem | Select-Object UserName).UserName.Split('\')[1]
        $path = $path.replace("%username%",$userloggedin)
    
        if (Test-Path -Path $path){

            Remove-Item -Path $path -Recurse -Force -ErrorAction SilentlyContinue

            if (Test-Path -Path $path){

                Write-Host "$temp_counter. FAILED: The path $path couldn't been cleaned"
            } else { "$temp_counter. SUCCESS: The path $path was successfully cleaned" }
        }

    } else {
        
        Write-Host "$temp_counter. DISABLED: Cleaning temp $path is disabled"
    }

}

Stop-Transcript