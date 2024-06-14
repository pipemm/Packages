


from sys     import stdin
from xml.sax import make_parser, ContentHandler

PATH_OF_DEPENDENCY = 'project/dependencies/dependency'
PATH_IN_DEPENDENCY = PATH_OF_DEPENDENCY +'/'

class POMHandler(ContentHandler):

    def __init__(self):
        self.currentTag = ''
        self.path       = []
        ##########
        self.data =''
        self._cleanRecord()
    
    def _cleanRecord(self):
        self.groupId    = None
        self.artifactId = None
        self.version    = None
        self.scope      = None
        self.optional   = None
    
    def _print(self):
        if self.scope != 'compile':
            return
        if self.optional is not None and self.optional.lower() == 'true':
            return
        print( '/'.join([self.groupId.replace('.','/'), self.artifactId, self.version, self.artifactId+'-'+self.version+'.jar']) )

    def startElement(self, name, attrs):
        self.currentTag = name
        self.path.append(name)
        full_path = '/'.join(self.path)
        self.data = ''
        ##########
    
    def endElement(self, name):
        full_path = '/'.join(self.path)
        if   full_path == PATH_OF_DEPENDENCY:
            self._print()
            self._cleanRecord()
        elif full_path == PATH_IN_DEPENDENCY + 'groupId':
            self.groupId    = self.data
        elif full_path == PATH_IN_DEPENDENCY + 'artifactId':
            self.artifactId = self.data
        elif full_path == PATH_IN_DEPENDENCY + 'version':
            self.version    = self.data
        elif full_path == PATH_IN_DEPENDENCY + 'scope':
            self.scope      = self.data
        elif full_path == PATH_IN_DEPENDENCY + 'optional':
            self.optional   = self.data
        ##########
        if len(self.path) > 0 and self.path[-1] == name:
            self.path.pop()
        self.currentTag = ''
        self.data       = ''
    
    def characters(self, content):
        self.data += content


parser  = make_parser()
handler = POMHandler()
parser.setContentHandler(handler)

def main():

    infile = stdin
    try:
        parser.parse(infile)
    except ValueError as e:
        raise SystemExit(e)


if __name__ == '__main__':
    try:
        main()
    except BrokenPipeError as exc:
        sys.exit(exc.errno)
