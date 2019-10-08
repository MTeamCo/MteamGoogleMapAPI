package map
{
	public class Clustering
	{
		private var _markerclusterer:String;
		public function get markerclusterer():String
		{
			return _markerclusterer;
		}
		public function Clustering(Markerclusterer:String=null)
		{
			_markerclusterer =  Markerclusterer;
		}
	}
}