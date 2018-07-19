package map
{
	public class LatLngBounds
	{
		private var _lat1:Number;
		public function get lat1():Number
		{
			return _lat1;
		}
		private var _lng1:Number;
		public function get lng1():Number
		{
			return _lng1;
		}
		private var _lat2:Number;
		public function get lat2():Number
		{
			return _lat2;
		}
		private var _lng2:Number;
		public function get lng2():Number
		{
			return _lng2;
		}
		public function LatLngBounds(Lat1:Number,Lng1:Number,Lat2:Number,Lng2:Number)
		{
			_lat1 = Lat1;
			_lng1 = Lng1;
			_lat2 = Lat2;
			_lng2 = Lng2;
		}
	}
}