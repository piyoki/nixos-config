{ pkgs, inputs, system, ... }:

let
  tpm = pkgs.fetchFromGitHub {
    owner = "tmux-plugins";
    repo = "tpm";
    rev = "99469c4a9b1ccf77fade25842dc7bafbc8ce9946";
    sha256 = "01ribl326n6n0qcq68a8pllbrz6mgw55kxhf9mjdc5vw01zjcvw5";
  };
  tmux-sensible = pkgs.fetchFromGitHub {
    owner = "tmux-plugins";
    repo = "tmux-sensible";
    rev = "25cb91f42d020f675bb0a2ce3fbd3a5d96119efa";
    sha256 = "0y747qnryvlfch6kd37dwi1svmnnf5l4ijajckfnggz6ikan03xk";
  };
  tmux-continuum = pkgs.fetchFromGitHub {
    owner = "tmux-plugins";
    repo = "tmux-continuum";
    rev = "0698e8f4b17d6454c71bf5212895ec055c578da0";
    sha256 = "15hlal3jh5lpisnph0rza9f2hrvri5k4f2xpvprwbz02pk451gav";
  };
  tmux-resurrect = pkgs.fetchFromGitHub {
    owner = "tmux-plugins";
    repo = "tmux-resurrect";
    rev = "cff343cf9e81983d3da0c8562b01616f12e8d548";
    sha256 = "0djfz7m4l8v2ccn1a97cgss5iljhx9k2p8k9z50wsp534mis7i0m";
  };
  tmux-yank = pkgs.fetchFromGitHub {
    owner = "tmux-plugins";
    repo = "tmux-yank";
    rev = "acfd36e4fcba99f8310a7dfb432111c242fe7392";
    sha256 = "142ybm3wdqbdmdc7502am2xscrrabn72cnanyaflvndihdmcz4gz";
  };
  t-smart-tmux-session-manager = pkgs.fetchFromGitHub {
    owner = "joshmedeski";
    repo = "t-smart-tmux-session-manager";
    rev = "3726950525ac9966412ea3f2093bf2ffe06aa023";
    sha256 = "0pnr1d582znbypclqc724lsfzmzz7s4sc468qgsi7dfmf6iriiq0";
  };
  minimal-tmux-status = pkgs.fetchFromGitHub {
    owner = "niksingh710";
    repo = "minimal-tmux-status";
    rev = "8677c29003f95695970eb6f4b7793158c9baf1a0";
    sha256 = "0nly1ki2b0k0ycvyp863dragv6xa6vm0lmh98x62rbiyww0z60gy";
  };
  tmuxifier = pkgs.fetchFromGitHub {
    owner = "jimeh";
    repo = "tmuxifier";
    rev = "9941b280635c7396b3cc6c15e92ea68a5cc24dd4";
    sha256 = "08sffzl7gnw5v9izs4a8wjz8inkvngywhkhv5das1ipqxpmilpm8";
  };
in
{
  home.file = {
    ".tmux.conf".source = inputs.dotfiles.packages.${system}.tmux-universal + "/.tmux.conf";
    ".gitmux.conf".source = inputs.dotfiles.packages.${system}.tmux-universal + "/.gitmux.conf";
    ".tmux/plugins/tpm".source = tpm + "/";
    ".tmux/plugins/tmux-sensible".source = tmux-sensible + "/";
    ".tmux/plugins/tmux-continuum".source = tmux-continuum + "/";
    ".tmux/plugins/tmux-resurrect".source = tmux-resurrect + "/";
    ".tmux/plugins/tmux-yank".source = tmux-yank + "/";
    ".tmux/plugins/t-smart-tmux-session-manager".source = t-smart-tmux-session-manager + "/";
    ".tmux/plugins/minimal-tmux-status".source = minimal-tmux-status + "/";
    ".tmuxifier".source = tmuxifier + "/";
  };
}
