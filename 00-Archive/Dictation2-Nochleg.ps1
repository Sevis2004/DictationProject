cls
$ApiKey = ""
$Voice  = "ermil"
$Speed  = "1.00"

# Паузы первого чтения
$P1_Title      = 1200
$P1_Short      = 1000
$P1_Medium     = 1500
$P1_Long       = 2200
$P1_Paragraph  = 2500

# Паузы диктовки под запись
$P2_BeforeSplit = 5500
$P2_Short       = 7500
$P2_Medium      = 9000
$P2_Long        = 10500
$P2_EndSentence = 11500

$OutFile = $OutFile = "$env:USERPROFILE\Downloads\nochleg_full.mp3"
$WorkDir = Join-Path $env:TEMP ("dictation_" + [guid]::NewGuid().ToString())
New-Item -ItemType Directory -Path $WorkDir | Out-Null

# Поиск ffmpeg.exe
$Ffmpeg = $null
$wingetRoot = Join-Path $env:LOCALAPPDATA "Microsoft\WinGet\Packages"
if (Test-Path $wingetRoot) {
    $pkg = Get-ChildItem $wingetRoot -Directory -Filter "Gyan.FFmpeg*" -ErrorAction SilentlyContinue |
        Sort-Object LastWriteTime -Descending |
        Select-Object -First 1
    if ($pkg) {
        $ff = Get-ChildItem $pkg.FullName -Recurse -Filter "ffmpeg.exe" -ErrorAction SilentlyContinue |
            Select-Object -First 1
        if ($ff) { $Ffmpeg = $ff.FullName }
    }
}
if (-not $Ffmpeg) {
    $cmd = Get-Command ffmpeg.exe -ErrorAction SilentlyContinue
    if ($cmd) { $Ffmpeg = $cmd.Source }
}
if (-not $Ffmpeg) {
    throw "ffmpeg.exe не найден. Укажите путь вручную."
}

$Sequence = New-Object System.Collections.Generic.List[object]

function Add-Speech([string]$Text) {
    $Sequence.Add([pscustomobject]@{ Kind = "speech"; Value = $Text })
}

function Add-Pause([int]$Ms) {
    $Sequence.Add([pscustomobject]@{ Kind = "pause"; Value = $Ms })
}

# ---------- 1. ПЕРВОЕ ЧТЕНИЕ ЦЕЛИКОМ ----------

Add-Speech 'Ночлег в лесу.'
Add-Pause $P1_Title

Add-Speech 'Ребята расположились на опушке леса.'
Add-Pause $P1_Medium

Add-Speech 'Одни побежали собирать хворост, другие рубили ветви для шалаша.'
Add-Pause $P1_Long

Add-Speech 'Остальные разбирали вещи, вынимали съестное, котелки, кружки, ложки.'
Add-Pause $P1_Paragraph

Add-Speech 'Между тем заря угасла.'
Add-Pause $P1_Short

Add-Speech 'Смеркалось.'
Add-Pause $P1_Short

Add-Speech 'Вот из лесу раздаются веселые голоса.'
Add-Pause $P1_Medium

Add-Speech 'В ответ послышались радостные крики ожидающих.'
Add-Pause $P1_Medium

Add-Speech 'Большие вязанки хвороста сгружаются на полянке.'
Add-Pause $P1_Paragraph

Add-Speech 'Сколько охотников разводить костер!'
Add-Pause $P1_Medium

Add-Speech 'Ребята с увлечением раздувают первые искры огоньков.'
Add-Pause $P1_Medium

Add-Speech 'Дым от костра расстилается густой завесой, и скоро он разгорается.'
Add-Pause $P1_Long

Add-Speech 'Весело забулькала в котелке вода.'
Add-Pause $P1_Paragraph

Add-Speech 'Вскоре все отужинали и стали готовиться ко сну.'
Add-Pause $P1_Medium

Add-Speech 'Но не забывают они потолкаться, побороться, поспорить.'
Add-Pause $P1_Medium

Add-Speech 'А подниматься нужно с рассветом!'
Add-Pause $P1_Medium

Add-Speech 'Раздается команда: Всем спать!'
Add-Pause $P1_Short

Add-Speech 'Лагерь быстро затихает.'
Add-Pause 10000

# ---------- 2. ДИКТОВКА ПОД ЗАПИСЬ ----------

Add-Speech 'Ночлег в лесу.'
Add-Pause $P2_BeforeSplit
Add-Speech 'Ночлег в лесу.'
Add-Pause $P2_EndSentence

Add-Speech 'Ребята расположились на опушке леса.'
Add-Pause $P2_BeforeSplit
Add-Speech 'Ребята расположились'
Add-Pause $P2_Medium
Add-Speech 'на опушке леса.'
Add-Pause $P2_EndSentence

Add-Speech 'Одни побежали собирать хворост, другие рубили ветви для шалаша.'
Add-Pause $P2_BeforeSplit
Add-Speech 'Одни побежали'
Add-Pause $P2_Short
Add-Speech 'собирать хворост,'
Add-Pause $P2_Short
Add-Speech 'другие рубили ветви'
Add-Pause $P2_Medium
Add-Speech 'для шалаша.'
Add-Pause $P2_EndSentence

Add-Speech 'Остальные разбирали вещи, вынимали съестное, котелки, кружки, ложки.'
Add-Pause $P2_BeforeSplit
Add-Speech 'Остальные разбирали вещи,'
Add-Pause $P2_Medium
Add-Speech 'вынимали съестное,'
Add-Pause $P2_Short
Add-Speech 'котелки, кружки, ложки.'
Add-Pause $P2_EndSentence

Add-Speech 'Следующий абзац.'
Add-Pause 3000

Add-Speech 'Между тем заря угасла.'
Add-Pause $P2_BeforeSplit
Add-Speech 'Между тем'
Add-Pause $P2_Short
Add-Speech 'заря угасла.'
Add-Pause $P2_EndSentence

Add-Speech 'Смеркалось.'
Add-Pause $P2_BeforeSplit
Add-Speech 'Смеркалось.'
Add-Pause $P2_EndSentence

Add-Speech 'Вот из лесу раздаются веселые голоса.'
Add-Pause $P2_BeforeSplit
Add-Speech 'Вот из лесу'
Add-Pause $P2_Short
Add-Speech 'раздаются веселые голоса.'
Add-Pause $P2_EndSentence

Add-Speech 'В ответ послышались радостные крики ожидающих.'
Add-Pause $P2_BeforeSplit
Add-Speech 'В ответ послышались'
Add-Pause $P2_Medium
Add-Speech 'радостные крики ожидающих.'
Add-Pause $P2_EndSentence

Add-Speech 'Большие вязанки хвороста сгружаются на полянке.'
Add-Pause $P2_BeforeSplit
Add-Speech 'Большие вязанки хвороста'
Add-Pause $P2_Medium
Add-Speech 'сгружаются на полянке.'
Add-Pause $P2_EndSentence

Add-Speech 'Следующий абзац.'
Add-Pause 3000

Add-Speech 'Сколько охотников разводить костер!'
Add-Pause $P2_BeforeSplit
Add-Speech 'Сколько охотников'
Add-Pause $P2_Short
Add-Speech 'разводить костер!'
Add-Pause $P2_EndSentence

Add-Speech 'Ребята с увлечением раздувают первые искры огоньков.'
Add-Pause $P2_BeforeSplit
Add-Speech 'Ребята с увлечением'
Add-Pause $P2_Medium
Add-Speech 'раздувают первые искры огоньков.'
Add-Pause $P2_EndSentence

Add-Speech 'Дым от костра расстилается густой завесой, и скоро он разгорается.'
Add-Pause $P2_BeforeSplit
Add-Speech 'Дым от костра'
Add-Pause $P2_Short
Add-Speech 'расстилается густой завесой,'
Add-Pause $P2_Medium
Add-Speech 'и скоро'
Add-Pause $P2_Short
Add-Speech 'он разгорается.'
Add-Pause $P2_EndSentence

Add-Speech 'Весело забулькала в котелке вода.'
Add-Pause $P2_BeforeSplit
Add-Speech 'Весело забулькала'
Add-Pause $P2_Short
Add-Speech 'в котелке вода.'
Add-Pause $P2_EndSentence

Add-Speech 'Следующий абзац.'
Add-Pause 3000

Add-Speech 'Вскоре все отужинали и стали готовиться ко сну.'
Add-Pause $P2_BeforeSplit
Add-Speech 'Вскоре все отужинали'
Add-Pause $P2_Medium
Add-Speech 'и стали готовиться'
Add-Pause $P2_Medium
Add-Speech 'ко сну.'
Add-Pause $P2_EndSentence

Add-Speech 'Но не забывают они потолкаться, побороться, поспорить.'
Add-Pause $P2_BeforeSplit
Add-Speech 'Но не забывают они'
Add-Pause $P2_Medium
Add-Speech 'потолкаться, побороться,'
Add-Pause $P2_Medium
Add-Speech 'поспорить.'
Add-Pause $P2_EndSentence

Add-Speech 'А подниматься нужно с рассветом!'
Add-Pause $P2_BeforeSplit
Add-Speech 'А подниматься нужно'
Add-Pause $P2_Medium
Add-Speech 'с рассветом!'
Add-Pause $P2_EndSentence

Add-Speech 'Раздается команда: Всем спать!'
Add-Pause $P2_BeforeSplit
Add-Speech 'Раздается команда:'
Add-Pause $P2_Short
Add-Speech 'Всем спать!'
Add-Pause $P2_EndSentence

Add-Speech 'Лагерь быстро затихает.'
Add-Pause $P2_BeforeSplit
Add-Speech 'Лагерь быстро'
Add-Pause $P2_Short
Add-Speech 'затихает.'
Add-Pause $P2_EndSentence

function New-SpeechWav([string]$Text, [int]$Index) {
    $mp3 = Join-Path $WorkDir ("chunk_{0:D3}.mp3" -f $Index)
    $wav = Join-Path $WorkDir ("chunk_{0:D3}.wav" -f $Index)

    $ok = $false

    for ($attempt = 1; $attempt -le 4; $attempt++) {
        if (Test-Path $mp3) { Remove-Item $mp3 -Force -ErrorAction SilentlyContinue }

        & curl.exe --http1.1 -sS `
          --retry 4 --retry-all-errors --retry-delay 2 `
          --connect-timeout 20 --max-time 120 `
          -X POST "https://tts.api.cloud.yandex.net/speech/v1/tts:synthesize" `
          -H "Authorization: Api-Key $ApiKey" `
          -H "Content-Type: application/x-www-form-urlencoded" `
          --data-urlencode "text=$Text" `
          --data-urlencode "lang=ru-RU" `
          --data-urlencode "voice=$Voice" `
          --data-urlencode "speed=$Speed" `
          --data-urlencode "format=mp3" `
          -o $mp3

        if ($LASTEXITCODE -eq 0 -and (Test-Path $mp3)) {
            $head = Get-Content $mp3 -Raw -Encoding UTF8 -ErrorAction SilentlyContinue
            if ($head -notlike '{"error_code"*') {
                $ok = $true
                break
            }
        }

        Start-Sleep -Seconds 3
    }

    if (-not $ok) {
        throw "Не удалось синтезировать фразу после повторов: $Text"
    }

    & $Ffmpeg -y -loglevel error -i $mp3 -ar 48000 -ac 1 -c:a pcm_s16le $wav
    if ($LASTEXITCODE -ne 0) {
        throw "Ошибка ffmpeg при конвертации фразы: $Text"
    }

    Remove-Item $mp3 -Force
    return $wav
}

$Files = New-Object System.Collections.Generic.List[string]
$Index = 1

foreach ($item in $Sequence) {
    if ($item.Kind -eq "speech") {
        $Files.Add((New-SpeechWav -Text $item.Value -Index $Index))
    } else {
        $Files.Add((New-SilenceWav -Ms $item.Value -Index $Index))
    }
    $Index++
    Start-Sleep -Milliseconds 400
}

$ListFile = Join-Path $WorkDir "concat.txt"
$ConcatLines = $Files | ForEach-Object { "file '$($_ -replace '\\','/')'" }

$Utf8NoBom = New-Object System.Text.UTF8Encoding($false)
[System.IO.File]::WriteAllLines($ListFile, $ConcatLines, $Utf8NoBom)

& $Ffmpeg -y -loglevel error -f concat -safe 0 -i $ListFile -ar 48000 -ac 1 -c:a libmp3lame -b:a 128k $OutFile
if ($LASTEXITCODE -ne 0) {
    throw "Ошибка сборки итогового mp3"
}

Write-Host "Готово: $OutFile"
Write-Host "Временные файлы: $WorkDir"