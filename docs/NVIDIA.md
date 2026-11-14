# NVIDIA support

Do not blindly install a kernel module. First inspect `uname -r`, `pacman -Q linux linux-lts linux-zen 2>/dev/null`, `lspci -k`, and `nvidia-smi`.

On Arch, driver selection varies with GPU generation, kernel, and whether open/proprietary modules are appropriate. Consult the current Arch Wiki NVIDIA page and Omarchy release notes. `nvidia-utils` is not itself a complete working driver installation. Test Ollama GPU detection after reboot. Keep a rollback kernel and snapshot. Avoid forcing GPU driver upgrades in this project installer.
