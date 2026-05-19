# Hermes Runtime Architecture

The current deployment is a single Hermes Agent exposed through the Telegram gateway service.

Runtime pieces:
- Telegram gateway: `hermes-gateway.service`
- Hermes home: `/home/hermes/.hermes`
- Workspace: `/srv/hermes/workspace`
- Persistent project docs and plans: this private GitHub repository

Boundary:
- VDS stores runtime state and secrets.
- This repo stores safe documentation, sanitized config snapshots, runbooks, and planning docs.
- Large style corpora and user content should live in Hermes workspace docs, not in global memory unless they represent stable preferences.
