package com.litefeel.textureSplitter 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.display.PNGEncoderOptions;
	import flash.events.Event;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.geom.Rectangle;
	import flash.utils.ByteArray;
	/**
	 * ...
	 * @author lite3
	 */
	public class Splitter 
	{
		private var data:String;
		private var bitmapData:BitmapData;
		public function Splitter() 
		{
			
		}
		
		public function parse():void 
		{
			var stream:FileStream = new FileStream();
			stream.open(new File(Config.txtPath), FileMode.READ);
			data = stream.readUTFBytes(stream.bytesAvailable);
			stream.close();
			stream = new FileStream();
			stream.open(new File(Config.pngPath), FileMode.READ);
			var bytes:ByteArray = new ByteArray();
			stream.readBytes(bytes, 0, stream.bytesAvailable);
			
			var loader:Loader = new Loader();
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onLoadPngComplete);
			loader.loadBytes(bytes);
			
		}
		
		private function onLoadPngComplete(e:Event):void 
		{
			var loaderInfo:LoaderInfo = LoaderInfo(e.currentTarget);
			loaderInfo.removeEventListener(Event.COMPLETE, onLoadPngComplete);
			bitmapData = Bitmap(loaderInfo.content).bitmapData;
			
			saveFile();
		}
		
		private function saveFile():void 
		{
			const outDir:File = new File(Config.outPath);
			var bytes:ByteArray = new ByteArray();
			var opt:PNGEncoderOptions = new PNGEncoderOptions();
			var arr:Array = data.split("\n");
			for (var i:int = arr.length - 1; i >= 0; i--)
			{
				var str:String = arr[i];
				if (!str) continue;
				var infoList:Array = str.split(" ");
				var name:String = infoList[0] + ".png";
				var w:int = infoList[1];
				var h:int = infoList[2];
				var x:int = Number(infoList[3]) * 1024;
				var y:int = Number(infoList[4]) * 1024;
				bytes.length = 0;
				bitmapData.encode(new Rectangle(x, y, w, h), opt, bytes);
				var stream:FileStream = new FileStream();
				stream.open(outDir.resolvePath(name), FileMode.WRITE);
				stream.writeBytes(bytes, 0, bytes.length);
			}
			trace("complet");
		}
		
	}

}