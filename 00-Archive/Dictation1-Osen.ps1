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

$OutFile = "$env:USERPROFILE\Downloads\osen_full.mp3"
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

Add-Speech "Осенью."
Add-Pause $P1_Title

Add-Speech "Лес уже сбросил листву."
Add-Pause $P1_Short

Add-Speech "Дни наступили пасмурные, но тихие, без ветра, настоящие дни поздней осени."
Add-Pause $P1_Paragraph

Add-Speech "В такой тусклый день идешь по лесной тропинке среди молодых березок, дубов, осинок, среди кустов орешника."
Add-Pause $P1_Long

Add-Speech "Не слышишь пения птиц, шороха листьев."
Add-Pause $P1_Medium

Add-Speech "Только иногда упадет на землю тяжелый созревший желудь."
Add-Pause 3000

Add-Speech "На голых листьях повисли капли росы от ночного тумана."
Add-Pause $P1_Paragraph

Add-Speech "Далеко видно кругом."
Add-Pause $P1_Short

Add-Speech "Легко дышит осенней свежестью грудь, хочется идти все дальше и дальше по желтой от листвы тропинке."
Add-Pause $P1_Paragraph

Add-Speech "Вдруг среди листвы видишь пестрый комочек."
Add-Pause $P1_Medium

Add-Speech "Это птица обо что-то сильно ударилась во время полета."
Add-Pause $P1_Paragraph

Add-Speech "Надо взять ее домой, а то в лесу птицу мигом разыщет и съест лисица, решаю я."
Add-Pause 10000

# ---------- 2. ДИКТОВКА ПОД ЗАПИСЬ ----------

# Осенью.
Add-Speech "Осенью."
Add-Pause $P2_BeforeSplit
Add-Speech "Осенью."
Add-Pause $P2_EndSentence

# Лес уже сбросил листву.
Add-Speech "Лес уже сбросил листву."
Add-Pause $P2_BeforeSplit
Add-Speech "Лес уже"
Add-Pause $P2_Short
Add-Speech "сбросил листву."
Add-Pause $P2_EndSentence

# Дни наступили пасмурные, но тихие, без ветра, настоящие дни поздней осени.
Add-Speech "Дни наступили пасмурные, но тихие, без ветра, настоящие дни поздней осени."
Add-Pause $P2_BeforeSplit
Add-Speech "Дни наступили пасмурные,"
Add-Pause $P2_Medium
Add-Speech "но тихие,"
Add-Pause $P2_Short
Add-Speech "без ветра,"
Add-Pause $P2_Short
Add-Speech "настоящие дни"
Add-Pause $P2_Short
Add-Speech "поздней осени."
Add-Pause $P2_EndSentence

# В такой тусклый день...
Add-Speech "В такой тусклый день идешь по лесной тропинке среди молодых березок, дубов, осинок, среди кустов орешника."
Add-Pause $P2_BeforeSplit
Add-Speech "В такой тусклый день"
Add-Pause $P2_Long
Add-Speech "идешь по лесной тропинке"
Add-Pause $P2_Long
Add-Speech "среди молодых березок,"
Add-Pause $P2_Medium
Add-Speech "дубов, осинок,"
Add-Pause $P2_Short
Add-Speech "среди кустов орешника."
Add-Pause $P2_EndSentence

# Не слышишь...
Add-Speech "Не слышишь пения птиц, шороха листьев."
Add-Pause $P2_BeforeSplit
Add-Speech "Не слышишь"
Add-Pause $P2_Short
Add-Speech "пения птиц,"
Add-Pause $P2_Short
Add-Speech "шороха листьев."
Add-Pause $P2_EndSentence

# Только иногда...
Add-Speech "Только иногда упадет на землю тяжелый созревший желудь."
Add-Pause $P2_BeforeSplit
Add-Speech "Только иногда"
Add-Pause $P2_Short
Add-Speech "упадет на землю"
Add-Pause $P2_Medium
Add-Speech "тяжелый созревший желудь."
Add-Pause $P2_Medium
Add-Pause $P2_EndSentence

# На голых листьях...
Add-Speech "На голых листьях повисли капли росы от ночного тумана."
Add-Pause $P2_BeforeSplit
Add-Speech "На голых листьях"
Add-Pause $P2_Medium
Add-Speech "повисли капли росы"
Add-Pause $P2_Medium
Add-Speech "от ночного тумана."
Add-Pause $P2_Medium
Add-Pause $P2_EndSentence

# Далеко видно кругом.
Add-Speech "Далеко видно кругом."
Add-Pause $P2_BeforeSplit
Add-Speech "Далеко видно"
Add-Pause $P2_Short
Add-Speech "кругом."
Add-Pause $P2_EndSentence

# Легко дышит...
Add-Speech "Легко дышит осенней свежестью грудь, хочется идти все дальше и дальше по желтой от листвы тропинке."
Add-Pause $P2_BeforeSplit
Add-Speech "Легко дышит"
Add-Pause $P2_Short
Add-Speech "осенней свежестью грудь,"
Add-Pause $P2_Medium
Add-Speech "хочется идти"
Add-Pause $P2_Short
Add-Speech "все дальше и дальше"
Add-Pause $P2_Medium
Add-Speech "по желтой от листвы тропинке."
Add-Pause $P2_Long
Add-Pause $P2_EndSentence

# Вдруг среди листвы...
Add-Speech "Вдруг среди листвы видишь пестрый комочек."
Add-Pause $P2_BeforeSplit
Add-Speech "Вдруг среди листвы"
Add-Pause $P2_Medium
Add-Speech "видишь пестрый комочек."
Add-Pause $P2_Medium
Add-Pause $P2_EndSentence

# Это птица...
Add-Speech "Это птица обо что-то сильно ударилась во время полета."
Add-Pause $P2_BeforeSplit
Add-Speech "Это птица"
Add-Pause $P2_Short
Add-Speech "обо что-то сильно ударилась"
Add-Pause $P2_Long
Add-Speech "во время полета."
Add-Pause $P2_Medium
Add-Pause $P2_EndSentence

# Надо взять ее домой...
Add-Speech "Надо взять ее домой, а то в лесу птицу мигом разыщет и съест лисица, решаю я."
Add-Pause $P2_BeforeSplit
Add-Speech "Надо взять ее домой,"
Add-Pause $P2_Medium
Add-Speech "а то в лесу"
Add-Pause $P2_Short
Add-Speech "птицу мигом разыщет"
Add-Pause $P2_Medium
Add-Speech "и съест лисица,"
Add-Pause $P2_Short
Add-Speech "решаю я."
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