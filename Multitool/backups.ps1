#Import the functions from functions file
. .\functions.ps1

#Read the csv file and save it in the variable $csv
read_csv("target_backups.csv")

#Check if the compress module is installed, otherwise will install it
if(-Not (Get-Module -ListAvailable | Where-Object { $_.name -eq "7Zip4PowerShell" }))
{
    #Install the 7zip module for powershell
    Install-Module -Name 7Zip4PowerShell -Force

    #Check if was installed correctly, if not will close the script with exit code 8
    if(-Not (Get-Module -ListAvailable | Where-Object { $_.name -eq "7Zip4PowerShell" }))
    { 
    Write-Host "7Zip for Powershell couldn't been installed"
    #Exits the script with custom error code, that means that 7Zip couldn't been installed
    Exit 8
    
    } else { Write-Host "7Zip for Powershell has been installed" }

} else {
    Write-Host "7Zip for Powershell is already installed"
}

#Iterate in every row from the csv file
for ($i = 0; $i -lt $csv.Length; $i++){ 
    $backup_counter = $i + 1

    #Setting up the variables to be more accessible
    $origin = $csv[$i].Origin
    $destination = $csv[$i].Destination
    $pass = $csv[$i].Password

    $origin = $origin.replace("%username%",$env:UserName)
    $destination = $destination.replace("%username%",$env:UserName)

    $csv_destination_folder = get_dest_folder($destination)
    $zip = get_dest_file($destination)

    #If $origin path is found will create the zip
    if (Test-Path -Path $origin){
        
        #Create destination folder if doesn't exist
        create_if_not_exists($csv_destination_folder)

        #Setting the file name with date and destination
        $zip = zip_date
        $destination = $csv_destination_folder + $zip
        echo $zip
        echo $destination
        
        #Convert the origin target to zip into destination file

        #If the value password is empty will not encrypt the compressed file, otherwise will encrypt with the password provided by csv
        if ($pass -eq ""){
            Compress-7zip -Path $origin -ArchiveFileName ($csv_destination_folder + $zip) -Format Zip
        } else {
            Compress-7zip -Path $origin -ArchiveFileName ($csv_destination_folder + $zip) -Format SevenZip -Password $pass -EncryptFilenames
        }

        if (Test-Path -Path $destination){
                         
            #Write the output if compression is completed without errors
            Write-Host "$backup_counter." "SUCCESS - From" "$origin" "To" "$destination"

        } else {
            
            #Show error if the zip file is not created
            Write-Host "$backup_counter." "FAILED: ZIP was not correctly created - From" "$origin" "To" "$destination"
        }

    } else {
        
        #If not will show error
        Write-Host "$backup_counter." "FAILED: Path $origin Not Found - From" "$origin" "To" "$destination"
    }
}