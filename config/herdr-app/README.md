# herdr-app config

The personal layer of the Herdr desktop app (`~/.config/herdr-app`), symlinked
into place by `install.sh`:

- `keys.json` — all keybindings, including the `ctrl-k` prefix chords
  (`p` palette, `h/j/k/l` panes, `c/x` new/close tab, `s/u` settle/unsettle,
  `1..9` tab N).
- `settings.json` — fonts, zoom, telemetry.
- `themes/pixel.json` — the retro CRT palette.
- `layouts/pixel.json` + `pixel.svg` — the pixel layout and its Settings preview.
- `mods/pixel-*/` — 17 mods: clones of the shipped ones with square corners,
  plus `pixel-tabs` (settled-tab folding + jump-back popup), `pixel-palette`,
  `pixel-settings`, `pixel-menu` and the rest of the popup family, all drawing
  their own square frames with `frame: "none"`.

Everything else in `~/.config/herdr-app` (shipped mods and layouts, `frame/`,
`icons/`, `AGENTS.md`, the `.d.ts` files, `view.json`, `shared.json`,
`layouts/.state/`) is written by Herdr and deliberately untracked.

## Editing

- `keys.json`, `settings.json`, themes and the layout apply live while Herdr
  runs, and app writes (theme picker, zoom keys) land in this repo through the
  symlinks.
- Mod `main.js` edits do **not** hot-reload through the symlinked folders
  (Herdr's watcher does not follow symlinks). After editing a mod, cycle
  layouts once — `cmd-shift-l` twice — or restart Herdr, to reload mod copies.
- Run `herdr-app check ~/.config/herdr-app/mods/<name>` after mod changes, and
  watch `herdr-app status` for an empty `errors` list.
- The palette/settings copies come from Herdr's `frame/` screens; after a
  Herdr update, re-copy and re-square them if they drift.
