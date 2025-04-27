
const stdin = process.stdin;
const argv  = process.argv;
const vm    = require('node:vm');

let data = '';
let vari = null;
if (argv.length > 2) {
    vari = argv[2]
}

process.stdin.on('data', (chunk) => {
    data += chunk;
});

process.stdin.on('end', () => {
    const context = {};
    vm.createContext(context);
    vm.runInContext(data,context);
    let output = context;
    if ( vari !== null && vari in context ) {
        output = context[vari];
    }
    console.log(JSON.stringify(output));
});
