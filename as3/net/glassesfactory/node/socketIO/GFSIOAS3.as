/*////////////////////////////////////////////

SocketIOTest

Autor	glassesfactory
Date	2011/10/06

Copyright 2011 glasses factory
http://glasses-factory.net

/*////////////////////////////////////////////

package net.glassesfactory.node.socketIO
{
	import flash.display.Shape;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.external.ExternalInterface;
	import flash.utils.Dictionary;
	
	public class GFSIOAS3 {
		
		/**
		 * GFSIOAS3 の現在のバージョン番号 
		 */		
		public static const VERSION:String = "0.05";
		
		private static const DOCUMENT_WRITER:String = "function(url){var js=document.createElement('script');js.type='text/javascript';js.src=url;document.getElementsByTagName('head')[0].appendChild(js);}";
		private static const SOCKET_LIB:String = 'function(){var GFSIOAS3=window.GFSIOAS3=function(swfID){this.swfID=swfID;this.sockets={};this.hosts={};this.listeners={}};GFSIOAS3.prototype.createSocket=function(ns,host,socketPort,connectFunc){if(ns==""||ns==undefined)ns="/";if(!(host in this.hosts))this.hosts[ns]={host:host,port:socketPort};var socket=io.connect("http://"+host+ns,{port:socketPort});if(connectFunc==undefined)socket.on("connect",function(){GFSIOAS3.dispatch("connect",ns)});this.sockets[ns]=socket};GFSIOAS3.prototype.disconnect=function(ns){if(ns==""||ns==undefined)ns="/";if(!(ns in this.sockets))return;this.sockets[ns].disconnect();delete this.sockets[ns]};GFSIOAS3.prototype.emit=function(event,msg,ns){if(ns==undefined||ns=="")ns="/";if(!(ns in this.sockets))this.createSocket(ns,this.hosts[ns].host,this.hosts[ns].port);if("object"==typeof msg&&event==null)return;if("string"==typeof msg&&event==null)this.sockets[ns].emit(msg);else this.sockets[ns].emit(event,msg)};GFSIOAS3.prototype.send=function(data,ns){if(ns==undefined||ns=="")ns="/";if(!(ns in this.sockets))return;this.sockets[ns].send(data)};GFSIOAS3.prototype.addEvent=function(type,listener,ns){if(ns==undefined||ns=="")ns="/";if(listener==undefined||listener==null){listener=function(data){GFSIOAS3.dispatch(type,ns,data)};this.listeners[ns]={type:type,listener:listener}}this.sockets[ns].on(type,this.listeners[ns].listener)};GFSIOAS3.prototype.removeEvent=function(type,listener,ns){if(ns==undefined||ns=="")ns="/";if(!(ns in this.listeners))return;else if(type in this.listeners[ns])if(this.listeners[ns].listener==listener)this.sockets[ns].removeListener(this.listeners[ns].type,this.listenres[ns].listener);else return;else return};GFSIOAS3.prototype.dispatch=function(event,data){this.__swfName(this.swfID).dispatchAS3(event,data)};GFSIOAS3.prototype.__swfName=function(name){return navigator.appName.indexOf("Microsoft")!=-1?window[name]:document[name]};GFSIOAS3.init=function(swfID){GFSIOAS3=window.GFSIOAS3=new GFSIOAS3(swfID)};}';
		
		private static const SOCKET_INIT:String = "GFSIOAS3.init";
		
		

		/**
		 * 現在接続しているホストの URL を返します。 
		 * @return 現在接続しているホストの URL です。
		 */		
		public function get host():String{ return _host; }
		public function set host( value:String ):void{
			_host = value;
			disconnect();
			connect( _host, _port );
		}
		private var _host:String;
		
		
		
		/**
		 * 現在接続しているホストのポートを返します。 
		 * @return 現在接続しているポート番号です。
		 * @default 3000
		 */		
		public function get port():uint{ return _port; }
		public function set port( value:uint ):void {
			_port = value;
			disconnect();
			connect( _host, _port );
		}
		private var _port:uint = 3000;
		
		
		
		/**
		 * Socket.IO で使用しているネームスペースを返します。 
		 * @return 
		 */		
		public function get nameSpace():String{ return _nameSpace; }
		public function set nameSpace( value:String ):void{
			disconnect();
			var tmp:Shape = _dispatchers.getDispatcher(_nameSpace) as Shape;
			_dispatchers.removeDispatcher(_nameSpace);
			_nameSpace = value;
			_dispatchers.addDispatcher( _nameSpace, tmp );
			connect( _host, _port );
		}
		private var _nameSpace:String;
		
		
		
		/**
		 * 現在の Socket.id を返します。 
		 * @return String 現在の Socket.id 
		 */		
		public function get socketID():String{ return _socketID; }
		private var _socketID:String;
		
		
		
		/**
		 * 初期化済みかどうか Boolean 値を返します。 
		 * @return Boolean 初期化済みかどうか
		 */		
		public static function get isInitialized():Boolean{ return _isInitialized; }
		private static var _isInitialized:Boolean = false;

		
		
		/**
		 * Socket.IO のクライアント url を指定します。 
		 * @return String
		 */		
		public static function get socketIOClientURL():String{ return _socketIOClientURL; }
		public static function set socketIOClientURL(value:String):void{ _socketIOClientURL = value; }
		private static var _socketIOClientURL:String = '/socket.io/socket.io.js';
		
		
		
		/**
		 * Socket.IO クライアント js を GFSIOAS3 によって設定するのではなく
		 * 自身で設定する場合値を true にします。 
		 * @return Boolean
		 */		
		public static function get useManualClient():Boolean{ return _useManualClient; }
		public static function set useManualClient( value:Boolean ):void{ _useManualClient = value; }
		private static var _useManualClient:Boolean = false;
		
		//Constractor
		public function GFSIOAS3( host:String = null, port:uint = 3000, nameSpace:String = "/" ) {
			if( !ExternalInterface.available ){
				throw new Error("エクスターナルインターフェースが有効ではありません");
			}
			_host = host;
			_port = port;
			_nameSpace = nameSpace;
			
			_dispatchers = DispatchManager.getInstance();
			var dispatcher:Shape = new Shape();
			_dispatchers.addDispatcher( _nameSpace, dispatcher );
			
			if( !_isInitialized ){
				ExternalInterface.addCallback( 'dispatchAS3', _dispatchAS3 );
				ExternalInterface.call( DOCUMENT_WRITER, _socketIOClientURL );
				ExternalInterface.call( SOCKET_LIB );
				ExternalInterface.call( SOCKET_INIT, ExternalInterface.objectID );
				_isInitialized = true;
			}
		}
		
		
		
		/**
		 * Socket.IO サーバーとの接続を確立します。
		 * @param host Socket.IO サーバーの URL
		 * @param port Socket のポート
		 */		
		public function connect( host:String = null, port:uint = 3000 ):void {
			if( _host == null && host == null ){ return; }
			ExternalInterface.call( 'GFSIOAS3.createSocket', _nameSpace, _host, _port );
		}
		
		
		
		/**
		 * Socket.IO サーバーとの接続を切断します。 
		 */		
		public function disconnect():void{
			ExternalInterface.call( 'GFSIOAS3.disconnect' );
		}
		
		
		
		/**
		 * Scoket.IO サーバーへメッセージを送信します。 
		 * @param event サーバー側で監視しているカスタムイベント名。
		 * @param data:* サーバーへ送信したいデータ
		 */		
		public function emit( event:String, data:* = null ):void {
			ExternalInterface.call( 'GFSIOAS3.emit', event, data, _nameSpace );
		}
		
		
		
		/**
		 * メッセージを WebSocket のセマンティクスを用いて送信します。
		 * この場合、サーバー側で message をリスンしてる必要があります。 
		 * @param data 送信したいデータ
		 */		
		public function send( data:* ):void {
			ExternalInterface.call( 'GFSIOAS3.send', data, _nameSpace );
		}
		
		
		
		/**
		 * クライアントサイドでイベントの通知を受け取るようにイベントを登録します。
		 * @param type:String イベントのタイプです。
		 * @param listener:String @default = null イベントを処理するリスナー関数です。
		 * デフォルトでは GFSIOAS3 インスタンスへイベント処理をそのまま委譲するリスナーが設定されます。
		 * 処理を委譲する前に、データの加工など、処理を挟みたい場合 String で JavaScript 関数を渡すことが出来ます。
		 */		
		public function addEvent( type:String, listener:String = null ):void {
			ExternalInterface.call( 'GFSIOAS3.addEvent', type, listener, _nameSpace );
		}
		
		
		
		/**
		 * イベントリスナーを削除します。 
		 * @param type:String
		 * @param listener:String
		 */		
		public function removeEvent( type:String, listener:String = null ):void{
			ExternalInterface.call( 'GFSIOAS3.removeEvent', type, listener, _nameSpace );
		}
		
		
		
		/**
		 * イベントリスナーオブジェクトを EventDispatcher オブジェクトに登録し、リスナーがイベントの通知を受け取るようにします。 
		 * @param type:String
		 * @param listener:Function
		 * @param useCapture:Boolean
		 * @param priority
		 * @param useWeakReference
		 */		
		public function addEventListener(type:String, listener:Function, useCapture:Boolean=false, priority:int=0, useWeakReference:Boolean=false):void {
			_dispatchers.getDispatcher(_nameSpace).addEventListener( type, listener, useCapture, priority, useWeakReference );
		}
		
		
		
		/**
		 * EventDispatcher オブジェクトからリスナーを削除します。 
		 * @param type
		 * @param listener
		 * @param useCapture
		 * 
		 */		
		public function removeEventListener(type:String, listener:Function, useCapture:Boolean=false):void {
			_dispatchers.getDispatcher(_nameSpace).removeEventListener( type, listener, useCapture );
		}
		
		
		/**
		 * @private Socket.IO サーバーからのイベントをディスパッチします。 
		 * @param event
		 * @param ns
		 * @param data
		 * 
		 */		
		private function _dispatchAS3( event:*, ns:String, data:* = null ):void{
			var evt:String = String(event);
			var dispatcher:Shape = _dispatchers.getDispatcher(ns) as Shape;
			if( !dispatcher){ return; }
			switch(evt){
				case "connect":
					dispatcher.dispatchEvent( new GFSIOAS3Event( GFSIOAS3Event.CONNECTED ));
					break;
				case "error":
					dispatcher.dispatchEvent( new GFSIOAS3Event( GFSIOAS3Event.ERROR ));
					break;
				default:
					dispatcher.dispatchEvent( new GFSIOAS3Event( GFSIOAS3Event.PROGRESS, data, evt ));
					break;
			}
		}
		
		private var _dispatchers:DispatchManager;
	}
}