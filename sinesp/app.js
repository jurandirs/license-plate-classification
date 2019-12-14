const express = require('express');
const app = express();
const PORT = process.env.PORT || 5000;
const telegraToken = '715749096:AAEnlGKIjCfU8mKZd7ILNp2PUQC8vyNfEu8';
const TelegramBot = require('node-telegram-bot-api');
const bot = new TelegramBot(telegraToken, {polling: true});
const placaOld = new RegExp("[a-zA-Z]{3}[0-9]{4}");
const placaMercosul = new RegExp("[a-zA-Z]{3}[0-9]{1}[a-zA-Z]{1}[0-9]{2}");

let chatIds = [];

app.get('/placa/:placa', function (req, res) {
    // console.log(req.params.placa);
    // res.send('hello world')
    res.json(verificaPlaca(req.params.placa));
});


function verificaPlaca(placa) {

    try {
        if (placaOld.test(placa) || placaMercosul.test(placa)) {
            if(numeroRandom() == 0) {
                notificaSituacao(`Placa ${placa} - ok`);
                return {situacao: 'Sem restrição'}
            } else {
                notificaSituacao(`Placa ${placa} - !!! FURTO !!!`);
                return {situacao: 'Furto'}
            }
        } else {
            notificaSituacao('Não foi possível ler a placa!');
            return {result: 'Placa inválida'}
        }
    } catch (err) {
        console.log(err);
    }
}

function numeroRandom() {
    return Math.floor(Math.random() * Math.floor(2));
}

function notificaSituacao(msg) {
    chatIds.forEach(function(chat) {
        bot.sendMessage(chat, msg);
    });
}

bot.on('message', (msg) => {
    const chatId = msg.chat.id;
    chatIds.push(chatId);
    bot.sendMessage(chatId, 'Cadastrei você!');
});

// console.log(verificaPlaca('AASD1C22'));
app.listen(PORT, () => console.log(`Listening on ${ PORT }`));