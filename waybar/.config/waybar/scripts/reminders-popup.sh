#!/usr/bin/env bash
# Interactive popup for completing Obsidian reminders using yad

REMINDERS_DIR="$HOME/Documents/notes/Reminders"

# Kill existing popup if running
pkill -f "yad.*Obsidian Reminders" 2>/dev/null

build_reminder_list() {
    local now=$(date +%s)
    local today_start=$(date -d "today 00:00" +%s)
    local today_end=$(date -d "today 23:59:59" +%s)
    local week_end=$(date -d "+7 days 23:59:59" +%s)

    local items=""

    # Check if reminders directory exists
    if [[ ! -d "$REMINDERS_DIR" ]]; then
        return
    fi

    # Find all .md files and parse unchecked reminders
    while IFS= read -r file; do
        [[ -z "$file" ]] && continue
        local lineno=0
        while IFS= read -r line; do
            ((lineno++))
            # Match: - [ ] Task title (@YYYY-MM-DD HH:mm)
            if [[ "$line" =~ ^-\ \[\ \]\ (.+)\ \(@([0-9]{4}-[0-9]{2}-[0-9]{2})\ ([0-9]{2}:[0-9]{2})\)$ ]]; then
                local task="${BASH_REMATCH[1]}"
                local date="${BASH_REMATCH[2]}"
                local time="${BASH_REMATCH[3]}"
                local reminder_ts=$(date -d "$date $time" +%s 2>/dev/null)

                if [[ -n "$reminder_ts" ]]; then
                    local category=""

                    if [[ $reminder_ts -lt $now ]]; then
                        category="OVERDUE"
                    elif [[ $reminder_ts -ge $today_start && $reminder_ts -le $today_end ]]; then
                        category="TODAY"
                    elif [[ $reminder_ts -le $week_end ]]; then
                        category=$(date -d "$date" +%A)
                    else
                        continue
                    fi

                    # Format: FALSE|file:lineno|category|time|task
                    items+="FALSE\n${file}:${lineno}\n${category}\n${time}\n${task}\n"
                fi
            fi
        done < "$file"
    done < <(find "$REMINDERS_DIR" -name "*.md" -type f 2>/dev/null)

    echo -e "$items"
}

complete_reminders() {
    local selections="$1"

    # Process each selected item
    while IFS='|' read -r file_line; do
        [[ -z "$file_line" ]] && continue

        local file="${file_line%:*}"
        local lineno="${file_line#*:}"

        # Replace "- [ ]" with "- [x]" on the specific line
        if [[ -f "$file" && -n "$lineno" ]]; then
            sed -i "${lineno}s/- \[ \]/- [x]/" "$file"
        fi

    done <<< "$selections"
}

# Build list
items=$(build_reminder_list)

if [[ -z "$items" ]]; then
    yad --info \
        --title="Obsidian Reminders" \
        --text="No reminders in the next 7 days" \
        --button="OK:0" \
        --width=300 \
        --center \
        --on-top
    exit 0
fi

# Display checklist dialog
result=$(echo -e "$items" | yad --list \
    --title="Obsidian Reminders" \
    --checklist \
    --column="Done" \
    --column="Ref:HD" \
    --column="Category" \
    --column="Time" \
    --column="Task" \
    --print-column=2 \
    --separator="|" \
    --width=600 \
    --height=400 \
    --center \
    --on-top \
    --button="Mark Complete:0" \
    --button="Cancel:1")

exit_code=$?

if [[ $exit_code -eq 0 && -n "$result" ]]; then
    # Remove trailing separator
    result="${result%|}"
    complete_reminders "$result"
fi
