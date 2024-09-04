
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

[System.String]$Path = "$Env:PATH;${PathLilyPond}";
$Env:PATH            = "${Path}";

try { 
    Get-Command -Type Application -Name lilypond;
}
catch { 
    Write-Error -Message 'LilyPond not found.';
    Exit 1;
}

[System.String]$PathGO = (Join-Path -Path "${FolderLilyPond}" -ChildPath 'lib\');
Get-ChildItem -LiteralPath "${PathGO}"  -Filter '*.go'  -Recurse -File |
    ForEach-Object -Process {
        [System.IO.FileInfo]$GOFile = $_;
        $GOFile.LastWriteTimeUtc    = [System.DateTime]::UtcNow;
    };

lilypond.exe --version
lilypond.exe --help

if ( $Env:GITHUB_ENV -eq $null ) {
    Exit 0;
}

"PATH_LILYPOND=${PathLilyPond}" 
"PATH_LILYPOND=${PathLilyPond}" >>"$Env:GITHUB_ENV"
"PATH=$Env:PATH" 
"PATH=$Env:PATH"                >>"$Env:GITHUB_ENV"
