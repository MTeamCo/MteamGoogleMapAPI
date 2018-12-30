package map
{
	import contents.alert.Alert;
	
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.utils.clearInterval;
	import flash.utils.setInterval;

	[Event(name="GET_SPEED",type="map.OdometerEvent")]
	public class Odometer extends EventDispatcher
	{
		public static const METER_SECOND:String = "meter/second";
		public static const FOOT_SECOND:String = "foot/second";
		public static const KILOMETER_HOUR:String = "kilometer/hour";
		public static const MILE_HOUR:String = "mile/hour";
		
		private static var _gps:GeoLocation;
		private static var _intervalId:uint;
		private static var _oldLocation:Marker;
		
		private static var _speed:Number;
		private static var _distance:Number;
		private static var _miliSecound:int;
		public static var dispacher:Odometer;
		
		public static function get kilometer_hour():Number
		{
			return _speed;
		}
		
		
		public static function get meter_secound():Number
		{
			return convert(_speed,KILOMETER_HOUR,METER_SECOND);
		}
		
		
		public static function get mile_hour():Number
		{
			return convert(_speed,KILOMETER_HOUR,MILE_HOUR);
		}
		
		
		public static function get foot_secound():Number
		{
			return convert(_speed,KILOMETER_HOUR,FOOT_SECOND);
		}
		
		public static function get currentLocation():Marker
		{
			return _gps.marker;
		}
		public function Odometer(target:IEventDispatcher=null)
		{
			super(target);
		}
		public static function start(miliSecound:int=100):void
		{
			dispacher = new Odometer();
			_miliSecound = miliSecound;
			_gps = new GeoLocation();
			_gps.setup(DevicePrefrence.isPC());
			_intervalId = setInterval(gpsCheker,_miliSecound);
		}
		public static function stop():void
		{
			clearInterval(_intervalId);
		}
		public static function gpsCheker():void
		{
			//_gps.marker.lat +=0.00000015
			//_gps.marker.lng +=0.00000035
			//Alert.show(_gps.marker);
			if(_gps!=null && _gps.marker!=null)
			{
				if(_oldLocation!=null)
				{
					_distance = CalculatDistance.CalculationByDistance(_oldLocation,_gps.marker);
				}
				_oldLocation = new Marker(_gps.marker.lat,_gps.marker.lng);
				_speed = (_distance*(1000/_miliSecound))*60*60;	
				dispacher.dispatchEvent(new OdometerEvent(OdometerEvent.GET_SPEED,kilometer_hour,meter_secound,mile_hour,foot_secound,currentLocation));
			}
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