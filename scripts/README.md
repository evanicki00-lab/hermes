# Scripts

- `sync-from-vds.sh` / `sync-from-vds.ps1`: refresh safe snapshots from the VDS.
- `healthcheck.sh` / `healthcheck.ps1`: read-only service and runtime checks.
- `verify-no-secrets.sh` / `verify-no-secrets.ps1`: block obvious secret leaks before commit.

Scripts default to `root@78.17.192.180:22` and the discovered SSH key path.
