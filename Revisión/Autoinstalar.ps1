# Primero declara el path donde se va a descargar el instalador en cada ruta, lo he repetido en cada uno por si se quiere lanzar individualmente, luego da un nombre a este.
# Tras esto descarga la ultima version del programa desde su repositorio y luego ejecuta el instaler. Una vez terminada la instalacion lo elimina y pasa al siguiente.

$Path = $env:TEMP;
$Installer = "7z2107-x64.exe";
Invoke-WebRequest "https://www.7-zip.org/a/7z2107-x64.exe" -OutFile $Path\$Installer;
Start-Process -FilePath $Path\$Installer -Args "/silent /install" -Verb RunAs -Wait;
Remove-Item $Path\$Installer

$Path = $env:TEMP;
$Installer = "chrome_installer.exe";
Invoke-WebRequest "http://dl.google.com/chrome/install/375.126/chrome_installer.exe" -OutFile $Path\$Installer;
Start-Process -FilePath $Path\$Installer -Args "/silent /install" -Verb RunAs -Wait;
Remove-Item $Path\$Installer

$Path = $env:TEMP;
$Installer = "Firefox.exe";
Invoke-WebRequest "https://download.mozilla.org/?product=firefox-latest-ssl&os=win64&lang=es-ES" -OutFile $Path\$Installer;
Start-Process -FilePath $Path\$Installer -Args "/silent /install" -Verb RunAs -Wait;
Remove-Item $Path\$Installer

$Path = $env:TEMP;
$Installer = "AnyDesk.exe";
Invoke-WebRequest "https://download.anydesk.com/AnyDesk.exe" -OutFile $Path\$Installer;
Start-Process -FilePath $Path\$Installer -Args "/silent /install" -Verb RunAs -Wait;
Remove-Item $Path\$Installer

$Path = $env:TEMP;
$Installer = "readerdc_es_xa_crd_install.exe";
Invoke-WebRequest "https://admdownload.adobe.com/bin/live/readerdc_es_xa_crd_install.exe" -OutFile $Path\$Installer;
Start-Process -FilePath $Path\$Installer -Args "/silent /install" -Verb RunAs -Wait;