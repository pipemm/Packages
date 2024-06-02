
[System.String]$folder_html='HTML\'
New-Item -Path . -Name "${folder_html}" -ItemType 'directory'
New-Item -Path . -Name "${folder_html}a\b\c" -ItemType 'directory'

[System.String]$file_html="${folder_html}index.html"

[System.String]$url_page='https://rubyinstaller.org/downloads/'

