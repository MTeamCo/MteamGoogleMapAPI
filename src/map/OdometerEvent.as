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
		private var _currentLocation:Marker;
		public function get currentLocation():Marker
		{
			return _currentLocation;
		}
		public function OdometerEvent(type:String,kilometer_hour:Number,meter_secound:Number,mile_hour:Number,foot_secound:Number,currentLocation:Marker, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			_kilometer_hour = kilometer_hour;
			_meter_secound = meter_secound;
			_mile_hour = mile_hour;
			_foot_secound = foot_secound;
			_currentLocation = currentLocation;
			super(type, bubbles, cancelable);
		}
	}
}