/*////////////////////////////////////////////

GFSIOAS3

Autor	glassesfactory
Date	2011/10/14

Copyright 2011 glasses factory
http://glasses-factory.net

/*////////////////////////////////////////////

package net.glassesfactory.node.socketIO
{
	import flash.events.EventDispatcher;
	import flash.utils.Dictionary;

	internal class DispatchManager
	{
		public function DispatchManager( caller:Function = null ){
			if( caller != DispatchManager.getInstance ){
				throw new Error("直接インスタンス化することは出来ません。");
			}
			_dispatchers = new Dictionary();
		}
		
		public static function getInstance():DispatchManager{
			if( _instance == null ){
				_instance = new DispatchManager( arguments.callee );
			}
			return _instance;
		}
		
		public function addDispatcher( key:*, dispatcher:EventDispatcher ):void{
			_dispatchers[key] = dispatcher;
			_numDispatcher++;
		}
		
		public function removeDispatcher( key:* ):void{
			delete _dispatchers[key];
			_numDispatcher--;
		}
		
		public function getDispatcher( key:* ):EventDispatcher{
			return _dispatchers[key];
		}
		
		private static var _instance:DispatchManager;
		private var _dispatchers:Dictionary;
		private var _numDispatcher:int = 0;
	}
}