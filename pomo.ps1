# 🍅 Pomodoro Timer for Windows (PowerShell)
# Usage: ./pomo.ps1 [rounds] [work_minutes] [break_minutes]

param (
    [int]$rounds = 0,
    [int]$workTime = 0,
    [int]$breakTime = 0
)

# --- Configuration ---
$NOTIFIER_TITLE = "Pomodoro"

# --- Initialization ---
Add-Type -AssemblyName System.Speech
$Synthesizer = New-Object System.Speech.Synthesis.SpeechSynthesizer

# --- Helpers ---

function Speak-Message {
    param([string]$message)
    try {
        $Synthesizer.Speak($message)
    } catch {
        # Fallback if speech fails
    }
}

function Send-Notification {
    param([string]$title, [string]$message)
    # Using a simple Balloon Tip fallback that doesn't require modules
    Add-Type -AssemblyName System.Windows.Forms
    $global:notification = New-Object System.Windows.Forms.NotifyIcon
    $path = (Get-Process -id $pid).Path
    $global:notification.Icon = [System.Drawing.Icon]::ExtractAssociatedIcon($path)
    $global:notification.BalloonTipIcon = [System.Windows.Forms.ToolTipIcon]::Info
    $global:notification.BalloonTipTitle = $title
    $global:notification.BalloonTipText = $message
    $global:notification.Visible = $true
    $global:notification.ShowBalloonTip(5000)
}

function Show-Timer {
    param(
        [int]$minutes,
        [ConsoleColor]$color,
        [string]$label
    )
    
    $totalSeconds = $minutes * 60
    $barWidth = 30
    
    $cursorVisible = $host.UI.RawUI.CursorSize
    $host.UI.RawUI.CursorSize = 0 # Hide cursor

    Write-Host "`n$label started for $minutes minutes..." -ForegroundColor $color

    $startTime = [DateTime]::Now
    
    try {
        while ($true) {
            $elapsed = ([DateTime]::Now - $startTime).TotalSeconds
            if ($elapsed -ge $totalSeconds) { break }

            $percent = [math]::Floor(($elapsed / $totalSeconds) * 100)
            $progressTicks = [math]::Floor(($elapsed / $totalSeconds) * $barWidth)
            
            $filledStr = "█" * $progressTicks
            $emptyStr = " " * ($barWidth - $progressTicks)
            
            $remaining = $totalSeconds - $elapsed
            $min = [math]::Floor($remaining / 60)
            $sec = [math]::Floor($remaining % 60)

            $progressLine = "`r{0,3}% |{1}{2}| ⏱ {3:D2}:{4:D2} " -f $percent, $filledStr, $emptyStr, $min, $sec
            Write-Host $progressLine -NoNewline -ForegroundColor $color
            
            Start-Sleep -Milliseconds 500
        }
    }
    finally {
        $host.UI.RawUI.CursorSize = $cursorVisible # Restore cursor
    }

    $finalBar = "█" * $barWidth
    Write-Host "`r100% |$finalBar| ⏱ 00:00 " -ForegroundColor $color
    Write-Host "`n✅ Done!"
}

# --- Interactive Prompts ---
if ($rounds -eq 0) { 
    $val = Read-Host "How many Pomodoro rounds? (default: 1)"
    if ([string]::IsNullOrWhiteSpace($val)) { $rounds = 1 } else { $rounds = [int]$val }
}
if ($workTime -eq 0) { 
    $val = Read-Host "Work duration in minutes? (default: 50)"
    if ([string]::IsNullOrWhiteSpace($val)) { $workTime = 50 } else { $workTime = [int]$val }
}
if ($breakTime -eq 0) { 
    $val = Read-Host "Break duration in minutes? (default: 10)"
    if ([string]::IsNullOrWhiteSpace($val)) { $breakTime = 10 } else { $breakTime = [int]$val }
}

Write-Host "`n🚀 Starting $rounds Pomodoro round(s)" -ForegroundColor Cyan
Write-Host "   🧠 Work:  $workTime min"
Write-Host "   ☕ Break: $breakTime min`n"

for ($i = 1; $i -le $rounds; $i++) {
    Write-Host "===== Round $i of $rounds =====" -Style Bold
    
    # Work Session
    Speak-Message "Work session started. Focus mode on."
    Show-Timer -minutes $workTime -color Red -label "🍅 Work session"
    Send-Notification -title $NOTIFIER_TITLE -message "Work session complete! Take a break 😊"
    Speak-Message "Work session complete. Time for a break."

    # Break Session
    Show-Timer -minutes $breakTime -color Blue -label "😌 Break"
    Send-Notification -title $NOTIFIER_TITLE -message "Break is over! Back to work 😬"
    Speak-Message "Break is over. Get back to work."
}

Write-Host "`n🎉 All $rounds rounds completed! Awesome work!" -ForegroundColor Green
Speak-Message "All Pomodoro rounds completed. You did amazing today!"
Send-Notification -title $NOTIFIER_TITLE -message "All Pomodoro rounds completed 🎉"
