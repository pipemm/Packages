

[System.String]$URLPage = 'https://rubyinstaller.org/downloads/';

[Microsoft.PowerShell.Commands.BasicHtmlWebResponseObject]$Response = Invoke-WebRequest -Uri "${URLPage}";

[System.String]$Content = ${Response}.Content;

($Content -split "`n" |
  Select-String -Pattern 'download-recommended').ToString();

