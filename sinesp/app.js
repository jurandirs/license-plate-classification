const express = require('express');
const app = express();

const placaOld = new RegExp("[a-zA-Z]{3}[0-9]{4}");
const placaMercosul = new RegExp("[a-zA-Z]{3}[0-9]{1}[a-zA-Z]{1}[0-9]{2}");

app.get('/placa/:placa', function (req, res) {
    // console.log(req.params.placa);
    // res.send('hello world')
    res.json(verificaPlaca(req.params.placa));
});


function verificaPlaca(placa) {

    try {
        if (placaOld.test(placa) || placaMercosul.test(placa)) {
            if(getRandomInt() == 0) {
                return {situacao: 'Sem restrição'}
            } else {
                return {situacao: 'Furto'}
            }
        } else {
            return {result: 'Placa inválida'}
        }
    } catch (err) {
        console.log(err);
    }
}

function getRandomInt() {
    return Math.floor(Math.random() * Math.floor(2));
}

// console.log(verificaPlaca('AASD1C22'));
app.listen(80);