{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # ansible
    ansible

    # kubernetes
    kubectl
    kubernetes-helm
    k9s # TUI for k8s
    fluxcd # Open and extensible continuous delivery solution for Kubernetes

    # cloudinit
    cloud-utils # cloud-init utilities

    # containerization
    buildkit # Concurrent, cache-efficient, and Dockerfile-agnostic builder toolkit
  ];
}
