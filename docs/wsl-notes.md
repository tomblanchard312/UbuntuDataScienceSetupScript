# WSL Notes

## Intended Usage

Use `wsl_post_install.sh` when running Ubuntu under WSL2.

```bash
./wsl_post_install.sh --profile base,python,wsl --light
```

## systemd Requirement

Some optional tooling expects systemd to be enabled in WSL.

Set `/etc/wsl.conf` to:

```ini
[boot]
systemd=true
```

Then restart WSL from Windows:

```powershell
wsl --shutdown
```

## Docker in WSL

Docker is optional and should be requested explicitly via the `docker` profile.

```bash
./wsl_post_install.sh --profile base,python,docker
```

Choose a Docker workflow that fits your environment and enterprise policy (Docker Desktop integration or Linux engine in WSL).
