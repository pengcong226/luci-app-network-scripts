#!/bin/sh
# Campus Network Auth Script v3.0

LOG_FILE="/var/log/campus_auth.log"
AUTH_URL=$(uci get network_scripts.@global[0].auth_url)
USER_ID=$(uci get network_scripts.@global[0].username)
PASSWORD=$(uci get network_scripts.@global[0].password)

log() {
    echo "$(date): $1" >> $LOG_FILE
}

check_connect() {
    ping -c 1 223.5.5.5 >/dev/null 2>&1
    return $?
}

do_auth() {
    log "Attempting authentication..."
    # 模拟认证请求，实际场景需根据抓包结果修改
    curl -s -d "user=$USER_ID&pass=$PASSWORD" "$AUTH_URL" >/dev/null
    if [ $? -eq 0 ]; then
        log "Auth request sent."
    else
        log "Auth request failed."
    fi
}

while true; do
    if ! check_connect; then
        log "Internet disconnected. Re-authenticating..."
        do_auth
    fi
    sleep 60
done
