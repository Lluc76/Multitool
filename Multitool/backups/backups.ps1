Start-Transcript -Path "transcript.txt"

#Import the functions from functions file
. .\functions.ps1

#Read the csv file and save it in the variable $csv
read_csv("target_backups.csv")

#Check if NuGet is installed, otherwise will install it
install_nuget

#Check if the compress module is installed, otherwise will install it
install_7zip

#Iterate in every row from the csv file
for ($i = 0; $i -lt $csv.Length; $i++){ 
    $backup_counter = $i + 1

    #Setting up the variables to be more accessible
    $origin = $csv[$i].Origin
    $destination = $csv[$i].Destination
    $pass = $csv[$i].Password

    #Replace the %username% string at the origin and destination to the %username% variable
    $origin = $origin.replace("%username%",$env:UserName)
    $destination = $destination.replace("%username%",$env:UserName)

    #Gets the destination folder and the destination file name
    $csv_destination_folder = get_dest_folder($destination)
    $zip = get_dest_file($destination)

    #If $origin path is found will continue
    if (Test-Path -Path $origin){
        
        #If the $origin path contains any file recursively will proceed creating the zip
        if ((Get-ChildItem -Path $origin -Recurse -File -ErrorAction SilentlyContinue -Force) -ne $null){

            #Create destination folder if doesn't exist
            create_if_not_exists($csv_destination_folder)

            #Setting the file name with date and destination
            $zip = zip_date
            $destination = $csv_destination_folder + $zip
                
            #Starts the compression
            start_compression        

            #Check if the compression was realized successfully
            compression_check

        } else {
            
            #If not will show the error
            Write-Host "$backup_counter." "FAILED: Path $origin doesn't contain any files, so can't be compressed - From" "$origin" "To" "$destination"
        }
        

    } else {
        
        #If not will show error
        Write-Host "$backup_counter." "FAILED: Path $origin Not Found - From" "$origin" "To" "$destination"
    }
}

Stop-Transcript