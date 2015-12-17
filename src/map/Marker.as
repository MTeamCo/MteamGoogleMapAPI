package map
{
	public class Marker
	{
		private var _lat:Number;
		public function set lat(Lat_p:Number):void
		{
			_lat = Lat_p
		}
		public function get lat():Number
		{
			return _lat
		}
		private var _lng:Number;
		public function set lng(Lng_p:Number):void
		{
			_lng = Lng_p
		}
		public function get lng():Number
		{
			return _lng
		}
		private var _label:String;
		public function set label(Label_p:String):void
		{
			_label = Label_p
		}
		public function get label():String
		{
			return _label
		}
		private var _title:String;
		public function set title(Title_p:String):void
		{
			_title = Title_p
		}
		public function get title():String
		{
			return _title
		}
		public function Marker(Lat_p:Number,Lng_p:Number,Label_p:String='',Title_p:String='')
		{
			_lat = Lat_p
			_lng = Lng_p
			_label = Label_p	
			_title = Title_p	
		}
	}
}