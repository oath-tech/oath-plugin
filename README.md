<p align="center">
  <img src="plugin/icon.png" alt="Oath" width="96" height="96">
</p>

<h1 align="center">Oath plugin</h1>

<p align="center">
  Work with Oath, your audit firm, from your own AI assistant.
</p>

<p align="center">
  <a href="https://github.com/oath-tech/oath-plugin/releases/latest"><img alt="Latest release" src="https://img.shields.io/github/v/release/oath-tech/oath-plugin?label=release"></a>
  <a href="https://github.com/oath-tech/oath-plugin/actions/workflows/check.yml"><img alt="Checks" src="https://github.com/oath-tech/oath-plugin/actions/workflows/check.yml/badge.svg?branch=main"></a>
  <a href="LICENSE"><img alt="Licence: Apache-2.0" src="https://img.shields.io/github/license/oath-tech/oath-plugin"></a>
  <img alt="Works with Claude, ChatGPT and Codex" src="https://img.shields.io/badge/works%20with-Claude%20%C2%B7%20ChatGPT%20%C2%B7%20Codex-49C9D4">
</p>

The Oath plugin connects your own AI assistant (Claude, ChatGPT or Codex) to Oath. With
it you can:

- answer Oath's onboarding questions in a conversation,
- give Oath read-only access to your data, one system at a time.

The plugin is optional. You can also answer the same questions on Oath's client dashboard.
Your answers show up in both places.

## Install

It takes about 3 minutes, and you sign in with your work email. Pick your assistant:

| You use | Steps |
|---|---|
| Claude, in the browser or the desktop app | [Claude](INSTALL.md#claude-browser-or-desktop-app) |
| ChatGPT, in the browser | [ChatGPT](INSTALL.md#chatgpt-browser) |
| Claude Code | [Claude Code](INSTALL.md#claude-code) |
| Codex | [Codex](INSTALL.md#codex) |

Then type: `Onboard me with Oath`.

## What goes to Oath

Only your answers to Oath's questions, a note when you tell it that you set up an access,
and one usage line per request (which tool, when, and the kind of request; never your
words). No file and no document goes through the assistant. You see what was sent each
time.

## What is in it

The plugin holds no code that runs on your computer. It is text and one server address,
and you can read every word.

| Path | What it is |
|---|---|
| `plugin/skills/` | Two skills, `onboard` and `connect`: the instructions your assistant follows. |
| `plugin/.mcp.json` | The one address the plugin talks to: Oath's server. |
| `plugin/.claude-plugin/plugin.json` | The plugin's name and version. |
| `.claude-plugin/marketplace.json` | Lets Claude, Claude Code and Codex install it from this repo. |

## Releases

Each version is a tag in this repo. The file `oath-plugin-<version>.zip` on its
[release page](https://github.com/oath-tech/oath-plugin/releases) is built from that tag, with its SHA-256 next to it.

## Security

To report a problem, see [SECURITY.md](SECURITY.md).

## Licence

[Apache-2.0](LICENSE).
