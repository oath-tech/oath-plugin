# Install the Oath plugin

You sign in with your work email. Oath never asks for a password, and never sends the
plugin as an email attachment.

## Which one do I use?

| You use | Go to |
|---|---|
| Claude, in the browser or the desktop app | "Claude" below |
| Claude Code | "Claude Code" below |
| Codex | "Codex" below |
| No AI assistant | Use Oath's page. It asks the same questions |

**If your Claude belongs to your company** (a Team or Enterprise plan): only an owner of
your company's Claude can add a new connector. Send them the section "For the owner of a
company's Claude" at the end. Without that step the **Connect** button stays off.

## Claude (browser or desktop app)

It takes about 3 minutes.

1. Download `oath-plugin-<version>.zip` from this repo's
   [latest release](https://github.com/oath-tech/oath-plugin/releases/latest), and
   nowhere else.
2. In Claude, open **Plugins**. It is in the left bar, or under **Customize**.
3. Press **Add**, then **Upload plugin**, and choose the file.
4. On the plugin's page, find **Oath-Verified** under Connectors and press **Connect**.
5. A window named "Add custom connector" opens. **Check the address is exactly
   `https://review.oathverified.com/api/mcp`.** If it is, change nothing and press
   **Continue**. If it is not, stop and tell us.
6. A sign-in page opens, on `api.descope.com`. Type your work email, then the code that
   Oath sends to it.
7. Press **Try in chat**. Claude starts the questions.
8. Claude asks if it may use Oath's tools, one time for each tool. For the tools that
   read, you can press **Always allow**. Two tools send to Oath:
   `submit_onboarding_answers` and `report_connection_setup`. For those, press
   **Allow once** each time, unless you are happy that your answers go without a pop-up.

## Claude Code

1. Run these two commands in a terminal:

   ```bash
   claude plugin marketplace add oath-tech/oath-plugin
   ```

   ```bash
   claude plugin install oath@oath
   ```

2. Start a new session. Type `/mcp`, choose **Oath-Verified**, and sign in with your work
   email and the code.
3. Type: `Onboard me with Oath`.

## Codex

1. Run these two commands in a terminal:

   ```bash
   codex plugin marketplace add oath-tech/oath-plugin
   ```

   ```bash
   codex plugin add oath@oath
   ```

2. Sign in:

   ```bash
   codex mcp login Oath-Verified
   ```

   A sign-in page opens. Type your work email, then the code.
3. Start Codex and type: `Onboard me with Oath`.

## What to say

| Say | What happens |
|---|---|
| "Onboard me with Oath" | It asks Oath's questions and sends your answers. It shows you what went. |
| "Connect my data to Oath" | It gives you the steps to give Oath read-only access to each place you named. |
| "What is Oath missing from me?" | It reads the documents that Oath still needs. |

## If it does not work

Answer on Oath's page. Nothing is lost: the answers you already gave are saved.

## For the owner of a company's Claude

A member of your team wants to use Oath's plugin. In **Organization settings →
Connectors**, press **Add custom connector** and give it this address:

`https://review.oathverified.com/api/mcp`

Check the address is exactly the one above, and leave the choices as they are. After
that, your team member can press **Connect** and sign in with their own work email. The
connector reads and writes only that person's own company's data at Oath.
