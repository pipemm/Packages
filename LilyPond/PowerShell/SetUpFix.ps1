
[System.String]$PathInstall = 'Package\';
[System.String]$FolderLilyPond = (
    Get-ChildItem -Path "${PathInstall}lilypond-*\" -Directory |
    ForEach-Object -Process {
        [System.String]$PathFound = $_.FullName;
        ${PathFound};
    } |
    Select-Object -First 1
);

if ( ${FolderLilyPond} -eq '' )
{
    Exit 1;
}

Exit 1;

Join-Path -Path "${FolderLilyPond}" -ChildPath 'bin';

