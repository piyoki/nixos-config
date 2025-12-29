{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # aws
    awscli2

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

    # infrastructure management
    terraform # Infrastructure as Code software tool
    terragrunt # Thin wrapper for Terraform that provides extra tools for keeping your configurations DRY
  ];
}
