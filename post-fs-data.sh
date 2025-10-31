#!/system/bin/sh
MODDIR=${0%/*}
chmod 755 -R "$MODDIR/common"
echo "[Gaming Module] Boot initialized" > "$MODDIR/module.log"
