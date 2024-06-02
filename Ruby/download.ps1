

[System.String]$URLPage = 'https://rubyinstaller.org/downloads/';

## [Microsoft.PowerShell.Commands.BasicHtmlWebResponseObject]
[Microsoft.PowerShell.Commands.HtmlWebResponseObject]$Response = Invoke-WebRequest -Uri "${URLPage}";

[System.String]$Content = ${Response}.Content;

$Content -split "`n" |
  Select-String -Pattern 'download-recommended';

