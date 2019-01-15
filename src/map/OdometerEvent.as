package map
{
	import flash.events.Event;
	
	public class OdometerEvent extends Event
	{
		public static const GET_SPEED:String = "GET_SPEED";
		
		private var _kilometer_hour:Number;
		public  function get kilometer_hour():Number
		{
			return _kilometer_hour;
		}
		
		private var _meter_secound:Number;
		public  function get meter_secound():Number
		{
			return _meter_secound;
		}
		
		private var _mile_hour:Number;
		public  function get mile_hour():Number
		{
			return _mile_hour;
		}
		
		private var _foot_secound:Number;
		public  function get foot_secound():Number
		{
			return _foot_secound;
		}

		private var _altitude:Number;
		public function get altitude():Number
		{
			return _altitude;
		}
		private var _latitude:Number;
		public function get latitude():Number
		{
			return _latitude;
		}
		private var _longitude:Number;
		public function get longitude():Number
		{
			return _longitude;
		}
		private var _heading:Number;
		public function get heading():Number
		{
			return _heading;
		}
		private var _speed:Number;
		public function get speed():Number
		{
			return _speed;
		}
		private var _horizontalAccuracy:Number;
		public function get horizontalAccuracy():Number
		{
			return _horizontalAccuracy;
		}
		private var _verticalAccuracy:Number;
		public function get verticalAccuracy():Number
		{
			return _verticalAccuracy;
		}
		private var _timestamp:Number;
		public function get timestamp():Number
		{
			return _timestamp;
		}
		public function OdometerEvent(type:String,
									  altitude:Number,
									  latitude:Number,
									  longitude:Number,
									  heading:Number,
									  speed:Number,
									  horizontalAccuracy:Number,
									  verticalAccuracy:Number,
									  timestamp:Number,
									  kilometer_hour:Number,
									  meter_secound:Number,
									  mile_hour:Number,
									  foot_secound:Number,
									  bubbles:Boolean=false,
									  cancelable:Boolean=false)
		{
			_altitude = altitude;
			_latitude = latitude;
			_longitude = longitude;
			_heading = heading;
			_speed = speed;
			_horizontalAccuracy = horizontalAccuracy;
			_verticalAccuracy = verticalAccuracy;
			_timestamp = timestamp;	
			_kilometer_hour = kilometer_hour;
			_meter_secound = meter_secound;
			_mile_hour = mile_hour;
			_foot_secound = foot_secound;
			super(type, bubbles, cancelable);
		}
	}
}