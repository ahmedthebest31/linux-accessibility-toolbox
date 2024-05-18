#!/bin/bash

# Function to display error message and exit
display_error() {
    echo "Error: $1"
    exit 1
}

# Function to detect Linux distribution
detect_distribution() {
    if [ -f /etc/os-release ]; then
        . /etc/os-release
        if [ "$ID" = "fedora" ]; then
            install_fedora_tools || display_error "Failed to install accessibility tools on Fedora."
        elif [ "$ID" = "arch" ]; then
            install_arch_tools || display_error "Failed to install accessibility tools on Arch Linux."
        elif [ "$ID" = "debian" ]; then
            install_debian_tools || display_error "Failed to install accessibility tools on Debian."
        else
            display_error "Unsupported distribution: $ID"
        fi
    else
        display_error "Unable to detect distribution."
    fi
}

# Function to install accessibility tools on Fedora
install_fedora_tools() {
    sudo dnf update -y && \
    sudo dnf install -y orca onboard gnome-shell-extension-magnifier
    configure_accessibility
}

# Function to install accessibility tools on Arch Linux
install_arch_tools() {
    sudo pacman -Syu --noconfirm && \
    sudo pacman -S --noconfirm orca onboard gnome-shell-extensions
    configure_accessibility
}

# Function to install accessibility tools on Debian
install_debian_tools() {
    sudo apt update -y && \
    sudo apt upgrade -y && \
    sudo apt install -y orca onboard gnome-shell-extensions
    configure_accessibility
}

# Function to configure accessibility settings
configure_accessibility() {
    # Enable high contrast theme
    gsettings set org.gnome.desktop.interface gtk-theme 'Adwaita-dark' && \
    gsettings set org.gnome.desktop.interface icon-theme 'Adwaita'
}

# Call the function to detect distribution and install tools
detect_distribution

echo "Accessibility tools installed and configured successfully."