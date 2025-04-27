
if ( [System.Environment]::GetEnvironmentVariable('NODE_VERSION') -eq ${null} ) {
  exit 1;
}

[System.String]${NodeVersion} = [System.Environment]::GetEnvironmentVariable('NODE_VERSION');

[System.String]${Uri} = 'https://nodejs.org/dist/${NodeVersion}/node-${NodeVersion}-win-x64.zip';

${Uri};