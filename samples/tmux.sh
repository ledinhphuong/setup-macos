#!/bin/bash
# Phuong Le
# Example: ./tmux.sh start | open

if [ -z "$1" ]; then
  action="open"
else
  action=$1
fi

stop_all_panes_of() {
  local session=$1
  for pane_id in $(tmux list-panes -t $session -F '#P'); do
    tmux send-keys -t ${pane_id} C-c
  done
}

main() {
  local act=$1
  local session="tmux"
  local window="running"

  tmux has-session -t $session

  if [ $? != 0 ]; then
    if [[ "$act" == "stop" ]]; then
      return
    fi

    tmux new-session -s $session -d
    tmux new-window -t $session:1 -n $window

    # Using ctr+a+q to find the -t <value>
    # 2x3
    # tmux split-window -h -p 33
    # tmux split-window -v

    # tmux select-pane -t 1
    # tmux split-window -h

    # tmux select-pane -t 1
    # tmux split-window -v

    # tmux select-pane -t 3
    # tmux split-window -v

    # split 2x4
    tmux split-window -v

    tmux select-pane -t 1
    tmux split-window -h

    tmux select-pane -t 3
    tmux split-window -h

    tmux select-pane -t 1
    tmux split-window -h

    tmux select-pane -t 3
    tmux split-window -h

    tmux select-pane -t 5
    tmux split-window -h

    tmux select-pane -t 7
    tmux split-window -h

    tmux select-pane -t 1
    tmux send-keys "nvm use v20.0.0" Enter
    tmux send-keys "clear" Enter
    if [[ "$act" == start* ]]; then
      tmux send-keys "node -v" Enter
    fi

    tmux select-pane -t 2
    #

    tmux select-pane -t 3
    #

    tmux select-pane -t 4
    #

    tmux select-pane -t 5
    #

    tmux select-pane -t 6
    #

    tmux select-pane -t 7
    #

    tmux select-pane -t 8
    #
  else
    if [[ "$act" == "stop" ]]; then
      stop_all_panes_of $session
      tmux kill-session -t $session
      return
    fi
  fi

  if [[ "$act" == "open" ]] || [[ "$act" == "start" ]]; then
    tmux attach -t $session
  fi
}

main $action
