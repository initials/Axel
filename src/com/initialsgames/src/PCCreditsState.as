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
 * PCCreditsState.as
 * Created On: 14/04/2012 11:19 AM
 */
 
package 
{
	import org.axgl.*;
	import org.flixel.plugin.photonstorm.*;

	public class PCCreditsState extends AxState
	{
		
		public var creditsStr:String = "Initials Presents\n\nSUPER LEMONADE FACTORY\n\nA Game By Shane Brouwer\n\nArt\nMiguelito\n\nMusic\nEasyname\n\nMarketing\nSurprise Attack\n\nIllustration\ndoggerland.deviantart.com\n\nIn Game Voice Talent\nRoy Kelly\nKellyCommaRoy {a} gmail.com\n\nTrailer Voice Talent\nTom Mitchell\n\nAdditional Art and Copywriting\nElizabeth Docking\n\nEngine\nFlixel\n\nLevel Editor\nOgmo Editor\n\nSound Effects\nbfxr\n\nSpecial Thanks\nAdam Atomic and Semi Secret Software. Thank you for Flixel.\n\nHokori Interactive - Brett Chalupa\nTonnes of help with this version.\n\nIQPierce\nCracked the code to allow custom fonts.\nCheck out his Flixel game Connectrode.\n\nScott Rapson\nThanks for your in depth beta testing.\n\nMatt Thorson\nFor the Ogmo Editor\n\nJon K\nFlixel iOS template.\n\naxcho\nThanks for the retina help.\n\nChevy Ray\nGot me interested in the Ogmo Editor with the source code to the Ludum Dare winning game Flee Buster.\n\nAny resemblance to real persons, living or dead is purely coincidental.\n\nDedicated to Marten and Gerardus.\n\nEmail initials {a} initialsgames.com\n "
		public var creditsText:AxText;
		
		
		override public function create():void
		{
			Ax.bgColor = 0xffF8CB8F;
			
			//	Make the gradient retro looking and "chunky" with the chucnkSize parameter (here set to 4)
			var gradient2:AxSprite = AxGradient.createGradientAxSprite(Ax.width, Ax.height, [0xffcac5ac, 0xffdedbc3 , 0xffdfdcc4], 10 ); //0xffd6d3ba
			gradient2.x = 0;
			gradient2.y = 0;
			add(gradient2);
			
			creditsText = new AxText(0, 250, Ax.width, creditsStr);
			creditsText.size = 16;
			creditsText.alignment = "center";
			creditsText.velocity.y = -30;
			creditsText.color = 0xff7725a1;
			add(creditsText);
			
			var borderTop:AxTileblock = new AxTileblock(0, 0, Ax.width, 30);
			borderTop.loadTiles(Registry.ImgLevel1Tiles, 10, 10, 0,true);
			add(borderTop);
			
			var borderBottom:AxTileblock = new AxTileblock(0, Ax.height-30, Ax.width, 30);
			borderBottom.loadTiles(Registry.ImgLevel1Tiles, 10, 10, 0,true);
			add(borderBottom);		
			
			var headingTxt:AxText = new AxText(0, 8, Ax.width, "Credits", true);
			headingTxt.color = 0xffffffff;
			headingTxt.size = 8;
			headingTxt.alignment = "center";
			add(headingTxt);
			
			var backBtn:AxButton = new AxButton(20, Registry.ySmallPos9 , "back", this.onQuit);
			backBtn.y = Ax.height - backBtn.height;
			backBtn.status = AxButton.HIGHLIGHT;
			backBtn.color = Registry.WAREHOUSE_PURPLE;
			backBtn.label.color = 0xffffff;
			add(backBtn);			
			


		}

		override public function update():void
		{
			
			if (Ax.keys.any() ) {
				creditsText.velocity.y = -60;
			}
			else {
				creditsText.velocity.y = -30;
			}
			
			
			
			super.update();
			
			if ((Ax.keys.justPressed(Registry.homeKey)||Ax.keys.justPressed(Registry.p1Jump)||Ax.keys.justPressed(Registry.p1Action) || Ax.joystick.j1ButtonBackJustPressed || Ax.joystick.j1ButtonAJustPressed) && !fading) {
				Ax.play(Registry.SndPing,Registry.pingVolume);
				onQuit();			
				
			}
			

		}
		
		protected function onQuit():void
		{
			Ax.switchState(new PCMenuState());
		}
		
		
	}
}