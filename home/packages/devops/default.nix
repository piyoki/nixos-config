{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # ansible
    ansible

    # docker
    lazydocker # Docker terminal UI.
    # dive # A tool for exploring each layer in a docker image

    # kubernetes
    kubectl
    kubernetes-helm
    k9s # TUI for k8s

    # gitops
    fluxcd # Open and extensible continuous delivery solution for Kubernetes
  ];
}
