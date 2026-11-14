# Security architecture

Threat model: malicious downloads, untrusted tools, stolen credentials, exposed network services, unsafe AI output and supply-chain compromise.

1. Enable full-disk encryption at OS installation time; this scaffold does not repartition disks.
2. Keep Secure Boot / signed boot artifacts as future release work, not a current guarantee.
3. Use least privilege, separate untrusted labs in VMs, and never run AI-suggested shell commands automatically.
4. Enable UFW only after reviewing remote access implications; see `hardening/apply.sh`.
5. Consider AppArmor, auditd, automatic update notifications and snapshots as separately tested profiles.
6. Never place cloud API keys in Git; use environment injection from a secret manager.
7. Keep the Ollama HTTP listener bound to loopback; do not expose it to the public internet.
8. Do not upload private logs, credentials, or client data to cloud AI without authorization.
9. Validate downloaded artifacts and pin dependencies before public release.
