# report.md — user's guide

## What it is

A plain-text, append-only log. Each session opens with a dated `arrived`
line and closes with a dated `left` line, both naming the machine. In
between are `label: HH:MM` lines as things happen (timers, syncs, finished
tasks from Vim).

    arrived Tellurium: 2026 Oct 17 (Sat) 18:26
    squirrel 480: 18:40
    * draft stats notes ✓ 19:05
    left Tellurium: 2026 Oct 17 (Sat) 22:10

Older entries use a `######## 2026 Oct 15 (Thu)` banner and a bare
`arrived: HH:MM` instead.

## Where it lives

The real file is `~/terminal/dirs/Planning/report.md`, tracked in the
Planning repo (github.com/dushoff/Planning).

* `.baliases` exports `$report` with that path. Every writer uses `$report`.
* `~/report.md` is a convenience symlink to the same file.
  `make replink` in Planning recreates it.
* The old copy in `~/screens/org/Planning/report.md` is no longer written to.

## How lines get in

All in `home/.baliases`. Each one runs `vsave` first, so Vim buffers
(including an open report.md) are saved before the shell appends.

| Command             | Writes                                 | Called by                 |
|---------------------|----------------------------------------|---------------------------|
| `reporttime LABEL`  | `LABEL: HH:MM`                         | most commands, or by hand |
| `reportstamp LABEL` | `LABEL Host: YYYY Mon DD (Day) HH:MM`  | `arrive`, `leave`         |
| `reportblank`       | an empty line                          | `arrive`                  |

(`rtoday` and `reportday`, which wrote the old banner, are still defined
but nothing calls them.)

Commands that already log:

* `arrive`: after `make arrive` succeeds, writes a blank line and
  `reportstamp arrived`. That happens *after* the pull, so the new line
  can't conflict with what's coming down.
* `leave` (via `doleave`): writes `reportstamp left` *before* `leavesync`.
  The leave sync commits and pushes Planning, so the stamp goes up with it
  and doesn't sit uncommitted until the next machine pulls. The earlier
  checks in `leave` (open `dictate.txt`, raise gvim) run before this. If
  they stop the leave, nothing is written.
* `work`: `reporttime Work`
* `squirrel N` / `beaver N`: `reporttime "squirrel N"`, then show an alert after N seconds
* `sink`: `reporttime sunk`. `sunk`: `reporttime "sunk <dir> from <host>"`
* `sinklake`: `reporttime Sunk`

To log something by hand: `reporttime "lunch"`.

### From Vim (the Planning session)

The `.vimrc.focal` maps send the current line to the end of report.md as a
time-stamped bullet, then delete it from wherever you are (usually index.mkd):

| Map        | Report line              | Then                    |
|------------|--------------------------|-------------------------|
| `@k`       | `* task HH:MM`           | keeps the line          |
| `@c`       | `* task … HH:MM`         | keeps the line          |
| `@K`       | `* task ✓ HH:MM`         | deletes it (finished)   |
| `@n`       | `* task • HH:MM`         | deletes it (null task)  |
| `1C`–`7C`  | like `@k`                | moves it to that weekday |
| `<C-V>`    | the whole ¶              | deletes it              |

How it works: each map ends `V@k`. `vmap @k` in `.vimrc.personal` cuts the
selection and calls `@r` (`grGp:w<C-^>`). `gr` (`nn gr 7<C-^>`) jumps to
buffer 7, pastes at the end, saves, and comes back.

**Buffer 7 has to be report.md.** `make vim_session` in Planning opens
Makefile, target.mk, org.mkd, index.mkd, dump.md, notebook.md, report.md,
journal.md, which makes report.md buffer 7. If you change that list, keep
report.md seventh (or change `nn gr` in `.vimrc.personal` to match).

When you edit report.md directly, `<C-T>` (normal mode) puts the
current `HH:MM` on a new line.

## How it gets tracked

`planup` runs `upsync`, which runs `make report.autoup commit.time` in
Planning. That does `git add -f` and commits the changed Sources, using the
message `report`, then runs `git push` (and the rclone `mirrorPut`).
`sink` calls `planup` (through `sinkcheck`), and so does `sinklake`.

`plandown` (`make pullup`) pulls. If report.md conflicts because two machines
both appended, `make noreport` in Planning takes the remote version.
