
def local_path_import():
    from os.path import realpath, dirname
    from sys     import path
    local_path = dirname(realpath(__file__))
    if local_path not in path:
        path.insert(0, local_path)
local_path_import()

from csv import DictWriter

from stdout import stdout
from os     import write

def main():
    outfile = stdout

    fieldnames = ['first_name', 'last_name']
    writer = DictWriter(outfile, fieldnames=fieldnames)

    writer.writeheader()
    writer.writerow({'first_name': 'Baked',     'last_name': 'Beans'})
    writer.writerow({'first_name': 'Lovely',    'last_name': 'Spam'})
    writer.writerow({'first_name': 'Wonderful', 'last_name': 'Spam'})

if __name__ == '__main__':
    main()
