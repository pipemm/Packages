

[System.String]$URLPage = 'https://rubyinstaller.org/downloads/';

## [Microsoft.PowerShell.Commands.BasicHtmlWebResponseObject]
## [Microsoft.PowerShell.Commands.HtmlWebResponseObject]
[Microsoft.PowerShell.Commands.BasicHtmlWebResponseObject]$Response = Invoke-WebRequest -Uri "${URLPage}";

[System.String[]]$Content = ${Response}.Content -split "`n";

[System.String]$LinesMatched = ($Content |
  Select-String -Pattern 'download-recommended').ToString();

if( $LinesMatched -match ' ([0-9]+\.[0-9]+\.[0-9]+(-[0-9]+)?)\b' ) {
  [System.String]$Version = $Matches[1];
}

if ( -not ${Version} ) {
  Write-Host "Version is not found."
  exit 1
}

[System.String]$NameFile = [System.Text.RegularExpressions.Regex]::Escape("rubyinstaller-${Version}-x64.7z")

$Content |
  Select-String -Pattern "${NameFile}"
