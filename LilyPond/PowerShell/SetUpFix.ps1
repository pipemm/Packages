
[System.String]$PathInstall = 'Package\';
[System.String]$FolderLilyPond = (
    Get-ChildItem -Path "${PathInstall}lilypond-*\" -Directory |
    ForEach-Object -Process {
        [System.String]$PathFound = $_.FullName;
        ${PathFound};
    } |
    Select-Object -First 1
);

[System.String]$PathLilyPond = (Join-Path -Path "${FolderLilyPond}" -ChildPath 'bin');
if ( ! (Test-Path -LiteralPath "${PathLilyPond}" -PathType Container) )
{
    Exit 1;
}

[System.String]$Path = "$Env:Path;${PathLilyPond}";
$Env:Path            = "${Path}";

try { 
    Get-Command -Type Application -Name lilypond;
}
catch { 
    Write-Error -Message 'LilyPond not found.';
    Exit 1;
}

lilypond.exe --version
lilypond.exe --help

if ( $Env:GITHUB_ENV -eq $null ) {
    Exit 0;
}

Exit 0;
