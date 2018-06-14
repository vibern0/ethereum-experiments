const bodyParser = require('body-parser')
var path = require('path');
var fs = require('fs');
const express = require('express')
const app = express()
app.set('view engine', 'pug')
app.set('views', path.join(__dirname, './views'));
var Web3 = require('web3');

app.use(bodyParser.json())
app.use(bodyParser.urlencoded({ extended: true }))

if (typeof web3 !== 'undefined') {
    web3 = new Web3(web3.currentProvider);
} else {
    web3 = new Web3(new Web3.providers.HttpProvider("http://localhost:7545"));
}

var abiArray = JSON.parse(fs.readFileSync(path.resolve(__dirname, './contract.json'), 'utf-8'));
var contractAddress = "0x9a0f2a2de837a26507ee311bc550240a83b2342e";
var myAccount = "0xF020592644f9B480FfDa2fdD991A04fa745ABcb3";
var contract = new web3.eth.Contract(abiArray, contractAddress);


app.get('/', (req, res) => {

    var brand = ['mercedes','renault','citroen'];
    var resultToSend = '';
    var n = 0;
    contract.methods.getTotalCars().call().then((receipt) => {
        if(receipt == 0) {
            res.render('index', {carsFromBE: []});
        }
        else {
            for(var i = 0; i < receipt; i++) {
                contract.methods.getCar(i).call().then((success, error) => {
                    //console.log("{model:" + success[0] + ", id:" + n + "}");
                    resultToSend += JSON.stringify({model: brand[success[0]], id: n});
                    n++;
                    if(n == receipt) {
                        res.render('index',
                            {carsFromBE: JSON.parse("[" + resultToSend + "]")});
                    } else {
                        resultToSend += ',';
                    }
                });
            }
        }
    });


})

app.get('/car/:id', (req, res) => {
    var carId = req.params.id;
    //
    contract.methods.getCar(carId).call().then((result) => {
        res.send(result);
    });
})

app.post('/publish', (req, res) => {
    var brand = parseInt(req.body.brand);
    var price = parseInt(req.body.price);
    //
    contract.methods.publishNewCar(brand, price).send({from: myAccount})
    .on('receipt', (receipt) => {
        console.log('receipt ' + receipt);
        res.render('index', {carsFromBE: []});
    })
    .on('error', (err) => {
        console.log('error ' + err);
        res.render('index', {carsFromBE: []});
    });
})

app.post('/buy', (req, res) => {
    var carId = req.body.id;
    //
    contract.methods.buyCar(carId).send({from: myAccount})
    .on('receipt', (receipt) => {
        console.log('receipt ' + receipt);
        res.render('index', {carsFromBE: []});
    })
    .on('error', (err) => {
        console.log('error ' + err);
        res.render('index', {carsFromBE: []});
    });
})

app.listen(3000, () => console.log('Example app listening on port 3000!'))