/*////////////////////////////////////////////

SocketIOTest

Autor	glassesfactory
Date	2011/10/08

Copyright 2011 glasses factory
http://glasses-factory.net

/*////////////////////////////////////////////

package net.glassesfactory.node.socketIO
{
	import flash.events.Event;
	
	public class GFSIOAS3Event extends Event
	{
		public static const INITIALIZED:String = "net.glassesfactory.nede.socketIO.GFSIOAS3Event.initialized";
		
		public static const CONNECTED:String = "net.glassesfactory.node.socketIO.GFSIOAS3Event.connected";
		
		public static const PROGRESS:String = "net.glassesfactory.node.socketIO.GFSIOAS3Event.progress";
		
		public static const ERROR:String = "net.glassesfactory.net.socketIO.GFSIOAS3Event.error";
		
		
		public function get data():*{ return _data; }
		public function get eventName():String{ return _eventName; }
		
		public function GFSIOAS3Event(type:String, data:* = null, eventName:String = null, bubbles:Boolean=false, cancelable:Boolean=false )
		{
			super(type, bubbles, cancelable);
			_data = data;
			_eventName = eventName;
		}
		
		private var _data:*;
		private var _eventName:String;
	}
}