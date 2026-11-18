# Oath plugin

The Oath plugin connects your own AI assistant (Claude, ChatGPT or Codex) to Oath, your audit firm.
With it you can:

- answer Oath's onboarding questions in a conversation,
- give Oath read-only access to your data, one system at a time,
- ask where your audit stands and what Oath still needs from you.

The plugin is optional. You can also answer the same questions on Oath's client dashboard.
Your answers show up in both places.

**How to install it:** [INSTALL.md](INSTALL.md).

## What is in it

| Path | What it is |
|---|---|
| `plugin/skills/` | Three skills: the instructions your assistant follows. You can read every word. |
| `plugin/.mcp.json` | The one address the plugin talks to: Oath's server. |
| `plugin/.claude-plugin/plugin.json` | The plugin's name and version. |
| `.claude-plugin/marketplace.json` | Lets Claude Code and Codex install it from this repo. |

The plugin holds no code that runs on your computer. It is text and one server address.

## What goes to Oath

Only your answers to Oath's questions, a note when you tell it that you set up an access,
and one usage line per request (which tool, when, and the kind of request; never your
words). No file and no document goes through the assistant. You see what was sent each
time.

## Releases

Each version is a tag in this repo. The file `oath-plugin-<version>.zip` on its
[release page](../../releases) is built from that tag, with its SHA-256 next to it.

## Security

To report a problem, see [SECURITY.md](SECURITY.md).
