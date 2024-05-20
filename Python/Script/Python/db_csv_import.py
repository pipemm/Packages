
def db_initiation():
    from os      import environ, makedirs
    from os.path import isdir, isfile, realpath, join
    from sqlite3 import connect
    folder  = environ.get('TOOL_DATABASE_FOLDER','.')
    dbname  = environ.get('TOOL_DATABASE_FILE', 'data.db')
    if not isdir(folder):
        makedirs(folder)
    folder  = realpath(folder)
    db_path = join(folder, dbname)
    print(db_path)
    conn    = connect(db_path)

db_initiation()
