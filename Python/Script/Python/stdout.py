
## from sys import stdout
from os  import write

class Stdout:
    def write(self, text):
        text_bytes = text.encode()
        write(1, text_bytes)

stdout = Stdout()
