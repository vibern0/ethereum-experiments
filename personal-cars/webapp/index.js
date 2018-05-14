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
var contractAddress = "0x9E4555ae3ae9BE6953507D91f94033783D7c992c";


app.get('/usercar/:useraddress/:index', (req, res) => {
    var contract = new web3.eth.Contract(abiArray, contractAddress);
    contract.methods.getUserCar(req.params.useraddress, req.params.index).call().then((receipt) => {
        res.render('usercar', { carname: receipt })
    });
})

app.get('/add/:useraddress/:carname', (req, res) => {
    var contract = new web3.eth.Contract(abiArray, contractAddress);
    contract.methods.addUserCar(req.params.carname).send({from: req.params.useraddress}).then((receipt) => {
        res.send(receipt)
    });
})

app.listen(3000, () => console.log('Example app listening on port 3000!'))