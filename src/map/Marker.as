package map
{
	import flash.filesystem.File;

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
		private var _id:String;
		public function set id(Id_p:String):void
		{
			_id = Id_p
		}
		public function get id():String
		{
			return _id
		}
		
		private var _icon:String;
		public function get icon():String
		{
			return _icon
		}
		public function Marker(Lat_p:Number,Lng_p:Number,Id_p:String='',Label_p:String='',Title_p:String='',Icon_p:String='')
		{
			_lat = Lat_p
			_lng = Lng_p
			_label = Label_p	
			_title = Title_p	
			_id = Id_p
			if(Icon_p!='')
			{	
				var _path:File = File.applicationDirectory.resolvePath(Icon_p);
				var _pathCopy : File = File.createTempFile();
				if(_path.exists)
				{			
					_path.copyTo(_pathCopy, true);
					_icon = _pathCopy.url
				}
				else
				{
					trace('<<---Marker icons path is not exists and use default Google Map icon--->>')
					_icon = '';
				}
			}
		}
	}
}