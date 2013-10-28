/*
 * Copyright (c) 2009 Initials Video Games
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */ 
 
 /*
 * MenuState.as
 * Created On: 22/04/2012 2:34 PM
 */
 
package 
{
	import org.axgl.*;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;

	public class LicenseKeyState extends AxState
	{
		[Embed(source = "../data/C64.ttf", fontFamily = "commodore", embedAsCFF = "false")] protected var c64:String;
		
		private var playButton:AxButton;
		private var titleTxt:AxText;
		private var hasConnect:Boolean = false;
		private var loader:URLLoader;

		
		override public function create():void
		{
			
			Ax.bgColor = 0xffa5a5ff;
			
			var bg:AxSprite = new AxSprite(20, 20);
			bg.makeGraphic(Ax.width - 40, Ax.height - 40, 0xff4343e7, false);
			add(bg);
			
			titleTxt = new AxText(24, 30, Ax.width-48, "Connecting to license server ");
			titleTxt.setFormat("commodore");
			titleTxt.size = 8;
			titleTxt.alignment = "left";
			titleTxt.color = 0xDBDBDB;
			add(titleTxt);
			
			
			playButton = new AxButton(Ax.width/2, Ax.height/2 , "BEGIN", play);
			playButton.color = 0xCCEEF9;
			playButton.label.color = 0xffffff;
			add(playButton);
			playButton.x = Ax.width / 2 - playButton.width / 2;
			playButton.visible = false;
			
			
			Ax.mouse.show();
			
			loader = new URLLoader;
			loader.load( new URLRequest( "http://superlemonadefactory.initialsgames.com/log.xml" ) );
			loader.addEventListener( Event.COMPLETE, onLoaded );
			loader.addEventListener( IOErrorEvent.IO_ERROR, loadError );
			
			
			
			
		}

		override public function update():void
		{
			if (!hasConnect)
				titleTxt.text += ".";
			super.update();

		}
		
		private function play():void
		{
			Ax.switchState(new PCIntroState());
		}
		
		private function onLoaded( e:Event ):void
		{	
			loader.removeEventListener( Event.COMPLETE, onLoaded );
			loader.removeEventListener( IOErrorEvent.IO_ERROR, loadError );
			var xml:XML = new XML( loader.data );
			loader = null;
			
			if (xml.demoKey != "demoVersion016heybuddycrackthis6969" )
			{
				titleTxt.text = "Super Lemonade Factory beta expired version expired.";
				hasConnect = true;
			}
			else {
				titleTxt.text = "Super Lemonade Factory beta version licensed.";
				hasConnect = true;
				playButton.visible = true;
				
			}
		}
		
		private function loadError( e:IOErrorEvent ):void
		{
			titleTxt.text = "Could not connect to license server.\nPlease connect to the internet.";
			hasConnect = true;
			
			loader.removeEventListener( Event.COMPLETE, onLoaded );
			loader.removeEventListener( IOErrorEvent.IO_ERROR, loadError );
			loader.close();
			loader = null;
		}
		
	}
}