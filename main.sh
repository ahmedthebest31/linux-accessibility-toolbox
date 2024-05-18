#!/bin/bash

# Function to detect Linux distribution
detect_distribution() {
    if [ -f /etc/os-release ]; then
        . /etc/os-release
        if [ "$ID" = "fedora" ]; then
            install_fedora_tools
        elif [ "$ID" = "arch" ]; then
            install_arch_tools
        elif [ "$ID" = "debian" ]; then
            install_debian_tools
        else
            echo "Unsupported distribution: $ID"
            exit 1
        fi
    else
        echo "Unable to detect distribution."
        exit 1
    fi
}

# Function to install accessibility tools on Fedora
install_fedora_tools() {
    sudo dnf update -y
    sudo dnf install -y orca onboard gnome-shell-extension-magnifier
    configure_accessibility
}

# Function to install accessibility tools on Arch Linux
install_arch_tools() {
    sudo pacman -Syu --noconfirm
    sudo pacman -S --noconfirm orca onboard gnome-shell-extensions
    configure_accessibility
}

# Function to install accessibility tools on Debian
install_debian_tools() {
    sudo apt update -y
    sudo apt upgrade -y
    sudo apt install -y orca onboard gnome-shell-extensions
    configure_accessibility
}

# Function to configure accessibility settings
configure_accessibility() {
    # Enable high contrast theme
    gsettings set org.gnome.desktop.interface gtk-theme 'Adwaita-dark'
    gsettings set org.gnome.desktop.interface icon-theme 'Adwaita'
}

# Call the function to detect distribution and install tools
detect_distribution

echo "Accessibility tools installed and configured successfully."