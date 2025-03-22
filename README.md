# Pomodoro Timer Setup for macOS

This guide explains how to set up a Pomodoro-style workflow using shell aliases and a custom function in macOS. The setup utilizes the built-in `say` command, `terminal-notifier` for notifications, and a `timer` command (which should be installed separately) to track work and break intervals.

## Features

- **Work Timer (60 minutes):** Alerts you when it's time to take a break.
- **Break Timer (10 minutes):** Reminds you to resume work after a break.
- **Loop Function (`pomo`):** Automates multiple Pomodoro cycles based on user input.

---

## Setup Instructions

### 1. Install `terminal-notifier`

If you don't have `terminal-notifier` installed, install it via Homebrew:

```sh
brew install terminal-notifier
```

### 2. Ensure You Have a `timer` Command

If you don't already have a `timer` command, you can use the `sleep` command instead:

```sh
alias timer='sleep'
```

Alternatively, install a more advanced timer tool like `gawk`.

### 3. Add Aliases and Function to Your Shell Profile

Edit your shell configuration file (`~/.zshrc` or `~/.bashrc`) and add the following code:

```sh
alias work="timer 60m && say 'It'\''s break time, my friend! Get up and go for a walk! Drink some water' \
    && terminal-notifier -message 'Pomodoro' \
    -title 'Work Timer is up! Take a Break 😊' \
    -contentImage "$HOME/Pictures/pumpkin.png" \
    -sound Crystal"

alias rest="timer 10m && say 'The break is over, Get back to work' \
    && terminal-notifier -message 'Pomodoro' \
    -title 'Break is over! Get back to work 😬' \
    -contentImage "$HOME/Pictures/pumpkin.png" \
    -sound Crystal"

pomo(){
    echo "How many rounds do you want to do?";
    read count;
    for i in $(seq 1 $count);
    do
        work;
        sleep 1;
        rest;
    done
}
```

### 4. Apply Changes

After saving the file, apply the changes by running:

```sh
source ~/.zshrc  # or source ~/.bashrc
```

---

## Usage

### Start a Pomodoro session:

```sh
pomo
```

It will prompt you to enter the number of rounds (work + break cycles) you want to complete.

### Start a single work session:

```sh
work
```

### Start a break session:

```sh
rest
```

---

## Customization

- Modify the `timer` durations (default: 60m for work, 10m for rest) based on your preferences.
- Change the `say` message or notification settings as needed.
- Replace the `contentImage` path with a different image.

---

## Notes

- Ensure you have an image at `~/Pictures/pumpkin.png` or change the path accordingly.
- If using `zsh`, restart your terminal after making changes.

Happy productivity! 🚀
