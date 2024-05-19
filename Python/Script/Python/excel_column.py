
def local_path_import():
    from os.path import realpath, dirname
    from sys     import path
    local_path = dirname(realpath(__file__))
    if local_path not in path:
        path.insert(0, local_path)
local_path_import()

from csv import DictWriter
from os  import write

from stdout import stdout

def int_to_letter(ii):
    if ii == -1:
        return ''
    elif 0 <= ii <= 25:
        base = ord('A')
        return chr(base + ii)
    else:
        return None

def get_letter(number):
    places   = [-1, -1, -1]
    pn       = 0
    overflow = 0
    while number > 0 and pn<3:
        number, place0 = divmod(number-1,26)
        places[pn]     = place0
        pn            +=1
    if pn >=3 and number > 0:
        overflow = number
    letter = ''.join([int_to_letter(place) for place in reversed(places)])
    return letter, overflow

def main():
    outfile = stdout

    fieldnames = ['Column_Number', 'Column_Letter']
    writer = DictWriter(outfile, fieldnames=fieldnames)

    writer.writeheader()
    for number in range(1,20000):
        row = {'Column_Number': number}
        letter, overflow = get_letter(number)
        if overflow != 0:
            break
        row['Column_Letter'] = letter
        writer.writerow(row)    

if __name__ == '__main__':
    main()
