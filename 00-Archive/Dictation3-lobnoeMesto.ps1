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

$OutFile = $OutFile = "$env:USERPROFILE\Downloads\lobnoe_mesto_full.mp3"
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

Add-Speech 'Лобное место.'
Add-Pause $P1_Title

Add-Speech 'Лобное место — древнейший архитектурный памятник Москвы.'
Add-Pause $P1_Long

Add-Speech 'Первоначально это был округлый кирпичный помост с деревянной оградой под шатровым навесом на резных столбах.'
Add-Pause $P1_Long

Add-Speech 'Расположен он в центре Троицкой площади, с середины семнадцатого века она стала называться Красной площадью.'
Add-Pause $P1_Paragraph

Add-Speech 'Лобное место играло важнейшую роль в духовной жизни народа и державы.'
Add-Pause $P1_Long

Add-Speech 'С этого места объявлялись государственные указы.'
Add-Pause $P1_Medium

Add-Speech 'Здесь народ узнавал о восшествии на престол царей, об объявлении войны и заключении мира.'
Add-Pause $P1_Paragraph

Add-Speech 'На Лобное место бояре выносили на плечах наследника, когда ему исполнялось шестнадцать лет.'
Add-Pause $P1_Long

Add-Speech 'И народ видел будущего царя, чтобы уметь отличить его от самозванца.'
Add-Pause $P1_Paragraph

Add-Speech 'С Лобного места патриархи произносили молитвы.'
Add-Pause $P1_Medium

Add-Speech 'С него в Вербное воскресенье патриарх раздавал царю, архиереям, боярам, окольничим и думным дьякам освященную вербу и читал народу Евангелие.'
Add-Pause $P1_Paragraph

Add-Speech 'Лобное место не было местом казни.'
Add-Pause $P1_Medium

Add-Speech 'Казни совершались рядом на деревянных помостах.'
Add-Pause 10000

# ---------- 2. ДИКТОВКА ПОД ЗАПИСЬ ----------

Add-Speech 'Лобное место.'
Add-Pause $P2_BeforeSplit
Add-Speech 'Лобное место.'
Add-Pause $P2_EndSentence

Add-Speech 'Лобное место — древнейший архитектурный памятник Москвы.'
Add-Pause $P2_BeforeSplit
Add-Speech 'Лобное место —'
Add-Pause $P2_Short
Add-Speech 'древнейший архитектурный'
Add-Pause $P2_Medium
Add-Speech 'памятник Москвы.'
Add-Pause $P2_EndSentence

Add-Speech 'Первоначально это был округлый кирпичный помост с деревянной оградой под шатровым навесом на резных столбах.'
Add-Pause $P2_BeforeSplit
Add-Speech 'Первоначально это был'
Add-Pause $P2_Medium
Add-Speech 'округлый кирпичный помост'
Add-Pause $P2_Medium
Add-Speech 'с деревянной оградой'
Add-Pause $P2_Medium
Add-Speech 'под шатровым навесом'
Add-Pause $P2_Medium
Add-Speech 'на резных столбах.'
Add-Pause $P2_EndSentence

Add-Speech 'Расположен он в центре Троицкой площади, с середины семнадцатого века она стала называться Красной площадью.'
Add-Pause $P2_BeforeSplit
Add-Speech 'Расположен он'
Add-Pause $P2_Short
Add-Speech 'в центре Троицкой площади,'
Add-Pause $P2_Medium
Add-Speech 'с середины семнадцатого века'
Add-Pause $P2_Long
Add-Speech 'она стала называться'
Add-Pause $P2_Medium
Add-Speech 'Красной площадью.'
Add-Pause $P2_EndSentence

Add-Speech 'Следующий абзац.'
Add-Pause 3000

Add-Speech 'Лобное место играло важнейшую роль в духовной жизни народа и державы.'
Add-Pause $P2_BeforeSplit
Add-Speech 'Лобное место играло'
Add-Pause $P2_Medium
Add-Speech 'важнейшую роль'
Add-Pause $P2_Short
Add-Speech 'в духовной жизни'
Add-Pause $P2_Short
Add-Speech 'народа и державы.'
Add-Pause $P2_EndSentence

Add-Speech 'С этого места объявлялись государственные указы.'
Add-Pause $P2_BeforeSplit
Add-Speech 'С этого места'
Add-Pause $P2_Short
Add-Speech 'объявлялись государственные указы.'
Add-Pause $P2_EndSentence

Add-Speech 'Здесь народ узнавал о восшествии на престол царей, об объявлении войны и заключении мира.'
Add-Pause $P2_BeforeSplit
Add-Speech 'Здесь народ узнавал'
Add-Pause $P2_Medium
Add-Speech 'о восшествии на престол царей,'
Add-Pause $P2_Long
Add-Speech 'об объявлении войны'
Add-Pause $P2_Medium
Add-Speech 'и заключении мира.'
Add-Pause $P2_EndSentence

Add-Speech 'Следующий абзац.'
Add-Pause 3000

Add-Speech 'На Лобное место бояре выносили на плечах наследника, когда ему исполнялось шестнадцать лет.'
Add-Pause $P2_BeforeSplit
Add-Speech 'На Лобное место'
Add-Pause $P2_Short
Add-Speech 'бояре выносили на плечах'
Add-Pause $P2_Long
Add-Speech 'наследника,'
Add-Pause $P2_Short
Add-Speech 'когда ему исполнялось'
Add-Pause $P2_Medium
Add-Speech 'шестнадцать лет.'
Add-Pause $P2_EndSentence

Add-Speech 'И народ видел будущего царя, чтобы уметь отличить его от самозванца.'
Add-Pause $P2_BeforeSplit
Add-Speech 'И народ видел'
Add-Pause $P2_Short
Add-Speech 'будущего царя,'
Add-Pause $P2_Short
Add-Speech 'чтобы уметь отличить'
Add-Pause $P2_Medium
Add-Speech 'его от самозванца.'
Add-Pause $P2_EndSentence

Add-Speech 'Следующий абзац.'
Add-Pause 3000

Add-Speech 'С Лобного места патриархи произносили молитвы.'
Add-Pause $P2_BeforeSplit
Add-Speech 'С Лобного места'
Add-Pause $P2_Short
Add-Speech 'патриархи произносили молитвы.'
Add-Pause $P2_EndSentence

Add-Speech 'С него в Вербное воскресенье патриарх раздавал царю, архиереям, боярам, окольничим и думным дьякам освященную вербу и читал народу Евангелие.'
Add-Pause $P2_BeforeSplit
Add-Speech 'С него'
Add-Pause $P2_Short
Add-Speech 'в Вербное воскресенье'
Add-Pause $P2_Medium
Add-Speech 'патриарх раздавал царю,'
Add-Pause $P2_Medium
Add-Speech 'архиереям, боярам,'
Add-Pause $P2_Short
Add-Speech 'окольничим и думным дьякам'
Add-Pause $P2_Long
Add-Speech 'освященную вербу'
Add-Pause $P2_Short
Add-Speech 'и читал народу'
Add-Pause $P2_Short
Add-Speech 'Евангелие.'
Add-Pause $P2_EndSentence

Add-Speech 'Следующий абзац.'
Add-Pause 3000

Add-Speech 'Лобное место не было местом казни.'
Add-Pause $P2_BeforeSplit
Add-Speech 'Лобное место'
Add-Pause $P2_Short
Add-Speech 'не было местом казни.'
Add-Pause $P2_EndSentence

Add-Speech 'Казни совершались рядом на деревянных помостах.'
Add-Pause $P2_BeforeSplit
Add-Speech 'Казни совершались рядом'
Add-Pause $P2_Medium
Add-Speech 'на деревянных помостах.'
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