# 🍅 Cross-Platform Pomodoro Timer

> A beautiful, simple, and powerful terminal-based Pomodoro timer for macOS, Linux, and Windows.

![Pomodoro Demo](pomo.png)

[![Platform macOS](https://img.shields.io/badge/platform-macOS-lightgrey.svg)](#-macos--linux)
[![Platform Linux](https://img.shields.io/badge/platform-Linux-orange.svg)](#-macos--linux)
[![Platform Windows](https://img.shields.io/badge/platform-Windows-blue.svg)](#-windows)

---

## ✨ Features

- 📊 **Visual Progress Bar**: High-resolution smooth progress tracking.
- 🔔 **Smart Notifications**: Native desktop alerts for work and break transitions.
- 🗣️ **Voice Alerts**: Clear audio cues when it's time to start or finish.
- 🛠️ **Fully Customizable**: Easy-to-edit durations, sounds, and colors.
- ⌨️ **Terminal Integrated**: Works within your existing workflow without extra apps.

---

## 🚀 Quick Start

### 🍎 macOS & 🐧 Linux

The script runs in `zsh` or `bash`.

1. **Download & Enter Folder:**
   ```bash
   git clone https://github.com/your-username/pomodoro-style-workflow.git
   cd pomodoro-style-workflow
   ```
2. **Make Executable:**
   ```bash
   chmod +x pomo.zsh
   ```
3. **Run:**
   ```bash
   ./pomo.zsh
   ```

> **Linux Note:** For notifications and voice, install: `sudo apt install libnotify-bin speech-dispatcher`

---

### 🪟 Windows

Uses a native PowerShell script.

1. **Download & Enter Folder:**
   ```powershell
   git clone https://github.com/your-username/pomodoro-style-workflow.git
   cd pomodoro-style-workflow
   ```
2. **Enable Scripts (Run once as Admin):**
   ```powershell
   Set-ExecutionPolicy RemoteSigned -Scope CurrentUser
   ```
3. **Run:**
   ```powershell
   ./pomo.ps1
   ```

---

## 🛠 Usage & Commands

### Interactive Mode

Run the script without arguments to be prompted for settings:

```bash
./pomo.zsh  # or ./pomo.ps1 on Windows
```

### Quick Commands (CLI)

You can skip prompts by passing arguments directly:

```bash
# Format: [rounds] [work_minutes] [break_minutes]
./pomo.zsh 4 25 5
```

---

## 💎 Pro Tip: Global Access

Want to type `pomo` from any folder?

### macOS / Linux (zsh/bash)

1. Open your profile: `nano ~/.zshrc` (or `~/.bashrc`)
2. Add this line:
   ```bash
   source /path/to/your/pomo.zsh
   ```
3. Restart terminal or run `source ~/.zshrc`. Now you can use:
   - `pomo`: Full setup
   - `work_session 25`: Quick work timer
   - `break_session 5`: Quick break timer

### Windows (PowerShell)

1. Open your profile: `notepad $PROFILE`
2. Add this line:
   ```powershell
   function pomo { & "/path/to/your/pomo.ps1" @args }
   ```
3. Restart PowerShell. Now just type `pomo` anywhere!

---

## 🎨 Customization

Open the script in your favorite editor to tweak settings:

- **Sounds (macOS):** Change `WORK_SOUND` to any system sound (e.g., "Glass", "Hero").
- **Colors:** Adjust ANSI color codes for a custom terminal look.
- **Progress Bar:** Tweak `bar_width` to fit your terminal size.

---

## 📦 Dependencies

| Feature           | macOS                          | Linux                 | Windows       |
| :---------------- | :----------------------------- | :-------------------- | :------------ |
| **Notifications** | Built-in / `terminal-notifier` | `libnotify-bin`       | Built-in      |
| **Voice**         | Built-in `say`                 | `spd-say` or `espeak` | Built-in .NET |
| **Shell**         | Zsh/Bash                       | Zsh/Bash              | PowerShell    |

---

## 📜 License

Distributed under the **MIT License**. See `LICENSE` for more information.
