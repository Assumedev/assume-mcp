# Assume for Cursor

Cursor Marketplace plugin for [Assume](https://assume.dev): secretless agent execution over HTTP MCP.

The model never receives API keys. Operators issue a connector token and agent id; Cursor sends those as headers to `https://mcp.assume.dev/mcp`.

## Install

1. Install this plugin from the Cursor Marketplace (or clone this repo as a local plugin).
2. In Assume Cloud, create an agent and copy the **MCP connector token** (`mcp_…`) and **agent id**.
3. When Cursor asks for plugin variables, paste:
   - `ASSUME_MCP_TOKEN` — connector token (not an Ed25519 private key)
   - `ASSUME_AGENT_ID` — agent id (for example `agent_de08ddb70281f4ce745c0612`)

## What this repo contains

| File | Purpose |
| --- | --- |
| `.cursor-plugin/plugin.json` | Marketplace manifest and required variables |
| `.cursor-plugin/logo.svg` | Plugin logo |
| `mcp.json` | HTTP MCP server: `https://mcp.assume.dev/mcp` |

## Product

Assume is a capability broker: agents request scoped, time-limited permissions; the broker injects credentials inside the executor and returns redacted results.

- Dashboard: [assume.dev](https://assume.dev)
- Agent loop: search → describe → request capability → execute

Do not paste vault passwords, PATs, or private keys into chat.

## Claude custom connector

This plugin is for Cursor. Claude Team orgs add Assume separately as a custom connector (no plugin variables, no `mcp_` token):

1. Organization owner: Connectors → Add → Custom → Web.
2. Name `Assume`, URL `https://mcp.assume.dev/mcp`.
3. Authentication: Sign in now or Sign in when needed. OAuth client: Register automatically. No request headers.
4. Each member: Customize → Connectors → Assume → Connect, then sign in to their own Assume account and pick or create an agent.

A newly created agent has no account access until granted in the Assume dashboard.
