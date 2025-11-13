#!/system/bin/sh

# Module Configuration
MODID="S23U"
MODDIR="${0%/*}"

# Environment Detection
if [ -d "/data/adb/ksu/modules" ]; then
    LOG_DIR="/data/adb/ksu/modules/${MODID}/logs"
elif [ -d "/data/adb/modules" ]; then
    LOG_DIR="/data/adb/modules/${MODID}/logs"
else
    LOG_DIR="/data/local/tmp/${MODID}_logs"
fi

mkdir -p "${LOG_DIR}"
LOG_FILE="${LOG_DIR}/service.log"

# Logging function
log() {
    echo "[$(date '+%Y-%m-%d %T')] [${MODID}] $1" | tee -a "${LOG_FILE}"
}

log "=== Service Start ==="

# Wait for full boot
log "Waiting for boot completion..."
until [ "$(getprop sys.boot_completed)" = "1" ] && [ "$(getprop init.svc.bootanim)" = "stopped" ]; do
    sleep 2
done

# 3. GPU Renderer setting
setprop debug.hwui.renderer skiavk && log "GPU renderer set 111" || log "GPU set failed 111"

setprop debug.hwui.renderer skiavk && log "GPU renderer set 222" || log "GPU set failed 222"

log "=== Service Complete ==="