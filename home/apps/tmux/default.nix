{ pkgs, ... }:
{
  programs.tmux = {
    enable = true;
    baseIndex = 1;
    escapeTime = 0;
    clock24 = true;
    shell = "${pkgs.fish}/bin/fish";
    keyMode = "vi";

    plugins = with pkgs; [
      tmuxPlugins.cpu
      tmuxPlugins.resurrect
      tmuxPlugins.continuum
    ];

    extraConfig = ''
      #### Enable the powerline status bar ####
      run-shell 'powerline-config tmux setup'

      #### Global Settings ####
      set -g default-shell /usr/bin/fish
      set -g default-terminal "screen-256color"
      # Set tmux mode to vi (default is emac)
      set-window-option -g mode-keys vi
      # Path settings
      tmux_conf_new_pane_retain_current_path=true
      tmux_conf_new_window_retain_current_path=true
      set -g monitor-activity on # update status bar if there are changs in other windows
      set -g visual-activity on
      # Disable confirmation prompt on kill-window and kill-pane
      bind-key & kill-window
      bind-key x kill-pane
      set -g base-index 1 # set window number starting from 1
      set -g pane-base-index 1 # set pane number starting from 1
      set -g xterm-keys on
      set-option -g status-right-length 100 # set maximum length

      #### Key Mappings ####
      unbind C-b # Remap default keys
      set -g prefix C-Q # this just changes prefix from Ctrl-B to Ctrl-Q

      # Pane Split
      unbind '"'
      unbind %
      bind | split-window -h # Split panes horizontal
      bind - split-window -v # Split panes vertically

      # Vim-Like pane switching

      # Remap direction keys to vim-like pane resizing (hjkl), -r means repetitive
      bind -r k select-pane -U # remap to ←
      bind -r j select-pane -D # remap to →
      bind -r h select-pane -L # remap to ↑
      bind -r l select-pane -R # remap to ↓

      # Adjust pane size with `ctrl + hjkl`
      bind -r C-k resize-pane -U # remap to <C-←>
      bind -r C-j resize-pane -D # remap to <C-→>
      bind -r C-h resize-pane -L # remap to <C-↑>
      bind -r C-l resize-pane -R # remap to <C-↓>

      unbind Up
      unbind Down
      unbind Left
      unbind Right

      unbind C-Up
      unbind C-Down
      unbind C-Left
      unbind C-Right

      # Remap copy-mode shortcuts
      bind Tab last-window
      bind Enter copy-mode
      bind -T copy-mode-vi v send -X begin-selection
      bind -T copy-mode-vi y send -X copy-pipe

      # Reload config file (change file location to your the tmux.conf you want to use)
      bind r source-file ~/.tmux.conf \; display-message " Config reloaded.."

      # Syncronize pane
      bind T set-window-option synchronize-pane on
      bind K set-window-option synchronize-pane off

      #### Mouse support - set to on if you want to use the mouse ####
      set-option -g mouse off # disable default mouse function (tmux > v2.1)

      #### Styling ####

      # background_color '#282a36'
      # current_line_color '#121212'
      # foreground_color '#8c8c8c'
      # comment_color '#121212'
      # dark '#1f2226'
      # lightblue '#b6dcef'
      # darkblue '#48b5cf'
      # violet '#b6dcef'
      # darkviolet '#48b5cf'
      # gray '#8c8c8c'
      # black '#262626'

      # pane border
      set -g pane-border-style fg='#121212'
      set -g pane-active-border-style fg='#b6dcef'

      # message text
      set -g message-style bg='#1f2226',fg='#8c8c8c'

      set -g status-style bg='#121212',fg='#1f2226'
      set -g status-interval 0.5

      # status left
      set -g status-left '#[bg=#121212]#[fg=#8c8c8c]#{?client_prefix,#[bg=#b6dcef]#[fg=#121212],}  '
      set-window-option -g window-status-style fg='#1f2226',bg=default
      set-window-option -g window-status-current-style fg='#b6dcef',bg='#282a36'

      set -g window-status-current-format "#[fg=#121212]#[bg=#1f2226]#[fg=#8c8c8c]#[bg=#1f2226] #I #W #[fg=#1f2226]#[bg=#121212] "
      set -g window-status-format "#[fg=#8c8c8c]#[bg=#121212]#I #W #[fg=#121212] "

      # status right
      # set -g status-right '#[fg=#1f2226,bg=#121212]#[fg=#8c8c8c,bg=#1f2226] #{cpu_percentage}'
      set -ga status-right '#[fg=#b6dcef,bg=#1f2226]#[fg=#121212,bg=#b6dcef] #{cpu_percentage} '
      set -ga status-right '#[fg=#1f2226,bg=#b6dcef]#[fg=#48b5cf,bg=#262626]  %a %H:%M #[fg=#8c8c8c]%m-%d '

      # Tmux Rescurrect
      run-shell ~/.tmux/plugins/tmux-resurrect/resurrect.tmux
      set -g @resurrect-save 'S' # Save
      set -g @resurrect-restore 'R' # Recovery
      set -g @resurrect-dir '/home/kev/.config/tmux/'
      # Tmux Continuum
      run-shell ~/.tmux/plugins/tmux-continuum/continuum.tmux
      set -g @continuum-save-interval '1440' # auto-backup once a day
      set -g @continuum-restore 'on'

      # set -g status-right '#[fg=black,bg=color15] #{cpu_percentage}  %H:%M '
      run-shell ${pkgs.tmuxPlugins.cpu}/share/tmux-plugins/cpu/cpu.tmux
    '';
  };
}
