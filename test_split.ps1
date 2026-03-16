param(
    [string]$Text
)

cls

function Split-Sentences {
    param([string]$Paragraph)

    if ([string]::IsNullOrWhiteSpace($Paragraph)) { return @() }

    $Paragraph = $Paragraph -replace "`r",' '
    $Paragraph = $Paragraph -replace "`n",' '

    return [regex]::Split($Paragraph.Trim(), '(?<=[.!?])\s+')
}

function Get-WordCount {
    param([string]$Text)
    if ([string]::IsNullOrWhiteSpace($Text)) { return 0 }
    (@($Text.Trim() -split '\s+' | Where-Object { $_ })).Count
}

function Split-LongChunk {
    param([string]$Chunk)

    $words = $Chunk -split '\s+'

    if ($words.Count -le 5) {
        return @($Chunk)
    }

    if ($words.Count -gt 5) {
        $mid = [math]::Floor($words.Count / 2)

        return @(
            ($words[0..($mid-1)] -join ' '),
            ($words[$mid..($words.Count-1)] -join ' ')
        )
    }
}

function Split-Phrase {
    param([string]$Sentence)

    $core = $Sentence
    if ($core -match '[.!?]$') {
        $core = $core.Substring(0,$core.Length-1)
    }

    $chunks = $core.Split(',') | % { $_.Trim() }

    $result = @()

    foreach ($chunk in $chunks) {
        $result += Split-LongChunk $chunk
    }

    return $result
}

Write-Host ""
Write-Host "=== SENTENCES ===" -ForegroundColor Cyan

$sentences = Split-Sentences $Text

$i=1
foreach ($s in $sentences) {
    Write-Host "$i`t$s"
    $i++
}

Write-Host ""
Write-Host "=== PHRASES ===" -ForegroundColor Yellow

foreach ($s in $sentences) {

    Write-Host ""
    Write-Host $s -ForegroundColor Green

    $phrases = Split-Phrase $s

    foreach ($p in $phrases) {
        Write-Host "   -> $p"
    }
}