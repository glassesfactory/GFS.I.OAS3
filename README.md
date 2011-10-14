#塩 - GFS.I.OAS3

Connecting Socket.IO <--> AS3 Makes It Easy!

#How to use

It's simply.

var socket:GFSIOAS3 = new GFSIOAS3('127.0.0.1', 3000);
socket.addEventListener( GFSIOAS3Event.CONNECTED, _connectedHandler );
socket.connect();

#まだアルファもいいとこよ。
テストとかほとんどしてないよ。
バクアップ兼ねてうｐ。