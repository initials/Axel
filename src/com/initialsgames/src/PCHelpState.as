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
 * PCHelpState.as
 * Created On: 14/04/2012 11:18 AM
 */
 
package 
{
	import org.axgl.*;
	import org.flixel.plugin.photonstorm.*;

	public class PCHelpState extends AxState
	{
		public var helpStr:String =	"How to play (1 player):\n\nUse the arrow keys to move\nAndre\nPress B to dash. You can break up big crates this way.\nPress N to jump.\n\nLiselot\nPress B while facing an enemy to stop and talk.\nPress B while pushing a crate to slide it across the floor.\nPress N to jump. Press N again in the air to double jump.\nPress M to switch characters.\n\nHow to play (2 players):\n\nAndre\nUse the arrow keys to move\nPress B to dash. You can break up big crates this way.\nPress N to jump.\n\nLiselot\nUse the WASD keys to move\nPress B while facing an enemy to stop and talk.\nPress B while pushing a crate to slide it across the floor.\nPress N to jump. Press N again in the air to double jump.\n\nPress ESCAPE to exit the level or go back to a previous menu.\n\nGet both Andre and Liselot to the exit to finish the level.\n\nScoring:\nCollect the bottle to recieve a bottle cap badge for the level. Talk to Andre to recieve a speech bubble badge for the level. Talk to a co-worker to recieve a speech bubble badge for the level.\n\nClearing your Flash history can delete level progress. To restore, go to Options and import this file -> USER_DIR/SUPERLEMONADEFACTORY/progress_backup.slf";		
		
		public var helpTxt:AxText;
		
		override public function create():void
		{
			
			Ax.bgColor = 0xffF8CB8F;
			
			//	Make the gradient retro looking and "chunky" with the chucnkSize parameter (here set to 4)
			var gradient2:AxSprite = AxGradient.createGradientAxSprite(Ax.width, Ax.height, [0xffcac5ac, 0xffdedbc3 , 0xffdfdcc4], 10 ); //0xffd6d3ba
			gradient2.x = 0;
			gradient2.y = 0;
			add(gradient2);
			
			var borderTop:AxTileblock = new AxTileblock(0, 0, Ax.width, 30);
			borderTop.loadTiles(Registry.ImgLevel1Tiles, 10, 10, 0,true);
			add(borderTop);
			
			var borderBottom:AxTileblock = new AxTileblock(0, Ax.height-30, Ax.width, 30);
			borderBottom.loadTiles(Registry.ImgLevel1Tiles, 10, 10, 0,true);
			add(borderBottom);	
			
			
			var headingTxt:AxText = new AxText(0, 8, Ax.width, "Help", true);
			headingTxt.color = 0xffffffff;
			headingTxt.size = 8;
			headingTxt.alignment = "center";
			add(headingTxt);
			
			
			
			if (Registry.mouseEnabled) {
				Ax.mouse.show();
			}
			else if (!Registry.mouseEnabled) {
				Ax.mouse.hide();
			}
			
			
			helpTxt = new AxText(15, 40, Ax.width-30, helpStr);
			helpTxt.size = 8;
			helpTxt.setFormat("commodore", 8);
			helpTxt.alignment = "left";
			helpTxt.color = 0x8000FF;
			add(helpTxt);
			
			var backBtn:AxButton = new AxButton(20, Registry.ySmallPos9 , "back", this.onQuit);
			backBtn.y = Ax.height - backBtn.height;
			backBtn.status = AxButton.HIGHLIGHT;
			backBtn.color = Registry.WAREHOUSE_PURPLE;
			backBtn.label.color = 0xffffff;
			add(backBtn);
			
			
		}

		override public function update():void
		{
			
			if ((Ax.keys.justPressed(Registry.homeKey)||Ax.keys.justPressed(Registry.p1Jump)||Ax.keys.justPressed(Registry.p1Action) || Ax.joystick.j1ButtonBackJustPressed || Ax.joystick.j1ButtonAJustPressed) && !fading) {
				Ax.play(Registry.SndPing,Registry.pingVolume);
				onQuit();			
				
			}
			
			super.update();

		}
		
		protected function onQuit():void
		{
			Ax.switchState(new PCMenuState());
		}
		
		
	}
}