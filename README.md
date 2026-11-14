# Shelly Shields Linux — AI Security Edition (0.2-alpha)

Arch/Omarchy-compatible, modular cybersecurity workstation scaffold. **Not yet a standalone distro or tested ISO.** Use only on systems and networks you own or are authorized to test.

## Quick start (existing Arch / Omarchy)

```bash
unzip shelly-shields-ai-0.2.zip
cd shelly-shields-ai
./install.sh --dry-run
./install.sh --profile core
shelly doctor
shelly ai --help
```

`install.sh` installs distro packages using pacman and user-local commands. It does not alter disk partitions, bootloader, display manager or existing Hyprland config. Review package lists before proceeding. Re-login or run `export PATH="$HOME/.local/bin:$PATH"`.

## Local AI

Install Ollama separately using trusted upstream/Arch packaging, start its service and pull a model explicitly (for example `ollama pull llama3.2:3b`). Then `shelly ai --model llama3.2:3b 'Explain this firewall log'`. Local AI calls `http://127.0.0.1:11434/api/chat` and does not automatically run commands.

## Optional cloud AI

Cloud mode is **opt-in**: set `SHELLY_CLOUD_ENDPOINT` to a trusted OpenAI-compatible HTTPS chat completions endpoint, `SHELLY_CLOUD_MODEL`, and `SHELLY_CLOUD_API_KEY` (prefer a secret manager; never commit credentials). Run `shelly ai --cloud 'question'`. Prompts are sent to that endpoint only when `--cloud` is supplied. No automatic fallback from local to cloud. Inspect the endpoint's privacy policy.

## NVIDIA

`./install.sh --profile nvidia` installs common Arch NVIDIA user-space utilities (`nvidia-utils`, `nvidia-settings`) only; kernel-specific driver selection is intentionally manual. Consult `docs/NVIDIA.md` before installing drivers, especially on hybrid GPUs and custom kernels. Ollama GPU support depends on compatible drivers and hardware.

## Security profiles

`core`, `recon`, `web`, `forensics`, `defense`, `nvidia` in `profiles/*.txt`. Packages are installed only for selected profiles; unavailable packages are reported and skipped by design. No automatic scanning, exploitation, or elevated commands are run by the assistant.

## ISO build foundation

`archiso/` contains a minimal releng-derived overlay and customization files. On a dedicated Arch build host with `archiso` installed, run `sudo ./build-iso.sh`. The script copies `/usr/share/archiso/configs/releng` and overlays project files, then invokes `mkarchiso`; output under `out/`. This is an experimental ISO **build foundation**, not a tested installed system. Build in a VM and inspect package licenses and upstream compatibility.

## Security design

- Local-first AI; cloud requires explicit `--cloud`
- No arbitrary AI tool execution; no auto-shell or background scanning
- Firewall hardening script is opt-in and prints actions before applying
- Host integrity and kernel security suggestions in `docs/HARDENING.md`
- Future: signed packages, reproducible ISO, installer, encrypted storage, audit logs, scoped agents

## Files

- `bin/shelly` — CLI and AI chat
- `install.sh` — safe modular package installation
- `profiles/` — package groups
- `hardening/apply.sh` — optional UFW baseline
- `archiso/` and `build-iso.sh` — ISO starter
- `tests/` — smoke checks

## Limitations

This alpha has not been tested on your Omarchy machine. Pacman packages and GPU drivers depend on your installed kernel and current repositories. An ISO that builds is not proof it boots or installs correctly. Back up before changing system packages.
