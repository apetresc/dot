# This is the CurrentUserAllHosts for Powershell 7.x.
#
#    PS> $PROFILE | Select-Object *Host* | Format-List
#    
#    AllUsersAllHosts       : C:\Program Files\PowerShell\7\profile.ps1
#    AllUsersCurrentHost    : C:\Program Files\PowerShell\7\Microsoft.PowerShell_profile.ps1
#    CurrentUserAllHosts    : C:\Users\<user>\Documents\PowerShell\profile.ps1
#    CurrentUserCurrentHost : C:\Users\<user>\Documents\PowerShell\Microsoft.PowerShell_profile.ps1


# Activate oh-my-posh
oh-my-posh init pwsh | Invoke-Expression

# Better tab completion
## keep or reset to powershell default
Set-PSReadlineKeyHandler -Key Shift+Tab -Function TabCompletePrevious

## define Ctrl+Tab like default Tab behavior
Set-PSReadlineKeyHandler -Key Ctrl+Tab -Function TabCompleteNext

## define Tab like bash
Set-PSReadlineKeyHandler -Key Tab -Function Complete


# Aliases
Set-Alias -Name kc -Value kubectl
Set-Alias -Name tf -Value terraform
Set-Alias -Name vim -Value nvim

## github-copilot-cli aliases
## [Thanks Scott Hanselman!](https://www.hanselman.com/blog/github-copilot-for-cli-for-powershell)

function ?? { 
    $TmpFile = New-TemporaryFile
    github-copilot-cli what-the-shell ('use powershell to ' + $args) --shellout $TmpFile
    if ([System.IO.File]::Exists($TmpFile)) { 
        $TmpFileContents = Get-Content $TmpFile
            if ($TmpFileContents -ne $nill) {
            Invoke-Expression $TmpFileContents
            Remove-Item $TmpFile
        }
    }
}
 
function git? {
    $TmpFile = New-TemporaryFile
    github-copilot-cli git-assist $args --shellout $TmpFile
    if ([System.IO.File]::Exists($TmpFile)) {
        $TmpFileContents = Get-Content $TmpFile
            if ($TmpFileContents -ne $nill) {
            Invoke-Expression $TmpFileContents
            Remove-Item $TmpFile
        }
    }
}
function gh? {
    $TmpFile = New-TemporaryFile
    github-copilot-cli gh-assist $args --shellout $TmpFile
    if ([System.IO.File]::Exists($TmpFile)) {
        $TmpFileContents = Get-Content $TmpFile
            if ($TmpFileContents -ne $nill) {
            Invoke-Expression $TmpFileContents
            Remove-Item $TmpFile
        }
    }
}
