#Import the functions from functions file
. .\functions.ps1

#Read the csv file and save it in the variable $csv
read_csv("target_backups.csv")

#Iterate in every row from the csv file
for ($i = 0; $i -lt $csv.Length; $i++){ 
    $backup_counter = $i + 1

    #Setting up the variables to be more accessible
    $origen = $csv[$i].Origin
    $destination = $csv[$i].Destination

    $csv_destination_folder = get_dest_folder($destination)
    if (Test-Path -Path $origen){
        
        #Create destination folder if doesn't exist
        create_if_not_exists($csv_destination_folder)

        $zip = zip_date

        $destination = $csv_destination_folder + $zip

        #Convert the origin target to zip into destination file
        Compress-Archive -Path $origen -DestinationPath ($csv_destination_folder + $zip)

        #Write the output if compression is completed without errors
        Write-Host "$backup_counter." "From" $origen "To" $destination

    } else {
        
        Write-Host "$backup_counter." "FAILED - From" $origen "To" $destination

    }
   
}