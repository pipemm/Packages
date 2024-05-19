
from csv import DictWriter

from sys import stdout
from os  import write

class Stdout:
    def write(self, text):
        text_bytes = text.encode()
        write(1, text_bytes)

def main():
    outfile = Stdout()

    fieldnames = ['first_name', 'last_name']
    writer = DictWriter(outfile, fieldnames=fieldnames)

    writer.writeheader()
    writer.writerow({'first_name': 'Baked',     'last_name': 'Beans'})
    writer.writerow({'first_name': 'Lovely',    'last_name': 'Spam'})
    writer.writerow({'first_name': 'Wonderful', 'last_name': 'Spam'})

if __name__ == '__main__':
    main()
