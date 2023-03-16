oh-my-posh init pwsh | Invoke-Expression

# Better tab completion
# keep or reset to powershell default
Set-PSReadlineKeyHandler -Key Shift+Tab -Function TabCompletePrevious

# define Ctrl+Tab like default Tab behavior
Set-PSReadlineKeyHandler -Key Ctrl+Tab -Function TabCompleteNext

# define Tab like bash
Set-PSReadlineKeyHandler -Key Tab -Function Complete


# Aliases
New-Alias -Name vim -Value nvim
