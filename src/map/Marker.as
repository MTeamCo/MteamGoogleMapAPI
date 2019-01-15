package map
{
	import file.Read_Write;
	
	import flash.filesystem.File;
	import flash.utils.ByteArray;
	
	import mx.utils.Base64Encoder;

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
		
		private var _useSetIconPath:Boolean;
		public function get useSetIconPath():Boolean
		{
			return _useSetIconPath
		}
		
		private var _infowindow:String;
		public function get infowindow():String
		{
			return _infowindow
		}
		private var _date:Date;
		public function get date():Date
		{
			return _date;
		}
		public function set date(value:Date):void
		{
			_date = value;
		}
		private var _distanc:Number;
		public function set distanc(value:Number):void
		{
			_distanc = value;
		}
		public function get distanc():Number
		{
			return _distanc;
		}
		
		/**infowindow is html format*/
		public function Marker(Lat_p:Number,Lng_p:Number,Id_p:String='',Label_p:String='',Title_p:String='',Icon_p:String='',UseSetIconPath_p:Boolean=true,Infowindow_p:String=null,Distanc_p:Number=0,Date_p:Date=null)
		{
			_lat = Lat_p
			_lng = Lng_p
			_label = Label_p	
			_title = Title_p	
			_id = Id_p
			_useSetIconPath = UseSetIconPath_p	
			_infowindow = Infowindow_p	
			_distanc = Distanc_p;	
			_date = Date_p;	
			if(Icon_p!='' && Icon_p!=null && Icon_p.indexOf('data:')==-1)
			{
				var _pathIcon:File = File.applicationDirectory.resolvePath(Icon_p); 
				var iconBytArray:ByteArray = FileManager.loadFile(_pathIcon);
					iconBytArray.position = 0;
				var b64:Base64Encoder = new Base64Encoder();
				b64.encodeBytes(iconBytArray);
				_icon = 'data: image/'+_pathIcon.extension+';base64,'+b64.toString();

			}
			else if(Icon_p.indexOf('data:')!=-1)
			{
				_icon = Icon_p;
			}
			else
			{
				_icon = '';
			}
		}
	}
}