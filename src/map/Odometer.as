package map
{
	import contents.alert.Alert;
	import flash.display.MovieClip;
	import flash.events.PermissionEvent;
	import flash.permissions.PermissionStatus;
	
	import flash.events.EventDispatcher;
	import flash.events.GeolocationEvent;
	import flash.events.IEventDispatcher;
	import flash.sensors.Geolocation;
	import flash.utils.clearInterval;
	import flash.utils.clearTimeout;
	import flash.utils.setInterval;
	import flash.utils.setTimeout;
	
	[Event(name = "GET_SPEED", type = "map.OdometerEvent")]
	public class Odometer extends MovieClip
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
		private static var _accracy:String;
		private static var _pause:Boolean;
		
		private static var setTimeOutId:uint;
		private static var _speedTime:Number;
		private static var intervalId:int;
		private static var intervalIdMute:int = 0;
		
		public static function get kilometer_hour():Number
		{
			return convert(_speed, METER_SECOND, KILOMETER_HOUR);
		}
		
		public static function get meter_secound():Number
		{
			return _speed;
		}
		
		public static function get mile_hour():Number
		{
			return convert(_speed, METER_SECOND, MILE_HOUR);
		}
		
		public static function get foot_secound():Number
		{
			return convert(_speed, METER_SECOND, FOOT_SECOND);
		}
		
		public function Odometer(target:IEventDispatcher = null)
		{
			super();
		}
		
		public static function getGPSPermission(e:* = null):void
		{
			if (Geolocation.permissionStatus != PermissionStatus.GRANTED)
			{
				geo.addEventListener(PermissionEvent.PERMISSION_STATUS, function(e:PermissionEvent):void
				{
					if (e.status == PermissionStatus.GRANTED)
					{
						trace("!!Permission granted");
					}
					else
					{
						trace("permission denied");
					}
				});
				
				try
				{
					trace("ask for User permission");
					geo.requestPermission();
				}
				catch (e:Error)
				{
					trace("!!!!!!!!!! asked permission problem");
						// another request is in progress
				}
			}
			else
			{
				trace("GPS permission granted earlier");
			}
		}
		
		private static var geo:Geolocation;
		
		/**
		 * @param	pauseAutomatically	for ios This would allow application developers to choose if they want to keep the geolocation services active when the application is in the background*/
		public static function start(DebugMode:Boolean = false, SpeedTime:Number = 0, pauseAutomatically:Boolean = true, accuracy:String = AccuracyMode.LOCATION_NOT_DEFINE):void
		{
			_speedTime = SpeedTime;
			_accracy = accuracy;
			_pause = pauseAutomatically;
			dispacher = new Odometer();
			geo = new Geolocation();
			geo.addEventListener(GeolocationEvent.UPDATE, update);
			intervalId = setInterval(checkGPS, 1000);
			if (DebugMode)
			{
				geo.pausesLocationUpdatesAutomatically = pauseAutomatically;
				clearTimeout(setTimeOutId);
				setTimeOutId = setTimeout(debugEvent, 1000);
			}
		
		}
		
		static public function isMuted():Boolean
		{
			if (geo != null)
			{
				return geo.muted;
			}
			else
			{
				return true;
			}
			
		}
		
		static private function checkGPS():void
		{
			if (Geolocation.permissionStatus == PermissionStatus.GRANTED)
			{
				(geo as Object).pausesLocationUpdatesAutomatically = _pause;
				(geo as Object).desiredAccuracy = _accracy;
				clearInterval(intervalId);
			}
		}
		
		/**Geolocation.LOCATION_ACCURACY_BEST_FOR_NAVIGATION: for the highest possible accuracy that uses additional sensor data to facilitate navigation apps<br/>
		 * Geolocation.LOCATION_ACCURACY_BEST: for the best level of accuracy available<br/>
		 * Geolocation.LOCATION_ACCURACY_NEAREST_TEN_METERS: for the accuracy of within ten meters of the desired target<br/>
		 * Geolocation.LOCATION_ACCURACY_HUNDRED_METERS: for the accuracy of within one hundred meters of the desired target.<br/>
		 * Geolocation.LOCATION_ACCURACY_KILOMETER: for accuracy to the nearest kilometer.<br/>
		 * Geolocation.LOCATION_ACCURACY_THREE_KILOMETERS: for accuracy to the nearest three kilometers.
		 */
		public static function set setAccuracy(Accracy:String):void
		{
			if (geo)
			{
				(geo as Object).desiredAccuracy = Accracy;
			}
		}
		
		private static function debugEvent():void
		{
			debuglat += _speedTime;
			debuglong += _speedTime;
			trace("debuglat:" + debuglat);
			trace("debuglong:" + debuglong);
			if (oldDebugLat > 0 && oldDebugLong > 0)
			{
				var debugSpeed:Number = CalculatDistance.CalculationByDistance(new Marker(oldDebugLat, oldDebugLong), new Marker(debuglat, debuglong));
				geo.dispatchEvent(new GeolocationEvent(GeolocationEvent.UPDATE, false, false, debuglat, debuglong, 0, 0, 0, debugSpeed * 1000));
			}
			oldDebugLat = debuglat;
			oldDebugLong = debuglong;
			clearTimeout(setTimeOutId);
			setTimeOutId = setTimeout(debugEvent, 1000);
		}
		
		protected static function update(event:GeolocationEvent):void
		{
			if (!isNaN(event.speed))
			{
				_speed = event.speed;
				dispacher.dispatchEvent(new OdometerEvent(OdometerEvent.GET_SPEED, event.altitude, event.latitude, event.longitude, event.heading, event.speed, event.horizontalAccuracy, event.verticalAccuracy, event.timestamp, kilometer_hour, meter_secound, mile_hour, foot_secound));
			}
		}
		
		public static function convert(InputValue_p:Number, InputUnit_p:String, ExportUnit_p:String):Number
		{
			var meter_s:Number;
			
			// convert to meter ;
			if (InputUnit_p == METER_SECOND)
			{
				meter_s = InputValue_p;
			}
			if (InputUnit_p == FOOT_SECOND)
			{
				meter_s = InputValue_p / 3.280839895013;
			}
			if (InputUnit_p == KILOMETER_HOUR)
			{
				meter_s = InputValue_p / 3.6;
			}
			if (InputUnit_p == MILE_HOUR)
			{
				meter_s = InputValue_p / 2.236936292054;
			}
			///////////////////////////////////
			
			///convert to export unit;
			if (ExportUnit_p == METER_SECOND)
			{
				return meter_s;
			}
			if (ExportUnit_p == FOOT_SECOND)
			{
				return meter_s * 3.280839895013;
			}
			if (ExportUnit_p == KILOMETER_HOUR)
			{
				return meter_s * 3.6;
			}
			if (ExportUnit_p == MILE_HOUR)
			{
				return meter_s * 2.236936292054;
			}
			return 0;
		}
	}
}