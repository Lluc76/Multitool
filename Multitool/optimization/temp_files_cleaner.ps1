#Import the functions from functions file
. .\functions.ps1

#Read the csv file and save it in the variable $csv
read_csv("temp_paths.csv")

#Borra los archivos temporales
for ($i = 0; $i -lt $csv.Length; $i++){ 
    $backup_counter = $i + 1

    
}
$Path = "C:\Users\%username%\AppData\Local\Temp\*"

$Path = $Path.replace("%username%",$env:UserName)

if (Test-Path -Path $Path)
{
    Remove-Item -Path $Path -Recurse -Force -ErrorAction SilentlyContinue
}

$Path = "C:\Windows\Temp"

if (Test-Path -Path $Path)
{
    Remove-Item -Path $Path -Recurse -Force -ErrorAction SilentlyContinue
}

#Modificar ajustes para maximizar rendimiento