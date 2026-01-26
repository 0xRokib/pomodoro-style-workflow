# Pomodoro Timer for macOS (Zsh/Bash)

A robust, terminal-based Pomodoro timer designed for productivity. It features a visual progress bar, sound alerts, and desktop notifications.

## Features

- **Visual Progress Bar**: Smooth text-based progress bar with Unicode partial blocks.
- **Customizable Sessions**: Set your own work and break durations.
- **Smart Notifications**: Uses `terminal-notifier` if available, falls back to macOS native notifications.
- **Sound Alerts**: Built-in `say` commands and system sounds to keep you on track.
- **Interrupt Handling**: Cleanly handles `Ctrl+C` to restore your cursor and notify you.

## Installation

1.  **Clone or Download** this repository.
2.  **Make the script executable** (optional but recommended):
    ```sh
    chmod +x pomo.zsh
    ```

### Dependencies (Optional)

For rich notifications with titles and icons, install `terminal-notifier`. If skipped, the script uses standard macOS notifications.

```sh
brew install terminal-notifier
```

## Usage

### Option 1: Run Directly

You can run the script directly from your terminal:

```sh
./pomo.zsh
```

Follow the interactive prompts to set rounds, work time, and break time.

**Command Line Arguments:**
You can also pass arguments to skip the prompts:

```sh
# usage: ./pomo.zsh [rounds] [work_minutes] [break_minutes]
./pomo.zsh 4 25 5
```

### Option 2: Add to Shell (Recommended)

To have the `pomo`, `work_session`, and `break_session` commands available everywhere in your terminal, add this to your `.zshrc` or `.bashrc`:

```sh
source /path/to/your/Pomodoro/pomo.zsh
```

_(Replace `/path/to/your/Pomodoro/pomo.zsh` with the actual path to the file)_

Then reload your shell:

```sh
source ~/.zshrc
```

Now you can just type `pomo` anywhere!

## Commands

- `pomo`: Starts the full loop (Work -> Break -> Work...).
- `work_session [minutes]`: Starts a standalone work timer (default 50m).
- `break_session [minutes]`: Starts a standalone break timer (default 10m).

## Customization

You can edit the variables at the top of `pomo.zsh` to change sounds or defaults:

```bash
WORK_SOUND="Crystal"
BREAK_SOUND="Crystal"
```

## License

MIT
