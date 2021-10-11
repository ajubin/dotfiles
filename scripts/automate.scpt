#!/usr/bin/osascript
tell application "iTerm2"
    tell current session of current tab of current window
        write text "exo ssh healico-load-node-1 -o \"-l root\""
        split horizontally with default profile
        split horizontally with default profile
        split vertically with default profile
    end tell
    tell second session of current tab of current window
        write text "exo ssh healico-load-node-2 -o \"-l root\""
    end tell
    tell third session of current tab of current window
        write text "exo ssh healico-load-node-3 -o \"-l root\""
        split vertically with default profile
    end tell
    tell fourth session of current tab of current window
        write text "exo ssh healico-load-node-4 -o \"-l root\""
    end tell
    tell fifth session of current tab of current window
        write text "exo ssh healico-load-node-5 -o \"-l root\""
        split vertically with default profile
    end tell
    tell sixth session of current tab of current window
        write text "exo ssh healico-load-node-6 -o \"-l root\""
    end tell
    tell current window
        create tab with default profile
    end tell
    tell first session of current tab of current window
        write text "exo ssh healico-load-postgres -o \"-l root\""
        split horizontally with default profile
        split vertically with default profile
    end tell
    tell second session of current tab of current window
        write text "exo ssh healico-load-redis -o \"-l root\""
    end tell
    tell third session of current tab of current window
        write text "exo ssh healico-load-proxy -o \"-l root\""
    end tell
end tell
