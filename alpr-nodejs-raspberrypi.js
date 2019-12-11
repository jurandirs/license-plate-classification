const PiCamera = require('pi-camera');

function getRandomInt(max) {
    return Math.floor(Math.random() * Math.floor(max));
}

setInterval(function() {

    var path = './' + getRandomInt(500) + '.jpg';

    const myCamera = new PiCamera({
        mode: 'photo',
        output: path,
        width: 1920,
        height: 1080,
        nopreview: false,
    });


    myCamera.snap()
        .then((result) => {

            var exec = require('child_process').exec;
            var cmd = 'alpr -c us -n 1 --json ' + path;

            exec(cmd, function(error, stdout, stderr) {

                var data = JSON.parse(stdout);

                if (data.results.length > 0) {
                    console.log(data.results[0].plate);
                } else {
                    console.log("\n\n\nNo license plate found.\n\n");
                }
            });

            console.log(result);

        })
        .catch((error) => {
            console.log(error);
        });

}, 2e3);