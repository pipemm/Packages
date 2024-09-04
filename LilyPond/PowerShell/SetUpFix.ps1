
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
if ( -Not Test-Path -LiteralPath "${PathLilyPond}" -PathType Container )
{
    Exit 1;
}

[System.String]$Path = "$Env:Path;${PathLilyPond}";
$Env:Path            = "${Path}";

Get-Command -Type Application -Name lilypond;
