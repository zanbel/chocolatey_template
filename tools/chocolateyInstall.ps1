# Printing to log prerequisities
Write-Host("Artifactory OSS version 3.5.1")
Write-Host("NOTE: To use Artifactory you must have JDK (version 7 update 21 and above) installed and added to Path environment variable")

# Artifactory-3.5.1 OSS Chocolatey package
# Setting variables
$packageName = 'Artifactory'
$zipUrl = 'https://bintray.com/artifact/download/jfrog/artifactory/artifactory-3.5.1.zip'
$installDir = (get-location).Drive.Name + ":\artifactory"
$artiDir = "$installDir\artifactory-3.5.1"
$pathToBin = "$artiDir\bin"

try{
    # Setting ARTIFACTORY_HOME environment variable
    [Environment]::SetEnvironmentVariable("ARTIFACTORY_HOME", $artiDir, "Machine")
    Write-Host("Setting ARTIFACTORY_HOME env variable to $artiDir")

    # Getting Path environment vriable
    $path = [Environment]::GetEnvironmentVariable("Path", "Machine")
    
    # Checking if Path already contains link to Artifactory\bin directory
    if (!$path.Contains($pathToBin))
    {
        # Adding link to Artifactory\bin in Path environment variable
        [Environment]::SetEnvironmentVariable("Path", $pathToBin + ';' + $path,"Machine") 
        Write-Host("Added '%SYSTEM DRIVE%\artifactory\artifactory-3.5.1\bin' to Path environment variable")
    }
    # Ectracting zip package to install directory
    Install-ChocolateyZipPackage "$packageName" "$zipUrl" "$installDir"

    Write-Host("To start Artifactory reopen CMD and type 'artifactory start'")
}
# Catching and printing error before throwing
catch{
    Write-ChocolateyFailure "$packageName" "$($_.Exception.Message)"
    throw
}