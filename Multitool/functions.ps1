#Reads the csv file and every row is inserted into array called $csv
Function read_csv{
    Param ($file)
    $global:csv = Import-Csv -Path .\$file
    }

#Returns only the destination folder from the csv file (without the file name) and saves the name into $zip variable
Function get_dest_folder{
    Param ($string)
    $array = $string.Split("\")
    $final = ""
    for ($i = 0; $i -lt ($array.Length - 1); $i++)
    { 
        $final += $array[$i]
        $final += "\"
    }
    return $final
}

Function get_dest_file{
    Param ($string)
    $array = $string.Split("\")
    
    $zip = $array[-1]
    return $zip
}

#Creates folder if not exists by a given route
Function create_if_not_exists{
    Param ($string)
    if (-not(Test-Path -Path $string)){
        [void](New-Item -Path $string -ItemType Directory)
    }
}

#Add to the destination file the date and hour of the backup
Function zip_date{
    $length = $zip.Length - 4
    $zip = $zip.Substring(0,$length)
    $zip += "-" + (Get-Date -Format "dd-MM-yy--HH-mm") + ".zip"
    return $zip
}

#Check if NuGet is installed, otherwise will install it
Function install_nuget{
    if(-Not (Get-PackageProvider | Where-Object { $_.name -eq "NuGet" })){

        #Install the NuGet Package Provider for powershell
        Install-PackageProvider -Name NuGet -Force

        #Check if was installed correctly, if not will close the script with exit code 7
        if(-Not (Get-PackageProvider | Where-Object { $_.name -eq "NuGet" })){
     
            Write-Host "NuGet for Powershell couldn't been installed"
            #Exits the script with custom error code, that means that NuGet couldn't been installed
            Exit 7
    
        } else { Write-Host "NuGet for Powershell has been installed" }

    } else {

    Write-Host "NuGet for Powershell is already installed"

    }
}

#Check if the compress module is installed, otherwise will install it
Function install_7zip{
    if(-Not (Get-Module -ListAvailable | Where-Object { $_.name -eq "7Zip4PowerShell" })){

        #Install the 7zip module for powershell
        Install-Module -Name 7Zip4PowerShell -Force

        #Check if was installed correctly, if not will close the script with exit code 8
        if(-Not (Get-Module -ListAvailable | Where-Object { $_.name -eq "7Zip4PowerShell" })){
         
            Write-Host "7Zip for Powershell couldn't been installed"
            #Exits the script with custom error code, that means that 7Zip couldn't been installed
            Exit 8
    
        } else { Write-Host "7Zip for Powershell has been installed" }

    } else {

        Write-Host "7Zip for Powershell is already installed"
    }
}

#If the value password is empty will not encrypt the compressed file, otherwise will encrypt with the password provided by csv
Function start_compression{
    if ($pass -eq ""){
        Compress-7zip -Path $origin -ArchiveFileName ($csv_destination_folder + $zip) -Format Zip
    } else {
        Compress-7zip -Path $origin -ArchiveFileName ($csv_destination_folder + $zip) -Format SevenZip -Password $pass -EncryptFilenames
    }
}

#Check if the compression was realized successfully
Function compression_check{
    if (Test-Path -Path $destination){
                         
        #Write the output if compression is completed without errors
        Write-Host "$backup_counter." "SUCCESS - From" "$origin" "To" "$destination"

    } else {
            
        #Show error if the zip file is not created
        Write-Host "$backup_counter." "FAILED: ZIP was not correctly created - From" "$origin" "To" "$destination"
    }
}