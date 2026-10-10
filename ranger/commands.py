# This is a sample commands.py.  You can add your own commands here.
#
# Please refer to commands_full.py for all the default commands and a complete
# documentation.  Do NOT add them all here, or you may end up with defunct
# commands when upgrading ranger.

from __future__ import (absolute_import, division, print_function)

# You can import any python module as needed.
import os
import subprocess
import json
from datetime import datetime

# You always need to import ranger.api.commands here to get the Command class:
from ranger.api.commands import Command

# Undo log file
UNDO_LOG = os.path.expanduser("~/.config/ranger/undo_log.json")

def load_undo_log():
    """Load the undo log from file"""
    if os.path.exists(UNDO_LOG):
        try:
            with open(UNDO_LOG, 'r') as f:
                return json.load(f)
        except:
            return []
    return []

def save_undo_log(log):
    """Save the undo log to file"""
    with open(UNDO_LOG, 'w') as f:
        json.dump(log, f, indent=2)

def add_undo_operation(operation_type, source, destination=None):
    """Add an operation to the undo log"""
    log = load_undo_log()
    operation = {
        'type': operation_type,
        'source': source,
        'destination': destination,
        'timestamp': datetime.now().isoformat()
    }
    log.append(operation)
    save_undo_log(log)


# Undo command - undo the last file operation
class undo(Command):
    """:undo

    Undo the last file operation (move, copy, delete, etc.)
    """
    def execute(self):
        log = load_undo_log()
        if not log:
            self.fm.notify("No operations to undo", bad=True)
            return

        last_op = log.pop()
        save_undo_log(log)

        try:
            if last_op['type'] == 'move':
                # Undo move: move back to original location
                if os.path.exists(last_op['destination']):
                    subprocess.run(['mv', last_op['destination'], last_op['source']])
                    self.fm.notify(f"Undid move: {last_op['destination']} -> {last_op['source']}")
                else:
                    self.fm.notify(f"Source file not found: {last_op['destination']}", bad=True)

            elif last_op['type'] == 'copy':
                # Undo copy: delete the copied file
                if os.path.exists(last_op['destination']):
                    subprocess.run(['rm', '-rf', last_op['destination']])
                    self.fm.notify(f"Undid copy: deleted {last_op['destination']}")
                else:
                    self.fm.notify(f"File not found: {last_op['destination']}", bad=True)

            elif last_op['type'] == 'delete':
                # Undo delete: restore from trash
                subprocess.run(['trash-restore', last_op['source']])
                self.fm.notify(f"Undid delete: restored {last_op['source']}")

            self.fm.thisdir.load_content(schedule=True)

        except Exception as e:
            self.fm.notify(f"Failed to undo: {str(e)}", bad=True)


# Show undo history
class undo_history(Command):
    """:undo_history

    Show the undo history
    """
    def execute(self):
        log = load_undo_log()
        if not log:
            self.fm.notify("No operations in history")
            return

        history = "Undo History (most recent last):\n"
        for i, op in enumerate(reversed(log)):
            history += f"{i+1}. {op['type']}: {op['source']}"
            if op['destination']:
                history += f" -> {op['destination']}"
            history += f" ({op['timestamp']})\n"

        self.fm.notify(history)


# Clear undo history
class clear_undo_history(Command):
    """:clear_undo_history

    Clear the undo history
    """
    def execute(self):
        save_undo_log([])
        self.fm.notify("Undo history cleared")


# Enhanced move command that tracks for undo
class move_track(Command):
    """:move_track

    Move files and track for undo
    """
    def execute(self):
        import subprocess
        if not self.fm.thisdir.marked_items:
            if self.fm.thisfile:
                source = self.fm.thisfile.path
                dest = self.rest(1)
                if dest:
                    subprocess.run(['mv', source, dest])
                    add_undo_operation('move', source, dest)
                    self.fm.notify(f"Moved {source} to {dest}")
        else:
            for f in self.fm.thisdir.marked_items:
                dest = self.rest(1)
                if dest:
                    subprocess.run(['mv', f.path, dest])
                    add_undo_operation('move', f.path, dest)
            self.fm.notify(f"Moved {len(self.fm.thisdir.marked_items)} files")
        self.fm.thisdir.mark_all(False)


# Enhanced copy command that tracks for undo
class copy_track(Command):
    """:copy_track

    Copy files and track for undo
    """
    def execute(self):
        import subprocess
        if not self.fm.thisdir.marked_items:
            if self.fm.thisfile:
                source = self.fm.thisfile.path
                dest = self.rest(1)
                if dest:
                    subprocess.run(['cp', '-r', source, dest])
                    add_undo_operation('copy', source, dest)
                    self.fm.notify(f"Copied {source} to {dest}")
        else:
            for f in self.fm.thisdir.marked_items:
                dest = self.rest(1)
                if dest:
                    subprocess.run(['cp', '-r', f.path, dest])
                    add_undo_operation('copy', f.path, dest)
            self.fm.notify(f"Copied {len(self.fm.thisdir.marked_items)} files")
        self.fm.thisdir.mark_all(False)
    # The so-called doc-string of the class will be visible in the built-in
    # help that is accessible by typing "?c" inside ranger.
    """:my_edit <filename>

    A sample command for demonstration purposes that opens a file in an editor.
    """

    # The execute method is called when you run this command in ranger.
    def execute(self):
        # self.arg(1) is the first (space-separated) argument to the function.
        # This way you can write ":my_edit somefilename<ENTER>".
        if self.arg(1):
            # self.rest(1) contains self.arg(1) and everything that follows
            target_filename = self.rest(1)
        else:
            # self.fm is a ranger.core.filemanager.FileManager object and gives
            # you access to internals of ranger.
            # self.fm.thisfile is a ranger.container.file.File object and is a
            # reference to the currently selected file.
            target_filename = self.fm.thisfile.path

        # This is a generic function to print text in ranger.
        self.fm.notify("Let's edit the file " + target_filename + "!")

        # Using bad=True in fm.notify allows you to print error messages:
        if not os.path.exists(target_filename):
            self.fm.notify("The given file does not exist!", bad=True)
            return

        # This executes a function from ranger.core.acitons, a module with a
        # variety of subroutines that can help you construct commands.
        # Check out the source, or run "pydoc ranger.core.actions" for a list.
        self.fm.edit_file(target_filename)

    # The tab method is called when you press tab, and should return a list of
    # suggestions that the user will tab through.
    # tabnum is 1 for <TAB> and -1 for <S-TAB> by default
    def tab(self, tabnum):
        # This is a generic tab-completion function that iterates through the
        # content of the current directory.
        return self._tab_directory_content()
