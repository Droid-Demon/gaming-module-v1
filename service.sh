#!/system/bin/sh
MODDIR=${0%/*}
LOGFILE="$MODDIR/module.log"

restore_state() {
    settings put global zen_mode 0
    settings put system screen_brightness_mode 1
    settings put system heads_up_notifications_enabled 1
    echo "[Gaming Module] Restored system state" >> "$LOGFILE"
}

apply_game_mode() {
    settings put global zen_mode 1
    settings put system screen_brightness_mode 0
    settings put system heads_up_notifications_enabled 0
    echo "[Gaming Module] Game mode active" >> "$LOGFILE"
}

while true; do
    pkg=$(dumpsys activity activities | grep "ResumedActivity" | awk -F '/' '{print $1}' | awk '{print $NF}')
    if [ -f "$MODDIR/common/active_app.txt" ]; then
        active=$(cat "$MODDIR/common/active_app.txt")
        if echo "$active" | grep -q "$pkg"; then
            apply_game_mode
        else
            restore_state
        fi
    fi
    sleep 3
done
