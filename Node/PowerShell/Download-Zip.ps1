
if ( [System.Environment]::GetEnvironmentVariable('NODE_VERSION') -eq ${null} ) {
  exit 1;
}

[System.String]${FolderDownload} = 'Download\'
New-Item -Path "${FolderDownload}" -ItemType Directory -Force;
[System.String]${FolderDownload} = (Resolve-Path -Path "${FolderDownload}");


[System.String]${NodeVersion} = [System.Environment]::GetEnvironmentVariable('NODE_VERSION');
[System.String]${Uri}         = "https://nodejs.org/dist/${NodeVersion}/node-${NodeVersion}-win-x64.zip";
[System.String]${FileName}    = [System.IO.Path]::GetFileName("${Uri}");
${Uri};
Join-Path -Path "${FolderDownload}" -ChildPath "${FileName}";
