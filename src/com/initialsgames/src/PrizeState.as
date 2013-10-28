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

	public class PrizeState extends AxState
	{
		[Embed(source = "../data/C64.ttf", fontFamily = "commodore", embedAsCFF = "false")] protected var c64:String;
		
		private var playButton:AxButton;
		private var backBtn:AxButton;
		private var titleTxt:AxText;
		private var hasConnect:Boolean = false;
		private var hasConnect2:Boolean = false;
		private var xml:XML
		
		private var personNumber:int;
		
		private var loader:URLLoader;
		private var loader2:URLLoader;
		private var rand:String;
		private const letters:String = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
		
		

		
		override public function create():void
		{
			
			try {
				//BRING BACK!!!
				
				var load_php:URLLoader = new URLLoader(new URLRequest("http://initialscommand.com/php/oldschool_add.php"));
			}
			catch (error:Error) {
				
			}
			finally {
				
			}
				
			
			//rand = letters[int(Ax.random() * 26)] + letters[int(Ax.random() * 26)] + letters[int(Ax.random() * 26)] + letters[int(Ax.random() * 26)];
			
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
			
			
			playButton = new AxButton(Ax.width/2, Ax.height/2 , "EMAIL", play);
			playButton.color = 0xCCEEF9;
			playButton.label.color = 0xffffff;
			add(playButton);
			playButton.x = Ax.width / 2 - playButton.width / 2;
			playButton.visible = false;
			
			backBtn = new AxButton(Ax.width/2, Ax.height-50 , "BACK TO GAME", backToGame);
			backBtn.color = 0xCCEEF9;
			backBtn.label.color = 0xffffff;
			add(backBtn);
			backBtn.x = Ax.width / 2 - playButton.width / 2;
			backBtn.visible = false;			
			
			
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
			
/*			if (hasConnect && hasConnect2) {
				var s:String = "xml.prizes." + loader2.data;
				Ax.log(s);
				
			}*/

		}
		
		private function play():void
		{
			//Ax.switchState(new PCIntroState());
			//var url:String = "mailto:initials@initialsgames.com&subject=SLF_Prize"; 
			//var urlReq = new URLRequest(url); 
			
			//urlReq.navigateToURL(new URLRequest("mailto:initials@initialsgames.com&subject=SLF_Prize"));
			
			AxU.openURL("mailto:initials@initialsgames.com?subject=SLF_Prize_Code_xk3r6xx"+personNumber);
			

			
		}
		
		private function backToGame():void
		{
			Ax.switchState(new PCMenuState());
			
			
		}		
		
		
		private function onLoaded( e:Event ):void
		{	
			loader.removeEventListener( Event.COMPLETE, onLoaded );
			loader.removeEventListener( IOErrorEvent.IO_ERROR, loadError );
			xml = new XML( loader.data );
			loader = null;
			

			hasConnect = true;
				
				
			
			loader2 = new URLLoader;
			loader2.load( new URLRequest( "http://initialscommand.com/php/oldschool_count.txt" ) );
			loader2.addEventListener( Event.COMPLETE, onLoaded2 );
			loader2.addEventListener( IOErrorEvent.IO_ERROR, loadError2 );	
			
			
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
		
		private function onLoaded2( e:Event ):void
		{	
			hasConnect2 = true;
			
			loader2.removeEventListener( Event.COMPLETE, onLoaded2 );
			loader2.removeEventListener( IOErrorEvent.IO_ERROR, loadError2 );
			trace("loader2 is: " + loader2.data);
			personNumber = loader2.data;
			
			var s:String = "p" + loader2.data;
			Ax.log(xml[s]);
			
			titleTxt.text = "You are person number " + personNumber + " to complete OLD SCHOOL mode.\n\nYou are a real human being and a real hero";
			if (personNumber<=5) {
				titleTxt.text += "\n\nHit the email button to claim your prize.\n\nIf it doesn't work, email initials@initialsgames.com with this code: xk3r6xx" + personNumber;
				playButton.visible = true;
				
			}
			backBtn.visible = true;
			loader2 = null;

		}
		
		private function loadError2( e:IOErrorEvent ):void
		{
			titleTxt.text = "Could not connect to license server.\nPlease connect to the internet.";
			loader2.removeEventListener( Event.COMPLETE, onLoaded2 );
			loader2.removeEventListener( IOErrorEvent.IO_ERROR, loadError2 );
			loader2.close();
			loader2 = null;
		}
		
		
		
	}
}