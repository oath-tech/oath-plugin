# Install the Oath plugin

You sign in with your work email. Oath never asks for a password, and never sends the
plugin as an email attachment.

## Which one do I use?

| You use | Go to |
|---|---|
| Claude, in the browser or the desktop app | "Claude" below |
| Claude Code | "Claude Code" below |
| ChatGPT, in the browser | "ChatGPT" below |
| Codex | "Codex" below |
| No AI assistant | Use Oath's client dashboard. It asks the same questions |

**If your Claude belongs to your company** (a Team or Enterprise plan): only an owner of
your company's Claude can add a new connector. Send them the section "For the owner of a
company's Claude" at the end. Without that step the **Connect** button stays off.

## Claude (browser or desktop app)

It takes about 3 minutes. You download nothing: Claude fetches the plugin itself.

1. In Claude, open **Customize** in the left bar, then **Plugins**.
2. Press **Add** (top right), then **Add marketplace**.
3. In the field, type `oath-tech/oath-plugin`, choose it from the list, and press **Sync**.
   The name must be exactly that, with the dash in `oath-tech`. Oath has no other repo
   for the plugin.
4. Install **Oath** from the marketplace's list.
5. On the plugin's page, find **Oath-Verified** under Connectors and press **Connect**.
6. A window named "Add custom connector" opens. **Check the address is exactly
   `https://app.oathverified.com/api/mcp`.** If it is, change nothing and press
   **Continue**. If it is not, stop and tell us.
7. A sign-in page opens, on `auth.app.oathverified.com`. Type your work email, then the code that
   Oath sends to it. Do not use a Google or Microsoft button, if the page shows one.
8. Press **Try in chat**. Claude starts the questions.
9. Claude asks if it may use Oath's tools, one time for each tool. For the tools that
   read, you can press **Always allow**. Two tools send to Oath:
   `submit_onboarding_answers` and `report_connection_setup`. For those, press
   **Allow once** each time, unless you are happy that your answers go without a pop-up.

### If "Add marketplace" does not work: upload the file

1. Download `oath-plugin-<version>.zip` from this repo's
   [latest release](https://github.com/oath-tech/oath-plugin/releases/latest), and
   nowhere else.
2. Check the file is the one Oath built. The release page gives its SHA-256. In a
   terminal, run `shasum -a 256` on the file you downloaded, and compare the two. If they
   differ, do not use the file, and tell us.
3. In Claude, open **Customize**, then **Plugins**. Press **Add**, then **Upload plugin**,
   and choose the file.
4. Go on from step 5 above.

## ChatGPT (browser)

It takes about 3 minutes. Tried on a ChatGPT Plus plan. ChatGPT needs no file: you give
it Oath's address.

1. In ChatGPT, open **Plugins** in the left bar.
2. Press **Add** (top right), then **Add custom MCP server**.
3. Fill in the form:
   - **Name:** `Oath Verified`
   - **Server URL:** `https://app.oathverified.com/api/mcp`. Type it exactly.
   - **Authentication:** leave **OAuth**. Change nothing under Advanced OAuth settings.
4. ChatGPT shows a warning about custom servers. Tick **I understand and want to
   continue**, then press **Create as a plugin**.
5. A window named "Connect Oath Verified" opens. Press **Continue to Oath Verified**.
6. A sign-in page opens, on `auth.app.oathverified.com`. Type your work email, then the code that
   Oath sends to it. Do not use the Google or Microsoft buttons. If this browser is
   already signed in to Oath, the page does not show: go on to the next step.
7. A page named "Connect ChatGPT to Oath" opens, on the same address. Press **Allow**.
8. You are back in ChatGPT. Open **Oath Verified** under Installed and press **Try in
   chat**. Type: `Onboard me with Oath`.
9. If you work with Oath for more than one organization, ChatGPT asks which one. Pick it.
10. ChatGPT reads from Oath without asking, and shows you what it sent each time. It may
    first ask "Allow ChatGPT to use Oath Verified?" and show what goes. If it does, press
    **Allow once** each time, unless you are happy that your answers go without a pop-up.

If you do not see **Add custom MCP server**, your plan or your company's ChatGPT does not
allow it. Use Oath's client dashboard.

## Claude Code

1. Run these two commands in a terminal:

   ```bash
   claude plugin marketplace add oath-tech/oath-plugin
   ```

   ```bash
   claude plugin install oath@oath
   ```

2. Check the address. Run:

   ```bash
   claude mcp list
   ```

   The line for **Oath-Verified** must show exactly
   `https://app.oathverified.com/api/mcp`. If it does not, stop and tell us.
3. Start a new session. Type `/mcp`, choose **Oath-Verified**, and sign in with your work
   email and the code. A page named "Connect ... to Oath" then opens, on
   `auth.app.oathverified.com`. Press **Allow**.
4. Type: `Onboard me with Oath`. If you work with Oath for more than one organization,
   say which one.

## Codex

1. Run these two commands in a terminal:

   ```bash
   codex plugin marketplace add oath-tech/oath-plugin
   ```

   ```bash
   codex plugin add oath@oath
   ```

2. Check the address. Run:

   ```bash
   codex mcp list
   ```

   The line for **Oath-Verified** must show exactly
   `https://app.oathverified.com/api/mcp`. If it does not, stop and tell us.
3. Sign in:

   ```bash
   codex mcp login Oath-Verified
   ```

   A sign-in page opens. Type your work email, then the code.
4. Start Codex and type: `Onboard me with Oath`.

## What to say

| Say | What happens |
|---|---|
| "Onboard me with Oath" | It asks Oath's questions and sends your answers. It shows you what went. |
| "Connect my data to Oath" | It gives you the steps to give Oath read-only access to each place you named. |

## If it does not work

Answer on Oath's client dashboard. Nothing is lost: the answers you already gave are saved.

## For the owner of a company's Claude

A member of your team wants to use Oath's plugin. In **Organization settings →
Connectors**, press **Add custom connector** and give it this address:

`https://app.oathverified.com/api/mcp`

Check the address is exactly the one above, and leave the choices as they are. After
that, your team member can press **Connect** and sign in with their own work email. The
connector reads and writes only that person's own company's data at Oath.
