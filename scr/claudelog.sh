#!/bin/bash
## Render the most recently active claude session transcript as text and open it in vim
## In vim, :R re-renders (to catch up with a running session)
## Usage: claudelog.sh [--render] [dir]
## Uses the newest session for dir (default: current directory), else the newest overall

[ "$1" = --render ] && { mode=render; shift; }
dir=${1:-$PWD}
proj=$(echo "$dir" | sed 's/[^A-Za-z0-9]/-/g')
out=/tmp/claude-session$proj.txt

render() {
	f=$(ls -t ~/.claude/projects/"$proj"/*.jsonl 2>/dev/null | head -1)
	[ -z "$f" ] && f=$(ls -t ~/.claude/projects/*/*.jsonl | head -1)
	jq -r '
		def clip: if length > 1500 then .[0:1500] + "\n  [... clipped]" else . end;
		select(.type == "user" or .type == "assistant")
		| .type as $who
		| .message.content
		| if type == "string" then "\n## USER\n\n" + .
		else .[] |
			if .type == "text" then "\n## " + ($who | ascii_upcase) + "\n\n" + .text
			elif .type == "tool_use" then "\n>> " + .name + ": "
				+ (.input.description // "") + "\n"
				+ ((.input.command // .input.file_path // (.input | tostring)) | clip)
			elif .type == "tool_result" then
				"<< " + ((.content | if type == "array" then map(.text // "") | join("\n") else tostring end) | clip)
			else empty end
		end
	' "$f" > $out
}

render
[ "$mode" = render ] && exit
export CLAUDELOG_DIR=$dir
exec vim -n --cmd 'set nomodeline' -c "command! R call system('$0 --render ' . shellescape(\$CLAUDELOG_DIR)) | edit! | setlocal wrap | \$" -c 'setlocal wrap' + "$out"
