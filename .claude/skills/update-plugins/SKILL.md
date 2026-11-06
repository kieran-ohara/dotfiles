---
name: update-plugins
description: "Update vim/nvim plugins managed as git submodules one at a time, with a per-plugin report of breaking changes measured against the user's own config, new requirements, notable features, and cross-plugin overlaps, before anything is moved. Use this whenever the user wants to update, upgrade, bump or review their editor plugins or dotfiles submodules, asks what has changed upstream in a plugin, or mentions `git submodule update` for their editor — even if they only ask about one plugin."
allowed-tools: Read, Grep, Glob, Bash, Task, AskUserQuestion
---

# Update Editor Plugins

Replace "submodule update --remote and hope" with an informed, one-at-a-time
update. The expensive part is reading what changed; fan that out to one
inspector per plugin, then assemble the findings so the user can see conflicts
and overlaps across plugins before choosing what to move.

## 1. Survey

Run the bundled survey from the dotfiles root. It fetches every plugin
submodule and reports how far behind each one is:

```bash
sh <skill-dir>/scripts/survey.sh <repo-root> | sort -rn
```

Pass a path filter as the second argument to limit the survey, e.g.
`site/pack/lsp` for one group or the full submodule path for one plugin.

Present the result as a table, most-behind first, with columns: plugin, group,
commits behind, tag now, tag upstream, changelog present. Drop rows with zero
commits behind; they need no inspection.

Then ask the user what scope to inspect: everything behind, one group, or named
plugins. Default to everything behind.

## 2. Find the config for each plugin

Each plugin group has the user's own setup code beside the plugins, typically
`pack/<group>/start/config/plugin/*.lua` or `*.vim`. Collect those files for
each plugin's group, and also hand every inspector the full list of config
directories across both editor trees. Neovim loads the vim tree too, and a
plugin in one group is often referenced from another: a `<CR>` mapping in the
autocomplete group is what a vim-tree plugin's `<CR>` wrapper interacts with.
An inspector that only sees its own group's files will report "not configured"
for things that are configured two directories over. Where a group has no
config of its own, say so; the inspector then reports on the plugin's defaults
and on consumers elsewhere.

Record the editor version too (`nvim --version | head -1`, or `vim --version`
for the vim tree), since minimum-version bumps are a common silent breakage.

## 3. Inspect in parallel

For each plugin in scope, spawn a `plugin-change-inspector` agent with the Task
tool, all in one response so they run concurrently:

- **subagent_type**: `plugin-change-inspector`
- **description**: "Inspect: <plugin>"
- **prompt**:
  ```
  Inspect this plugin update.

  - Plugin path: <absolute path>
  - Current commit: <sha>  (tag: <tag or ->)
  - Upstream commit: <sha>  (tag: <tag or ->)
  - Config files: <absolute paths, or "none">
  - Editor version: <version>

  Report in the structure your instructions define.
  ```

Inspectors only read; nothing moves yet.

The harness caps concurrent subagents (twenty by default). With more plugins
than that in scope, send the first twenty and launch the rest as completions
come in rather than waiting for the whole batch.

## 4. Assemble the report

Combine the inspector reports into one document. Keep each plugin's section as
the inspector wrote it, ordered by risk then by commits behind, and add two
sections of your own at the top:

**Needs attention** — every "Affects your config" bullet across all plugins,
with the plugin name, so the user sees in one place what will break.

**Across plugins** — what no single inspector could see:

- *Overlaps*: an "Overlaps" bullet from one plugin that another plugin in the
  user's set, or the editor itself at the installed version, already provides.
  Name both sides. The user's plugin set is the survey table; the editor's
  built-ins at that version are yours to know.
- *Coupling*: plugins that should move together. Completion engines and their
  sources, a plugin and the library it depends on, a parser framework and the
  lockfile or script that builds its parsers.
- *Environment*: the highest minimum editor version any update demands, against
  the installed one.

Publish the report as an Artifact when the tool is available, so the user can
read it beside the terminal, and summarise the "Needs attention" section in
the conversation.

## 5. Update one at a time

Walk the plugins in the report's order. For each one, show its section and ask
with AskUserQuestion: update, skip, or hold at a specific tag. Default the
target to the latest tag when the plugin tags releases and to upstream HEAD
when it does not; the survey table shows which.

On "update":

1. In the submodule, `git checkout <target>`.
2. Make any config edit the inspector called for, in the user's config files.
3. Smoke test: `nvim --headless "+lua vim.print('ok')" +qa` from the dotfiles
   root, or the equivalent for vim, and check for errors on stderr. A plugin
   that errors at startup is caught here, not at the user's next editing
   session.
4. If the plugin is a parser framework, remind the user that parsers need
   rebuilding and name the script.
5. Commit the submodule bump and the config edit together, from the dotfiles
   root, with a message that names the plugin, the range, and the one or two
   changes that mattered. No prefixes.

On a smoke-test failure, show the error, revert the checkout, and move on; the
user can come back to it.

## Constraints

- Nothing is checked out, edited or committed before the report is assembled
  and the user has chosen per plugin.
- One commit per plugin. Readable history is the point of doing this one at a
  time.
- Follow the user's git conventions: plain commit messages, stage only what
  this update produced.
