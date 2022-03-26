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
    $global:zip = $array[-1]
    return $final
}

#Creates folder if not exists by a given route
Function create_if_not_exists{
    Param ($string)
    if (-not(Test-Path -Path $string)){
        [void](New-Item -Path $String -ItemType Directory)
    }
}

#Add to the destination file the date and hour of the backup
Function zip_date{
    $length = $zip.Length - 4
    $zip = $zip.Substring(0,$length)
    $zip += "-" + (Get-Date -Format "dd-MM-yy--HH-mm") + ".zip"
    return $zip
}