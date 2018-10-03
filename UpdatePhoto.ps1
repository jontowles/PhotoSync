##Your local working directory for photos
$dest = "C:\users\mobilejon\Desktop\GALUpdate"
##The final home for photos after the upload
$photorepo = "\\fileserver\Photos"
##The place where the photos sent to UpdateMyPhoto are stored when ready to be ingested
$newphotoloc = "\\fileserver\PhotoUpdates"

##Import Photos to the GAL##
$Session = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri http://exchange.test.com/Powershell/ -Authentication Kerberos
Import-PSSession $Session
##Copy-Item -path $newphotoloc -Destination $dest\NewPhotos
Get-ChildItem -Path $newphotoloc| foreach { Import-RecipientDataProperty –Identity $_.BaseName –Picture –FileData ([Byte[]]$(Get-Content –Path $_.FullName –Encoding Byte –ReadCount 0)) }

##Cleanup Pictures and CSV after Completed##

Move-Item -Path $newphotoloc\*jpg -destination $photorepo -force
##Remove-Item -Path $dest\NewPhotos\*.*
##Remove-Item -Path $newphotoloc
Update-OfflineAddressBook -Identity "Default Offline Address List"
echo "Upload Completed!"
