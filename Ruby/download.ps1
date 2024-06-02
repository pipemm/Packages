
[System.String]$folder_html='HTML\'
New-Item -Path . -Name "${folder_html}" -ItemType 'directory'

[System.String]$file_html="${folder_html}index.html"
[System.String]$url_page='https://rubyinstaller.org/downloads/'

Invoke-WebRequest -Uri "${url_page}" -OutFile "${file_html}"

$Response = Invoke-WebRequest -Uri "${url_page}"

$Response.GetType()

$Response 

