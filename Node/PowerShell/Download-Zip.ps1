
if ( [System.Environment]::GetEnvironmentVariable('NODE_VERSION') -eq ${null} ) {
  exit 1;
}

[System.String]${FolderDownload} = 'Download\'
New-Item -Path "${FolderDownload}" -ItemType Directory -Force;
[System.String]${FolderDownload} = (Resolve-Path -Path "${FolderDownload}");

[System.String]${FolderUnzipped} = 'Unzipped\'
New-Item -Path "${FolderUnzipped}" -ItemType Directory -Force;
[System.String]${FolderUnzipped} = (Resolve-Path -Path "${FolderUnzipped}");


[System.String]${NodeVersion} = [System.Environment]::GetEnvironmentVariable('NODE_VERSION');
[System.String]${Uri}         = "https://nodejs.org/dist/${NodeVersion}/node-${NodeVersion}-win-x64.zip";
[System.String]${FileName}    = [System.IO.Path]::GetFileName("${Uri}");
[System.String]${OutFile}     = Join-Path -Path "${FolderDownload}" -ChildPath "${FileName}";

Invoke-WebRequest -Uri "${Uri}" `
  -OutFile "${OutFile}"

Expand-Archive -LiteralPath "${OutFile}" `
  -DestinationPath "${FolderUnzipped}"

if ( [System.Environment]::GetEnvironmentVariable('GITHUB_ENV') -eq ${null} ) {
  exit 0;
}

[System.String]${GITHUB_ENV} = [System.Environment]::GetEnvironmentVariable('GITHUB_ENV');

[System.String]${ArtifactName} = [System.IO.Path]::GetFileNameWithoutExtension("${FileName}");
"ArtifactName=${ArtifactName}" >> "${GITHUB_ENV}"

