package com.litefeel.textureSplitter
{
	import flash.display.Sprite;
	import flash.filesystem.File;
	
	/**
	 * ...
	 * @author lite3
	 */
	public class Main extends Sprite 
	{
		
		public function Main():void 
		{
			Config.txtPath = File.applicationDirectory.resolvePath("gfx/atlas.txt").nativePath;
			Config.pngPath = File.applicationDirectory.resolvePath("gfx/atlas.png").nativePath;
			Config.outPath = File.applicationDirectory.resolvePath("gfx/images").nativePath;
			var splitter:Splitter = new Splitter();
			splitter.parse();
		}
		
	}
	
}