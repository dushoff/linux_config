`workspace back_and_forth`

wofi

swayr

How do I go to a terminal in the current workspace?

How do I control which screen instance gets my screen select command?

How do I set up the clipboard? 

How do I deal with rows in vim? Why are they acting weird now?

How do I navigate to and from floating windows?

bindsym $mod+1 workspace "1:web" does anything different??

Why should I prefer firefox vs. chrome

----------------------------------------------------------------------

swaymsg -t get_tree


How do I bind to a bash alias that I have set up? How do I bind to a script?

tridactyl is fancier than vimium-ff

---

## Running Commands

Three equivalent ways to run any Sway command:

* Immediately: `swaymsg <command>`
* Via keybinding: `bindsym … <command>`
* On startup/reload: `exec <command>`

The command language is the same in all cases.

---

## Marks

* Marks attach to containers, not workspaces.
* Marks move with containers across workspaces.
* Focusing a mark switches to the workspace automatically.
* Marks are global and unique by default.

Marks are best used for **semantic navigation**:

* editor
* browser‑docs
* terminal

---

## Finding Windows (esp. Browsers)

Sway cannot see tabs — only windows.

Best patterns:

1. Marks for stable, semantic windows
2. Window switchers (`wofi --show window`, `swayr`)
3. Workspace‑per‑task organization

---

## "Alt‑Tab" in Sway

Alt‑Tab meaning is ambiguous; Sway makes you choose explicitly.

Common mappings:

* Toggle last workspace:
* Cycle focus history:
  `focus prev`
* Visual chooser:
  `wofi --show window`

Many users keep **two bindings**: fast toggle + chooser fallback.

---

## Terminals and Context

There is no built‑in notion of "related window".

Best approximation:

```conf
bindsym $mod+t   [workspace=__focused__ app_id="foot"] focus;   [app_id="foot"] focus;   exec foot
```

This implements:

1. Focus terminal on current workspace
2. Else focus any terminal
3. Else create one

No `or` is required — criteria that match nothing are no‑ops.

---

## Vim + Terminal Resizing

* `&columns` is controlled by the terminal emulator.
* Vim must always reflect the real terminal width.
* There is no way to cap `&columns` itself.

Correct abstraction: **fixed‑width editing windows inside Vim**.

```vim
vsplit
setlocal winfixwidth
vertical resize 72
```

Properties:

* Shrinks if terminal gets narrower
* Does **not** automatically grow again
* Preserves visual wrapping correctness

Elastic‑up‑to‑a‑cap behavior requires explicit `VimResized` logic.

---

## Soft Width Limits in Vim

`colorcolumn` cannot draw outside the visible window.

Correct solution for soft limits:

```vim
match OverLength /\%>72v.\+/
highlight OverLength ctermbg=236
```

This highlights text past the column regardless of window width and works with wrapping.

---

## Clipboard Under Wayland

Requirements:

* Vim compiled with `+clipboard`
* `wl-clipboard`
* Clipboard manager (e.g. `clipman`)
* `set clipboard=unnamedplus`

Example:

```conf
exec_always clipman store
```

Wayland clipboard data only exists while a provider is alive unless persisted.

---

## `gx` (netrw) Blocking Vim

Cause:

* GNOME used a session manager that daemonized `gio open`.
* Sway does not.

Fix:

```vim
let g:netrw_browsex_viewer = 'gio open &'
```

This restores non‑blocking behavior.

---

## Default Applications (`gio open`)

Unexpected apps opening files means bad MIME defaults.

Fix with `xdg-mime`:

```sh
xdg-mime default imv.desktop image/jpeg image/png
xdg-mime default org.gnome.Evince.desktop application/pdf
xdg-mime default firefox.desktop x-scheme-handler/http x-scheme-handler/https
```

After this, `gio open` becomes sane again.

---

## Media / Volume Keys

Normal that they stop working under Sway.

GNOME handled them via daemons; Sway requires explicit bindings.

Example (PipeWire):

```conf
bindsym XF86AudioRaiseVolume exec wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+
bindsym XF86AudioLowerVolume exec wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-
bindsym XF86AudioMute exec wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle
```

---

## Vim Syntax Highlighting for Sway Configs

Highlighting is based on filename patterns, not symlinks.

Sway/i3 configs use `filetype=i3config`.

Example fix:

```vim
autocmd BufRead,BufNewFile ~/.config/sway/includes/* set filetype=i3config
```

---

## Moving Containers

* Commands always act on the **focused container**.
* To move a group, focus the parent container first.
* Marks avoid focus ambiguity entirely.

Move without following:

```conf
bindsym $mod+Shift+1 move container to workspace 1
```

Move and follow:

```conf
bindsym $mod+Shift+1 move container to workspace 1; workspace 1
```

---

## Design Philosophy Takeaway

* No hidden heuristics
* No guessing intent
* Explicit structure + explicit policy
* Calm, deterministic behavior once configured

---
