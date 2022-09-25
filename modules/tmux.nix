
{ pkgs, config, lib, ... }:

{
    home.packages = [
        tmuxPlugins.nord
    ];

    home.file.".tmux.conf".text = ''
set -g @plugin 'tmux-plugins/nord'
# command prefix (like screen)
#set -g prefix `
#bind-key ` send-prefix
set -g prefix C-o
bind-key C-o send-prefix

#unbind-key C-b
#bind-key F11 set-option -g prefix C-b
#bind-key F12 set-option -g prefix `

set-option -g terminal-overrides 'xterm*:smcup@:rmcup@'
set-option -g default-terminal "screen-256color"
set -g default-terminal "screen-256color"
#set-option -g default-command "reattach-to-user-namespace -l zsh"


unbind-key % # Remove default binding since we’re replacing
set -s escape-time 0
# basic settings
set-window-option -g mode-keys vi # vi key
set-option -g status-keys vi
#set-window-option -g utf8 on # utf8 support
set-window-option -g mouse on # enable mouse
set -g status on

# copy mode to escape key
unbind-key [
#bind-key Escape copy-mode

# splitting and cycling
unbind-key %
bind-key | split-window -h
unbind-key '"'
unbind-key '_'
bind-key '_' split-window -v
bind-key C-j previous-window
bind-key C-k next-window

# window title
set-option -g set-titles on
set-option -g set-titles-string '#S:#I.#P #W' # window number,program name,active (or not)
set-window-option -g automatic-rename on # auto name
set -g update-environment "DISPLAY SSH_ASKPASS WINDOWID XAUTHORITY SSH_AUTH_SOCK SSH_AGENT_PID SSH_CONNECTION"
set-environment -g 'SSH_AUTH_SOCK' '$HOME/jewart/.ssh/ssh_auth_sock'

# messages
#set-window-option -g mode-bg magenta
#set-window-option -g mode-fg black
#set-option -g message-bg magenta
#set-option -g message-fg black

# No visual activity
#set -g visual-activity off
#set -g visual-bell off

#next tab
#bind-key -n C-right next

#previous tab
#bind-key -n C-left prev

# powerline status bar

# clock
set-window-option -g clock-mode-colour cyan
set-window-option -g clock-mode-style 24

# resize panes
unbind-key ^j        ; bind-key -r ^j     resize-pane -D 5
unbind-key ^k        ; bind-key -r ^k     resize-pane -U 5
unbind-key ^h        ; bind-key -r ^h     resize-pane -L 5
unbind-key ^l        ; bind-key -r ^l     resize-pane -R 5

# move panes
#bind-key -r h select-pane -L
#bind-key -r j select-pane -D
#bind-key -r k select-pane -U
#bind-key -r l select-pane -R

unbind-key -n C-up
unbind-key -n C-down
unbind-key -n C-left
unbind-key -n C-right

#bind-key -n C-up select-pane -U
#bind-key -n C-down select-pane -D
#bind-key -n C-left select-pane -L
#bind-key -n C-right select-pane -R

bind-key -n M-space setw synchronize-panes

unbind-key r
bind-key r source-file ~/.tmux.conf \; display-message "Config reloaded..."
#bind-key -n M-left select-pane -t :.-
#bind-key -n M-right select-pane -t :.+

# Window stuff / selections
bind-key -n M-0 new-window
bind-key -n M-1 select-window -t 0
bind-key -n M-2 select-window -t 1
bind-key -n M-3 select-window -t 2
bind-key -n M-4 select-window -t 3
bind-key -n M-5 select-window -t 4
bind-key -n M-6 select-window -t 5
bind-key -n M-7 select-window -t 6
bind-key -n M-8 select-window -t 7
bind-key -n M-9 select-window -t 8

unbind-key up
unbind-key down
unbind-key left
unbind-key right

#unbind +
#bind + new-window -d -n tmux-zoom 'clear && echo TMUX ZOOM && read' \; swap-pane -s tmux-zoom.0 \; select-window -t tmux-zoom
#unbind -


#bind - last-window \; swap-pane -s tmux-zoom.0 \; kill-window -t tmux-zoom
'';
}
