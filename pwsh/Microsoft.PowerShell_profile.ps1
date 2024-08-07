oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH/huvix.omp.json" | Invoke-Expression
fnm env --use-on-cd | Out-String | Invoke-Expression
Import-Module ZLocation