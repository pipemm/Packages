

[System.String]$url_page='https://rubyinstaller.org/downloads/';

[Microsoft.PowerShell.Commands.BasicHtmlWebResponseObject]$Response = Invoke-WebRequest -Uri "${url_page}";

$Response.Content.GetType().FullName;

$Response.Content;
