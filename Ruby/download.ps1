

[System.String]$url_page='https://rubyinstaller.org/downloads/'

$Response = Invoke-WebRequest -Uri "${url_page}"

$Response.GetType()

