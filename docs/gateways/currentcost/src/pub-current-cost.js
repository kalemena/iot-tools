#!/usr/bin/env node

var com = require("serialport"),
    eyes = require('eyes'),
    mqtt = require('mqtt'),
    xml2js = require('xml2js');

var argv = process.argv;
for (var i = 2; i <= 4; i++) {
  if(!argv[i]) process.exit(-1);
}

var mqttport = argv[2]
  , mqtthost = argv[3]
  , usbResource = argv[4];
    
var client = mqtt.createClient(mqttport, mqtthost);
var serialPort = new com.SerialPort(usbResource, {
    baudrate: 57600,
    parser: com.parsers.readline('\r\n')
  });
var parser = new xml2js.Parser();

client.on('connect', function() {
  console.log('connected for publications...');
});

serialPort.on('open',function() {
  console.log('serial port open...');
});

serialPort.on('data', function(data) {
  parser.parseString(data, function(err, result) {
    if(err) {
      console.log('error:' + data);
    } else {

      var now = new Date();

      // temperature & real-time data
      if(result.msg.tmpr) {
        if(result.msg.id == '02431') {
          console.log(now.toISOString() + ' sensors/' + result.msg.id[0] + '/entries/' + result.msg.sensor[0] + '/events/temperature', result.msg.tmpr[0]$
          client.publish('sensors/' + result.msg.id[0] + '/entries/' + result.msg.sensor[0] + '/events/temperature', result.msg.tmpr[0]);
        }
        
        // real-time
        console.log(now.toISOString() + ' sensors/' + result.msg.id[0] + '/entries/' + result.msg.sensor[0] + '/events/power', result.msg.ch1[0].watts[0]$
        client.publish('sensors/' + result.msg.id[0] + '/entries/' + result.msg.sensor[0] + '/events/power', result.msg.ch1[0].watts[0]);
      } else {
        // historical data

        var ts = new Date();
        ts = new Date(ts.getTime() + 60*30*1000);
        var ts_str = ts.toISOString().substr(0,13);

        for(i in result.msg.hist[0].data) {
          var chunk = result.msg.hist[0].data[i];
          var chunkClean = {};
          for (var j in chunk) {
            chunkClean[j] = chunk[j][0];
          }
          console.log(now.toISOString() + ' ' + JSON.stringify(chunkClean));
          client.publish('sensors/02431/entries/' + chunk.sensor[0] + '/history/power', JSON.stringify(chunkClean));
        }

        // eyes.inspect(result);
        // client.publish('sensors/' + result.msg.id[0] + '/3/kwh', JSON.stringify(result));
      }
      // console.log('info:' + JSON.stringify(result));
    }
  });
});

// client.end();