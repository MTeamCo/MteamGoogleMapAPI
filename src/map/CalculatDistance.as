package map
{
	public class CalculatDistance
	{
		public function CalculatDistance()
		{
			
		}
		
		/** km = result/1
		 * 	meter = result % 1000
		 * */
		public  static function CalculationByDistance(StartP:Marker,EndP:Marker):Number
		{
			var Radius:int = 6371;// radius of earth in Km
			var lat1:Number = StartP.lat;
			var lat2:Number = EndP.lat;
			var lon1:Number = StartP.lng;
			var lon2:Number = EndP.lng;
			var dLat:Number = toRadians(lat2 - lat1);
			var dLon:Number = toRadians(lon2 - lon1);
			var a:Number = Math.sin(dLat / 2) * Math.sin(dLat / 2)
				+ Math.cos(toRadians(lat1))
				* Math.cos(toRadians(lat2)) * Math.sin(dLon / 2)
				* Math.sin(dLon / 2);
			var c:Number = 2 * Math.asin(Math.sqrt(a));
			return Radius * c;
		}
		public static function toDegrees(radians:Number):Number
		{
			return radians * 180/Math.PI;
		}
		
		public static function toRadians(degrees:Number):Number
		{
			return degrees * Math.PI / 180;
		}
	}
}