# 🍅 Pomodoro Timer for macOS

A beautiful, simple, and powerful Pomodoro timer that lives in your terminal. Perfect for staying focused without leaving your workflow.

![Pomodoro Demo](https://via.placeholder.com/800x400.png?text=Beautiful+Terminal+Timer+Demo) <!-- You can replace this later with a real screenshot -->

## ✨ Features

- **Visual Progress Bar**: See exactly how much time is left with a smooth, high-resolution progress bar.
- **Sound Alerts**: Hear a gentle alert when it's time to work or break (using macOS native `say` and system sounds).
- **Desktop Notifications**: Get a pop-up alert if you're in another window.
- **Smart Logic**: Automatically handles interruptions and restores your terminal cursor cleanly.

---

## 🚀 Getting Started (Beginner Friendly)

If you've never used a terminal script before, don't worry! Just follow these steps:

### 1. Download the Script

First, get the code onto your computer. You can either:

- **Option A (Easy)**: Click the green "Code" button at the top right of this page and select **Download ZIP**. Unzip it to a folder (e.g., `Downloads/Pomodoro`).
- **Option B (Fast)**: Open your terminal and run:
  ```bash
  git clone https://github.com/your-username/pomodoro-macos.git
  cd pomodoro-macos
  ```

### 2. Give Permission to Run

By default, macOS protects you from running random scripts. You need to tell it this one is okay:

1. Open your **Terminal** app.
2. Type `cd` followed by a space, then drag the folder containing `pomo.zsh` into the terminal window. Press **Enter**.
3. Run this command:
   ```bash
   chmod +x pomo.zsh
   ```
   _This makes the script "executable" (ready to run)._

---

## 🛠 How to Use

### Method 1: Run it Right Now

If you just want to start a session quickly, run this in your terminal inside the project folder:

```bash
./pomo.zsh
```

The script will ask you:

1. **How many rounds?** (e.g., 4)
2. **Work time?** (e.g., 25)
3. **Break time?** (e.g., 5)

---

### Method 2: Make it a Permanent Command (Pro Tip)

Want to just type `pomo` anywhere in your terminal? Follow these steps:

1. Open your terminal and type:
   ```bash
   nano ~/.zshrc
   ```
2. Scroll to the bottom and paste this line (replace the path with your actual path):
   ```bash
   source ~/Documents/Pomodoro/pomo.zsh
   ```
3. Press `Ctrl + O` then `Enter` to save, and `Ctrl + X` to exit.
4. Refresh your terminal:
   ```bash
   source ~/.zshrc
   ```

**Now you can use these commands anytime:**

- `pomo`: Starts the full interactive setup.
- `work_session 25`: Starts a 25-minute work timer immediately.
- `break_session 5`: Starts a 5-minute break timer immediately.

---

## ⚡️ Advanced Usage

You can skip the questions by passing numbers directly:

```bash
# Format: ./pomo.zsh [rounds] [work_minutes] [break_minutes]
./pomo.zsh 4 25 5
```

## 🎨 Customization

Want different sounds? Open `pomo.zsh` in any text editor and change these lines at the top:

```bash
# You can use names like: Basso, Blow, Bottle, Frog, Funk, Glass, Hero, Morse, Ping, Pop, Purr, Sosumi, Submarine, Tink
WORK_SOUND="Crystal"
BREAK_SOUND="Crystal"
```

## 📦 Dependencies

The script works "out of the box," but for **prettier notifications**, you can install `terminal-notifier`:

```bash
brew install terminal-notifier
```

_If you don't have it, the script will still work perfectly using standard macOS alerts!_

---

## 📜 License

MIT
