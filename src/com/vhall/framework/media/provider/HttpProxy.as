/**
 * ===================================
 * Author:	iDzeir					
 * Email:	qiyanlong@wozine.com	
 * Company:	http://www.vhall.com		
 * Created:	May 16, 2016 11:27:33 AM
 * ===================================
 */

package com.vhall.framework.media.provider
{
	import com.vhall.framework.media.interfaces.IProgress;
	
	import flash.events.NetStatusEvent;
	import flash.net.NetStreamPlayOptions;
	import flash.net.NetStreamPlayTransitions;
	import flash.utils.getTimer;
	
	CONFIG::LOGGING{
		import org.mangui.hls.utils.Log;
	}
	
	/**
	 * http协议或者本地视频代理
	 */		
	public class HttpProxy extends RtmpProxy implements IProgress
	{
		private var _startTime:uint = 0;
		
		public function HttpProxy()
		{
			super();
			_type = MediaProxyType.HTTP;
		}
		
		override public function connect(uri:String, streamUrl:String=null, handler:Function=null, autoPlay:Boolean=true):void
		{
			_autoPlay = autoPlay;
			_uri = uri;
			_streamUrl = streamUrl;
			_handler = handler;
			
			valid();
			
			addListeners();
			
			try{
				_conn.connect(null);
			}catch(e:Error){
				CONFIG::LOGGING{
					Log.error("netConnection 建立链接失败:"+_uri);
				}
			}
			
			_startTime = getTimer();
		}
		
		override public function changeVideoUrl(uri:String, streamUrl:String, autoPlay:Boolean=true):void
		{
			var oldUri:String = this._uri;
			var oldStreamUrl:String = this._streamUrl;
			
			_autoPlay = autoPlay;
			_uri = uri;
			_streamUrl = streamUrl;
			
			valid();
			
			if(oldUri != uri)
			{
				var npo:NetStreamPlayOptions = new NetStreamPlayOptions();
				npo.oldStreamName = oldUri;
				npo.streamName = uri;
				npo.transition = NetStreamPlayTransitions.SWITCH;
				_autoPlay&&(_ns && _ns.play2(npo));
			}
			_startTime = getTimer();
		}
		
		override protected function createStream():void
		{
			super.createStream();
			
			this.inBufferSeek = true;
		}
		
		override public function start():void
		{
			_playing = true;
			_ns&&_ns.play(_uri);
		}
		
		public function get bytesLoaded():int
		{
			if(_ns) return _ns.bytesLoaded;
			return 0;
		}
		
		override public function get time():Number
		{
			if(_ns) return _ns.time;
			return 0;
		}
		
		override public function set time(value:Number):void
		{
			if(_ns) _ns.seek(value);
		}
		
		public function get bytesTotal():int
		{
			if(_ns) return _ns.bytesTotal;
			return 0;
		}
		
		public function loaded():Number
		{
			if(!_ns) return 0;
			return bytesLoaded / bytesTotal;
		}
		
		override public function toString():String
		{
			var speed:uint = (bytesLoaded/1024)/((getTimer() - _startTime)/1000);
			return _type.toLocaleUpperCase() + "播放平均网速：" + speed.toFixed(2) +" k/s";
		}
	}
}