#!/bin/bash
# Shows remote hostname only when in SSH session

pane_cmd=$(tmux display-message -p '#{pane_current_command}')
[ "$pane_cmd" != "ssh" ] && exit 0

pane_pid=$(tmux display-message -p '#{pane_pid}')

# Get SSH command line from /proc
ssh_cmdline=$(cat /proc/"$pane_pid"/cmdline 2>/dev/null | tr '\0' ' ')

if [ -z "$ssh_cmdline" ] || [[ ! "$ssh_cmdline" =~ ^ssh ]]; then
    # Try child process (shell → ssh)
    child_pid=$(pgrep -P "$pane_pid" ssh 2>/dev/null | head -1)
    [ -n "$child_pid" ] && ssh_cmdline=$(cat /proc/"$child_pid"/cmdline 2>/dev/null | tr '\0' ' ')
fi

# Extract hostname (last arg, strip user@)
ssh_host=$(echo "$ssh_cmdline" | awk '{print $NF}' | sed 's/.*@//')
[ -n "$ssh_host" ] && echo "$ssh_host"
