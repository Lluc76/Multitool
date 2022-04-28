#Borra los archivos temporales

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