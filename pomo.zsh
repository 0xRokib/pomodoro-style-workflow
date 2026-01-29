#!/bin/zsh

# Pomodoro Timer Script
# Usage:
#   1. Source this file in your .zshrc: source /path/to/pomo.zsh
#   2. Or run it directly: ./pomo.zsh [rounds] [work_time] [break_time]

# --- Configuration ---
WORK_SOUND="Crystal"
BREAK_SOUND="Crystal"
NOTIFIER_TITLE="Pomodoro"

# --- Colors & Styles ---
RED="\033[0;31m"
BLUE="\033[0;34m"
GREEN="\033[0;32m"
YELLOW="\033[0;33m"
RESET="\033[0m"
BOLD="\033[1m"

# --- OS Detection ---
OS_TYPE=$(uname)

# --- Helpers ---

# Check if terminal-notifier is available (macOS only)
has_notifier() {
  command -v terminal-notifier &> /dev/null
}

# Send notification
notify() {
  local message="$1"
  local title="${2:-$NOTIFIER_TITLE}"
  local sound="${3:-$WORK_SOUND}"

  if [[ "$OS_TYPE" == "Darwin" ]]; then
    if has_notifier; then
      terminal-notifier -message "$message" -title "$title" -sound "$sound"
    else
      # Fallback to standard macOS notification
      osascript -e "display notification \"$message\" with title \"$title\" sound name \"$sound\"" 2>/dev/null
    fi
  elif [[ "$OS_TYPE" == "Linux" ]]; then
    if command -v notify-send &> /dev/null; then
      notify-send "$title" "$message"
    fi
  fi
}

# Text-to-speech helper
speak() {
  local message="$1"
  if [[ "$OS_TYPE" == "Darwin" ]]; then
    say "$message"
  elif [[ "$OS_TYPE" == "Linux" ]]; then
    if command -v spd-say &> /dev/null; then
      spd-say "$message"
    elif command -v espeak &> /dev/null; then
      espeak "$message"
    fi
  fi
}

# Cleanup on Ctrl+C
cleanup() {
  tput cnorm # Restore cursor
  echo -e "\n${RED}🛑 Pomodoro interrupted.${RESET}"
  notify "Pomodoro interrupted ❌" "Pomodoro" "Basso"
  exit 1
}

# Progress bar timer
timer() {
  local input="$1"
  local color="$2"
  # Extract minutes, handling cases like "50m" or just "50"
  local minutes="${input%m}" 
  local total_seconds=$((minutes * 60))
  local bar_width=30

  # Setup interrupt trap
  trap cleanup INT
  tput civis # Hide cursor

  echo ""
  echo -e "${color}${BOLD}⏳ Timer started for $minutes minutes ($total_seconds seconds)${RESET}"
  echo ""

  local start_time=$(date +%s)
  
  while true; do
    local current_time=$(date +%s)
    local elapsed=$((current_time - start_time))

    if (( elapsed >= total_seconds )); then
      break
    fi

    # Calculate progress
    # Multiply by 8 for sub-block precision
    local total_ticks=$((bar_width * 8))
    local progress_ticks=$((elapsed * total_ticks / total_seconds))
    
    local full_blocks=$((progress_ticks / 8))
    local remainder=$((progress_ticks % 8))
    
    # Cap full_blocks at bar_width
    if (( full_blocks > bar_width )); then full_blocks=$bar_width; fi
    
    local empty_blocks=$((bar_width - full_blocks - 1))
    if (( empty_blocks < 0 )); then empty_blocks=0; fi

    # Select partial block character
    local partial_block=" "
    if (( full_blocks < bar_width )); then
        case $remainder in
          0) partial_block=" " ;;
          1) partial_block="▏" ;;
          2) partial_block="▎" ;;
          3) partial_block="▍" ;;
          4) partial_block="▌" ;;
          5) partial_block="▋" ;;
          6) partial_block="▊" ;;
          7) partial_block="▉" ;;
        esac
    fi

    local percent=$((elapsed * 100 / total_seconds))
    
    # Remaining time
    local remaining=$((total_seconds - elapsed))
    local min=$((remaining / 60))
    local sec=$((remaining % 60))

    # Construct bar string
    # Using printf for block repetition
    local filled_str=""
    if (( full_blocks > 0 )); then
        filled_str=$(printf '█%.0s' $(seq 1 $full_blocks))
    fi
    local empty_str=""
    if (( empty_blocks > 0 )); then
        empty_str=$(printf ' %.0s' $(seq 1 $empty_blocks))
    fi

    printf "\r${color}%3d%% |%s%s%s| ⏱ %02d:%02d ${RESET}" \
      "$percent" "$filled_str" "$partial_block" "$empty_str" "$min" "$sec"

    sleep 1
  done

  # Final finished state
  local full_bar=$(printf '█%.0s' $(seq 1 $bar_width))
  printf "\r${color}100%% |%s| ⏱ 00:00 ${RESET}\n" "$full_bar"

  tput cnorm # Restore cursor
  echo -e "\n✅ Done!"
}

# --- Sessions ---

work_session() {
  local duration="${1:-50}"
  echo -e "${RED}🍅 Work session started for $duration minutes...${RESET}"
  speak "Work session started. Focus mode on."
  
  timer "${duration}m" "$RED"
  
  speak "Work session complete. Time for a break."
  notify "Work session complete! Take a break 😊" "Pomodoro" "$WORK_SOUND"
}

break_session() {
  local duration="${1:-10}"
  echo -e "${BLUE}😌 Break started for $duration minutes...${RESET}"
  speak "Break started. Relax and recharge."
  
  timer "${duration}m" "$BLUE"
  
  speak "Break is over. Get back to work."
  notify "Break is over! Back to work 😬" "Pomodoro" "$BREAK_SOUND"
}

# --- Main Entry Point ---

pomo() {
  # Accept optional arguments: count work_time break_time
  local count="${1}"
  local work_time="${2}"
  local break_time="${3}"

  # Interactive prompts if arguments are missing
  if [[ -z "$count" ]]; then
      echo -n "${YELLOW}How many Pomodoro rounds? (default: 1) ${RESET}"
      read count
  fi
  count=${count:-1}

  if [[ -z "$work_time" ]]; then
      echo -n "${YELLOW}Work duration in minutes? (default: 50) ${RESET}"
      read work_time
  fi
  work_time=${work_time:-50}

  if [[ -z "$break_time" ]]; then
      echo -n "${YELLOW}Break duration in minutes? (default: 10) ${RESET}"
      read break_time
  fi
  break_time=${break_time:-10}

  echo ""
  echo -e "${BOLD}🚀 Starting $count Pomodoro round(s)${RESET}"
  echo -e "   🧠 Work: ${BOLD}$work_time min${RESET}"
  echo -e "   ☕ Break: ${BOLD}$break_time min${RESET}"
  echo ""

  for i in $(seq 1 "$count"); do
    echo -e "${BOLD}===== Round $i of $count =====${RESET}"
    work_session "$work_time"
    
    # Take a break after works (even the last one, usually good practice to cool down)
    break_session "$break_time"
  done

  echo -e "${GREEN}🎉 All $count rounds completed! Awesome work!${RESET}"
  speak "All Pomodoro rounds completed. You did amazing today!"
  notify "All Pomodoro rounds completed 🎉" "Pomodoro" "$WORK_SOUND"
}

# If script is executed directly (not sourced), run pomo
if [[ -n "$ZSH_NAME" ]] && [[ "${(%):-%N}" == "$0" ]]; then
    # zsh script execution check
    pomo "$@"
elif [[ -n "$BASH_SOURCE" ]] && [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    # bash script execution check
    pomo "$@"
fi
