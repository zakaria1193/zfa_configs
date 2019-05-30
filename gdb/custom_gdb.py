from gdb.printing import PrettyPrinter, register_pretty_printer
import gdb


class tic_buffer_pretty_printer:
    def __init__(self, val):
        self.val = val

    def to_string(self):
        return 'caca'
