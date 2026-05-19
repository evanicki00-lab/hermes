# Update Telegram Token

This repo must not store Telegram bot tokens.

Safe procedure:
1. Confirm token rotation with the user.
2. SSH to the VDS.
3. Update the runtime secret location used by Hermes, usually `/home/hermes/.hermes/.env` or the deployment-specific secret store.
4. Restart `hermes-gateway.service` only after confirming the new value is present.
5. Run `scripts/healthcheck.*`.
6. Document the date and result without writing the token.

Never print the token in terminal output or commit it to this repository.
