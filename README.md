# docker-socket-proxy

## What is this?

This is a fork of https://github.com/Tecnativa/docker-socket-proxy with added https support and updated haproxy, to a few line of this README.md and the haproxy.cfg config still applies the Apache-2.0 license.

## Grant or revoke access to certain API sections

You grant and revoke access to certain features of the Docker API through environment
variables.

Normally the variables match the URL prefix (i.e. `AUTH` blocks access to `/auth/*`
parts of the API, etc.).

Possible values for these variables:

-   `0` to **revoke** access.
-   `1` to **grant** access.

### Access granted by default

These API sections are mostly harmless and almost required for any service that uses the
API, so they are granted by default.

-   `EVENTS`
-   `PING`
-   `VERSION`

### Access revoked by default

#### Security-critical

These API sections are considered security-critical, and thus access is revoked by
default. Maximum caution when enabling these.

-   `AUTH`
-   `SECRETS`
-   `POST`: When disabled, only `GET` and `HEAD` operations are allowed, meaning any section of the API is read-only.
-   `NOPOST` Allows ALL (with ALL I mean ALL) GET requests to the socket (so no POST, HEAD, etc.) - so full read-only access

#### Not always needed

You will possibly need to grant access to some of these API sections, which are not so
extremely critical but can expose some information that your service does not need.

-   `ALLOW_POWER` (containers/`id`/`start`|`stop`|`kill`|`restart`)
-   `ALLOW_RESTART` (containers/`id`/`restart`)
-   `ALLOW_START` (containers/`id`/`start`)
-   `ALLOW_STOP` (containers/`id`/`stop`)
-   `ALLOW_Kill` (containers/`id`/`kill`)
-   `BUILD`
-   `COMMIT`
-   `CONFIGS`
-   `CONTAINERS`
-   `DISTRIBUTION`
-   `EXEC`
-   `GRPC`
-   `IMAGES`
-   `INFO`
-   `NETWORKS`
-   `NODES`
-   `PLUGINS`
-   `SERVICES`
-   `SESSION`
-   `SWARM`
-   `SYSTEM`
-   `TASKS`
-   `VOLUMES`
