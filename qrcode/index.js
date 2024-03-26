
let QRCode = require('qrcode');

let obj = QRCode.create('I am a pony!');

console.log(obj);

console.log(obj.segments);

console.log(obj.segments[0]);

QRCode.toString(obj.segments,{type:'terminal'}, function (err, url) {
  console.log(url)
})

QRCode.toString('I am a pony!',{type:'terminal'}, function (err, url) {
  console.log(url)
})