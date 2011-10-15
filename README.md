#塩 - GFS.I.OAS3

**Connecting Socket.IO <--> AS3 Makes It Easy!**  

I'm respect...  
<http://www.isosio.com/>

#use Example

<http://node.hageyama.info/sio.html>

#what is this?
  
Socket.IO client の wrapper ライブラリです。  
Socket.IO client ライブラリを介すことで、  
Flash からでも簡単に WebSocket での通信ができるようになります。

#It's alpha version!

**Current version:0.1**  

とりあえず僕自身が仕事で必要 + α ぐらいで書いたライブラリです。  
出来る限り Socket.IO の仕様変更などには追従していきたいと思います。  
僕自身 Socket.IO はまだ手探り状態です。
  
この機能が欲しい、この使い勝手を変えて欲しい、この使い方をしたときバグが出る  
などありましたら要望、報告等いただけると嬉しいです。

#How to use

It's a simply.  

**Basic usage:**  

```as3
var socket:GFSIOAS3 = new GFSIOAS3( '127.0.0.1', 3000 );
socket.addEventListener( GFSIOAS3Event.CONNECTED, function(event:GFSIOAS3Event){
	trace("Connect");
	
	//Socket.IO サーバーからエミットされるイベントを登録します。
	socket.addEvent( 'listen eventname' );
	
	//Scoket.IO サーバーからのイベントを受信します。
	socket.addEventListener( GFSIOAS3Event.PROGRESS, _progressHandler );
	
	//Socket.IO サーバーにメッセージを送信します。
	socket.emit( 'send eventname', {'some':data });
	
	//WebScoket のセマンティクスを用いてメッセージの送信も出来ます。
	socket.send( 'msg' )
	
	//Socket.IO サーバーとの接続を切断します。
	socket.disconnect();
});
socket.connect();
```
  
**use Socket.IO NameSpcae:**  

```as3
_chat = new GFSIOAS3( '127.0.0.1', 3000, '/chat' );
_chat.addEventListener( GFSIOAS3Event.CONNECTED, _chatConnectedHandler );
			
_news = new GFSIOAS3( '127.0.0.1', 3000, '/news' );
_news.addEventListener( GFSIOAS3Event.CONNECTED, _newsConnectedHandler );			

_chat.connect();
_news.connect();
```

#Options

**use custom Socket.IO clinet js:**  

```as3
GFSIOAS3.socketIOClientURL = 'another/socket.io/socket.io.js';
```

デフォルトでは /socket.io/socket.io.js が指定されますが  
自身で Socket.IO client js の URL を指定することも出来ます。
  
  
**use manual put Socket.IO client js:**  

```as3
GFSIOAS3.useManualClient = true;
```

デフォルトでは Socket.IO client js は GFS.I.OAS3 によって動的に HTML に埋めこまれますが  
上記のオプションを有効化することで、自身で HTML に設定することが出来ます。  
  
また同様に、 GFSIOAS3.useLibOnHTML を設定することにより  
GFS.I.OAS3.js を HTML に自身で埋め込むことができます。  

その場合、 GFS.I.OAS3.js は socket.io.js に依存しますので  
読み込み順を必ず socket.io.js → GFS.I.OAS3.js としてください。


#other APIs

See: <http://glasses-factory.net/lab/gfsioas3/asdoc/>
