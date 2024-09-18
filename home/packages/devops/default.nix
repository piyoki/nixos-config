{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # ansible
    ansible

    # kubernetes
    kubectl
    kubernetes-helm
    k9s # TUI for k8s

    # gitops
    fluxcd # Open and extensible continuous delivery solution for Kubernetes

    # cloudinit
    cloud-utils # cloud-init utilities
  ];
}
