#!/usr/bin/env node

var rfxcom = require("rfxcom"),
    eyes = require('eyes'),
    mqtt = require('mqtt');

var rfxtrx = new rfxcom.RfxCom("/dev/ttyUSB0", {debug: false} );
var client = mqtt.createClient('1883', 'localhost');

client.on('connect', function() {
  console.log('Connected for publications...');
});

// Start RFXCom activity
rfxtrx.on("th2", function (evt) {
    /*
    console.log("Device info : SubType=" + evt.subtype);
    console.log("                   id=" + evt.id + "=" + parseInt(evt.id,16));
    console.log("               seqnbr=" + evt.seqnbr);
    console.log("          temperature=" + evt.temperature + "°C");
    console.log("             humidity=" + evt.humidity + "%");
    console.log("       humidityStatus=" + evt.humidityStatus);
    console.log("         batteryLevel=" + evt.batteryLevel);
    console.log("                 rssi=" + evt.rssi);
    */
    var now = new Date();
    console.log(now.toISOString() + ' sensors/' + parseInt(evt.id,16) + '/entries/1/events/temperature = ' + evt.temperature);
    console.log(now.toISOString() + ' sensors/' + parseInt(evt.id,16) + '/entries/2/events/humidity = ' + evt.humidity);
    client.publish('sensors/' + parseInt(evt.id,16) + '/entries/1/events/temperature', '' + evt.temperature);
    client.publish('sensors/' + parseInt(evt.id,16) + '/entries/1/events/humidity', '' + evt.humidity);
});

rfxtrx.on("temp2", function (evt) {
    /*
    console.log("Device info : SubType=" + evt.subtype);
    console.log("                   id=" + evt.id + "=" + parseInt(evt.id,16));
    console.log("               seqnbr=" + evt.seqnbr);
    console.log("          temperature=" + evt.temperature + "°C");
    console.log("             humidity=" + evt.humidity + "%");
    console.log("       humidityStatus=" + evt.humidityStatus);
    console.log("         batteryLevel=" + evt.batteryLevel);
    console.log("                 rssi=" + evt.rssi);
    */
    var now = new Date();
    console.log(now.toISOString() + ' sensors/' + parseInt(evt.id,16) + '/entries/1/events/temperature = ' + evt.temperature);
    client.publish('sensors/' + parseInt(evt.id,16) + '/entries/1/events/temperature', '' + evt.temperature);
});

rfxtrx.on("rain2", function (evt) {
    /* 
    console.log("Device info : SubType=" + evt.subtype);
    console.log("                   id=" + evt.id + "=" + parseInt(evt.id,16));
    console.log("               seqnbr=" + evt.seqnbr);
    console.log("             rainrate=" + evt.rainrate + " mm/h");
    console.log("            raintotal=" + evt.raintotal + " mm");
    console.log("         batteryLevel=" + evt.batteryLevel);
    console.log("                 rssi=" + evt.rssi);
    */
    var now = new Date();
    var value = { rainrate: evt.rainrate, raintotal: evt.raintotal };
    console.log(now.toISOString() + ' sensors/' + parseInt(evt.id,16) + '/entries/1/events/rain = ' + JSON.stringify(value));
    client.publish('sensors/' + parseInt(evt.id,16) + '/entries/1/events/rain', JSON.stringify(value));
});


rfxtrx.initialise(function () {
    console.log("Device initialized");
});
