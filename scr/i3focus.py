#!/usr/bin/env python3
import i3ipc

i3 = i3ipc.Connection()
stack = []  # index 0 = most recent focus

def on_focus(i3conn, event):
	wid = event.container.id
	if wid in stack:
		stack.remove(wid)
	stack.insert(0, wid)

def on_close(i3conn, event):
	wid = event.container.id
	if wid in stack:
		stack.remove(wid)

def focus_by_id(wid):
	con = i3.get_tree().find_by_id(wid)
	if con:
		con.command("focus")

def on_binding(i3conn, event):
	cmd = event.binding.command
	if cmd == "nop focus-swap":
		if len(stack) >= 2:
			focus_by_id(stack[1])
	elif cmd == "nop focus-bury":
		if len(stack) >= 2:
			top = stack.pop(0)
			stack.append(top)
			focus_by_id(stack[0])
	elif cmd == "nop focus-dig":
		if len(stack) >= 2:
			bottom = stack.pop()
			stack.insert(0, bottom)
			focus_by_id(stack[0])

i3.on("window::focus", on_focus)
i3.on("window::close", on_close)
i3.on("binding", on_binding)
i3.main()
