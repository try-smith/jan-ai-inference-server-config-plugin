#!/bin/bash

# Insert your specific info below
MODEL="Insert specific model name"
LOG="/tmp/jan-api-server.log" 
SELF="Insert your filepath containing this plugin here"

model_name_informal="Model 3.1 70B" # This is optional, but you can add a shorter modelname here for personal reference or aesthetics

# SwiftBar menu clicks actions below

PIDFILE="/tmp/jan-api-server.pid"

if [ "$1" = "start" ]; then
    echo "$(date): triggered" > /tmp/jan-debug.log
    API_KEY=$(security find-generic-password -a "jan-api" -s "jan-api-key" -w 2>/dev/null)
    if [ -z "$API_KEY" ]; then
        osascript -e 'display alert "Jan API" message "API key not found in Keychain.\nRun setup-jan-api-key.sh first."'
        exit 1
    fi
    # Starts detached so it survives after SwiftBar's shell exits
    nohup jan serve "$MODEL" --api-key "$API_KEY" > "$LOG" 2>&1 & 
    echo $! > "$PIDFILE"    # $! is the PID of the last backgrounded process  
    exit 0
fi

if [ "$1" = "stop" ]; then
    if [ -f "$PIDFILE" ]; then
        PID=$(cat "$PIDFILE")
        kill -INT "$PID" 2>/dev/null
        rm "$PIDFILE"
    fi
    exit 0
fi

if [ "$1" = "log" ]; then 
    # Opens the log in Console app for live analysis
    open -a Console "$LOG"
    exit 0
fi

# Status checks below

if [ -f "$PIDFILE" ] && kill -0 "$(cat $PIDFILE)" 2>/dev/null; then
    RUNNING=true
else
    RUNNING=false
fi

# Menu bar title

if [ "$RUNNING" = true ]; then
    echo "👋 Running | color=#22c55e" # The emoji is the standard Jan icon, but you can customize it
else
    echo "👋 Dormant | color=#ECEDEE"
fi

echo "---"

# Dropdown menu 

echo "Jan AI Inference Server | size=13 color=#212121"
echo "Model: $model_name_informal | size=13 color=#212121"
echo "---"

if [ "$RUNNING" = true ]; then
    echo "● Server Running | color=#22c55e size=13"
    echo "Stop Server | bash=$SELF param1=stop terminal=false refresh=true color=#f87171"
    echo "---"
    echo "View Log | bash=$SELF param1=log terminal=false"
else
    echo "● Server Off | color=#F63737 size=13"
    echo "Start Server | bash=$SELF param1=start terminal=false refresh=true color=#22c55e"
    echo "---"
    if [ -f "$LOG" ]; then
        echo "View Last Log | bash=$SELF param1=log terminal=false"
    fi
fi

echo "---"
echo "Refresh Now | refresh=true"

