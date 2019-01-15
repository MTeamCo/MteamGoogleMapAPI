package map
{
	import contents.alert.Alert;
	
	import flash.events.EventDispatcher;
	import flash.events.GeolocationEvent;
	import flash.events.IEventDispatcher;
	import flash.sensors.Geolocation;
	import flash.utils.clearInterval;
	import flash.utils.clearTimeout;
	import flash.utils.setInterval;
	import flash.utils.setTimeout;

	[Event(name="GET_SPEED",type="map.OdometerEvent")]
	public class Odometer extends EventDispatcher
	{
		public static const METER_SECOND:String = "meter/second";
		public static const FOOT_SECOND:String = "foot/second";
		public static const KILOMETER_HOUR:String = "kilometer/hour";
		public static const MILE_HOUR:String = "mile/hour";
		
		private static var debuglat:Number = 35.700726037213926;
		private static var debuglong:Number = 51.39178147280688;
		private static var oldDebugLat:Number;
		private static var oldDebugLong:Number;
		public static var dispacher:Odometer;
		private static var _speed:Number;	
		
		private static var setTimeOutId:uint;
		private static var _speedTime:Number;
		public static function get kilometer_hour():Number
		{
			return convert(_speed,METER_SECOND,KILOMETER_HOUR);
		}
		
		
		public static function get meter_secound():Number
		{
			return _speed;
		}
		
		
		public static function get mile_hour():Number
		{
			return convert(_speed,METER_SECOND,MILE_HOUR);
		}
		
		
		public static function get foot_secound():Number
		{
			return convert(_speed,METER_SECOND,FOOT_SECOND);
		}
		
		public function Odometer(target:IEventDispatcher=null)
		{
			super(target);
		}
		
		private static var geo:Geolocation;
		public static function start(DebugMode:Boolean=false,SpeedTime:Number=0):void
		{
			_speedTime = SpeedTime;
			dispacher = new Odometer();
			geo = new Geolocation();
			geo.addEventListener(GeolocationEvent.UPDATE,update);
			if(DebugMode)
			{
				clearTimeout(setTimeOutId);
				setTimeOutId = setTimeout(debugEvent,1000);
			}

		}
		private static function debugEvent():void
		{
			debuglat+=_speedTime;
			debuglong+=_speedTime;
			if(oldDebugLat > 0 && oldDebugLong > 0)
			{
				var debugSpeed:Number = CalculatDistance.CalculationByDistance(new Marker(oldDebugLat,oldDebugLong),new Marker(debuglat,debuglong));
				geo.dispatchEvent(new GeolocationEvent(GeolocationEvent.UPDATE,false,false,debuglat,debuglong,0,0,0,debugSpeed*1000));
			}
			oldDebugLat = debuglat;
			oldDebugLong = debuglong;
			clearTimeout(setTimeOutId);
			setTimeOutId = setTimeout(debugEvent,1000);
		}
		protected static function update(event:GeolocationEvent):void
		{	
			_speed = event.speed;
			dispacher.dispatchEvent(new OdometerEvent(OdometerEvent.GET_SPEED,event.altitude,event.latitude,event.latitude,event.heading,event.speed,event.horizontalAccuracy,event.verticalAccuracy,event.timestamp,kilometer_hour,meter_secound,mile_hour,foot_secound));	
		}

		public static function convert(InputValue_p:Number,InputUnit_p:String,ExportUnit_p:String):Number
		{
			var meter_s:Number;
			
			// convert to meter ;
			if(InputUnit_p == METER_SECOND)
			{
				meter_s =  InputValue_p;
			}
			if(InputUnit_p == FOOT_SECOND)
			{
				meter_s = InputValue_p/3.280839895013;
			}
			if(InputUnit_p == KILOMETER_HOUR)
			{
				meter_s = InputValue_p/3.6;
			}
			if(InputUnit_p == MILE_HOUR)
			{
				meter_s = InputValue_p/2.236936292054;
			}
			///////////////////////////////////
			
			///convert to export unit;
			if(ExportUnit_p == METER_SECOND)
			{
				return meter_s;
			}
			if(ExportUnit_p == FOOT_SECOND)
			{
				return  meter_s*3.280839895013;
			}
			if(ExportUnit_p == KILOMETER_HOUR)
			{
				return  meter_s*3.6;
			}
			if(ExportUnit_p == MILE_HOUR)
			{
				return  meter_s*2.236936292054;
			}	
			return 0;
		}
	}
}