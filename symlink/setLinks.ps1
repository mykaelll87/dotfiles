$links = Get-Content links.json | ConvertFrom-Json

foreach ($link in $links) {
    $from = $ExecutionContext.InvokeCommand.ExpandString($link.from)
    $to = $ExecutionContext.InvokeCommand.ExpandString($link.to)
    $from
    $to
    New-Item -ItemType $link.mode -Path $to -Target $from
}