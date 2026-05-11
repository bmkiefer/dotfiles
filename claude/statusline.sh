#!/bin/bash

# Claude Code Status Line Script
# Shows: model, context slider + %, tokens used, directory, git branch
# Colors: Catppuccin Mocha

input=$(cat)

# Catppuccin Mocha palette (24-bit truecolor)
C_TEXT=$'\033[38;2;205;214;244m'      # #cdd6f4
C_SUBTEXT=$'\033[38;2;166;173;200m'   # #a6adc8 (subtext0)
C_OVERLAY=$'\033[38;2;108;112;134m'   # #6c7086 (overlay0)
C_SURFACE=$'\033[38;2;69;71;90m'      # #45475a (surface1)
C_MAUVE=$'\033[38;2;203;166;247m'     # #cba6f7
C_BLUE=$'\033[38;2;137;180;250m'      # #89b4fa
C_GREEN=$'\033[38;2;166;227;161m'     # #a6e3a1
C_YELLOW=$'\033[38;2;249;226;175m'    # #f9e2af
C_RED=$'\033[38;2;243;139;168m'       # #f38ba8
C_PEACH=$'\033[38;2;250;179;135m'     # #fab387
C_TEAL=$'\033[38;2;148;226;213m'      # #94e2d5
RESET=$'\033[0m'

BAR_WIDTH=14
TOTAL_TOKENS=200000
THRESHOLD_WARN=50
THRESHOLD_CRIT=75

resolve_transcript() {
    local payload="$1"
    local reported
    reported=$(echo "$payload" | jq -r '.transcript_path // ""')
    local resolved=""
    if [[ -n "$reported" && -f "$reported" ]]; then
        resolved="$reported"
    else
        local session_id
        session_id=$(basename "$reported" .jsonl 2>/dev/null)
        if [[ -n "$session_id" ]]; then
            resolved=$(ls -t "$HOME/.claude/projects/"*/"${session_id}.jsonl" 2>/dev/null | head -n 1)
        fi
    fi
    echo "$resolved"
}

get_used_tokens() {
    local transcript="$1"
    local tokens=0
    if [[ -n "$transcript" && -f "$transcript" ]]; then
        tokens=$(tail -r "$transcript" 2>/dev/null \
            | jq -r 'select(.message.usage) | (.message.usage.input_tokens // 0) + (.message.usage.cache_read_input_tokens // 0) + (.message.usage.cache_creation_input_tokens // 0) + (.message.usage.output_tokens // 0)' \
            | head -n 1)
    fi
    echo "${tokens:-0}"
}

pick_bar_color() {
    local pct="$1"
    if (( pct >= THRESHOLD_CRIT )); then
        echo "$C_RED"
    elif (( pct >= THRESHOLD_WARN )); then
        echo "$C_YELLOW"
    else
        echo "$C_GREEN"
    fi
}

render_bar() {
    local pct="$1"
    local color="$2"
    local filled=$(( pct * BAR_WIDTH / 100 ))
    (( filled > BAR_WIDTH )) && filled=$BAR_WIDTH
    local empty=$(( BAR_WIDTH - filled ))
    local bar=""
    local i
    for (( i = 0; i < filled; i++ )); do bar+="█"; done
    local rest=""
    for (( i = 0; i < empty; i++ )); do rest+="░"; done
    printf "%s%s%s%s%s" "$color" "$bar" "$C_SURFACE" "$rest" "$RESET"
}

format_tokens() {
    local n="$1"
    if (( n >= 1000 )); then
        awk -v n="$n" 'BEGIN { printf "%.1fk", n/1000 }'
    else
        echo "$n"
    fi
}

model=$(echo "$input" | jq -r '.model.display_name // "unknown"')
transcript=$(resolve_transcript "$input")
current_dir=$(echo "$input" | jq -r '.workspace.current_dir // "."')
dir_name="${current_dir/#$HOME/~}"
git_branch=$(git -C "$current_dir" branch --no-color 2>/dev/null | grep '^*' | sed 's/* //')

used_tokens=$(get_used_tokens "$transcript")
percentage=$(( used_tokens * 100 / TOTAL_TOKENS ))
bar_color=$(pick_bar_color "$percentage")
bar=$(render_bar "$percentage" "$bar_color")
used_fmt=$(format_tokens "$used_tokens")
total_fmt=$(format_tokens "$TOTAL_TOKENS")

sep="${C_OVERLAY}│${RESET}"
model_part="${C_MAUVE}${model}${RESET}"
ctx_part="${bar} ${bar_color}${percentage}%${RESET} ${C_SUBTEXT}${used_fmt}/${total_fmt}${RESET}"
dir_part="${C_BLUE}${dir_name}${RESET}"

if [[ -n "$git_branch" ]]; then
    branch_part=" ${C_OVERLAY}(${C_TEAL}${git_branch}${C_OVERLAY})${RESET}"
else
    branch_part=""
fi

printf "%s %s %s\n%s%s\n" "$model_part" "$sep" "$ctx_part" "$dir_part" "$branch_part"
