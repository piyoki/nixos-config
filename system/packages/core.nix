{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # basic but essential
    bash-completion # Programmable completion for the bash shell
    git # Distributed version control system
    gnutar # GNU version of the tar archiving utility
    killall # Kill processes
    neofetch # A command-line system information tool
    fastfetch # A command-line system information tool
    screen # Terminal multiplexer with VT100/ANSI terminal emulation
    tmux # Terminal multiplexer
    tree # List contents of directories in a tree-like format
    vim # Vi IMproved, a highly configurable text editor
    wget # A network utility to retrieve files from the Web
    ripgrep # Recursively searches directories for a regex pattern
    just # Just a command runner
    pwgen # Password generator
    openssl # Secure Sockets Layer toolkit
    pkg-config # Manage compile and link flags for libraries
    tailspin # A log file highlighter
  ];
}
