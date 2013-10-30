package net.axgl.state {
	import com.initialsgames.axsrc.Registry;
	import net.axgl.resource.Resource;
	
	import org.axgl.Ax;
	import org.axgl.AxButton;
	import org.axgl.AxSprite;
	import org.axgl.AxState;
	import org.axgl.AxU;
	import org.axgl.input.AxKey;
	import org.axgl.text.AxText;
	
	import com.initialsgames.axsrc.Exit;

	public class TitleState extends AxState {
		private var background:AxSprite;
		private var websiteButton:AxButton;
		private var text:AxText;

		override public function create():void {
			// Add our background
			background = new AxSprite(0, 0, Resource.TITLE);
			this.add(background);

			// Create a new button with the default image
			websiteButton = new AxButton(100, 166);
			// Add the text "axgl.org"
			websiteButton.text("axgl.org");
			// Set it to open the website upon clicking
			websiteButton.onClick(function():void {
				AxU.openURL("http://axgl.org");
			});
			// Add the button to the state
			this.add(websiteButton);

			// Don't update or draw this state when it's not the active state
			persistantUpdate = false;
			persistantDraw = false;
			
			
			Registry.levelType = 2;
			var exit:Exit  = new Exit(10, 10, 1);
			add(exit);
			
			
		}

		override public function update():void {
			// Push space to start
			if (Ax.keys.pressed(AxKey.SPACE)) {
				Ax.pushState(new GameState);
			}

			super.update();
		}
	}
}
