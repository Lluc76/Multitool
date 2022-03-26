#Import the functions from functions file
. .\functions.ps1

#Read the csv file and save it in the variable $csv
read_csv("target_backups.csv")

#Iterate in every row from the csv file
for ($i = 0; $i -lt $csv.Length; $i++){ 
    $backup_counter = $i + 1

    #Setting up the variables to be more accessible
    $origin = $csv[$i].Origin
    $destination = $csv[$i].Destination

    $csv_destination_folder = get_dest_folder($destination)

    #If $origin path is found will create the zip
    if (Test-Path -Path $origin){
        
        #Create destination folder if doesn't exist
        create_if_not_exists($csv_destination_folder)

        #Setting the file name with date and destination
        $zip = zip_date
        $destination = $csv_destination_folder + $zip

        #Convert the origin target to zip into destination file
        Compress-Archive -Path $origin -DestinationPath ($csv_destination_folder + $zip) -Force

        if (Test-Path -Path $destination){
                         
            #Write the output if compression is completed without errors
            Write-Host "$backup_counter." "SUCCESS - From" $origin "To" $destination

        } else {
            
            #Show error if the zip file is not created
            Write-Host "$backup_counter." "FAILED: ZIP was not correctly created - From" $origin "To" $destination
        }

    } else {
        
        #If not will show error
        Write-Host "$backup_counter." "FAILED: Path $origin Not Found - From" $origin "To" $destination
    }
}