package
{
	import org.axgl.*;
	
	//WINNITRON : 
	//[SWF(width="1024", height="768", backgroundColor="#000000")]
	
	//PC Version:
	[SWF(width="1040", height="780", backgroundColor="#d3bdb2")]

	[Frame(factoryClass = "Preloader")]
	

	public class SLF extends AxGame
	{
		public function SLF()
		{
			//WINNITRON
			//super(512, 384, WinniMenuState, 2, 60, 30);
			//Registry.isPCVersion = false;
			//Registry.isWinnitron = true;		
			
			//PC Version:
			//super(520, 390, LicenseKeyState, 2, 60, 30);

			super(520, 390, PCIntroState, 2, 60, 30);
			
			//super(520, 390, offsetTest, 2, 60, 30);
			
			//Ax.flashFramerate = 60;
			//Ax.framerate = 60;
			
			//super(520, 390, SpeechBubbleTest, 2, 60, 30);
			
			Registry.isPCVersion = true;
			Registry.isWinnitron = false;
			
			
			//forceDebugger = false;
			
			Ax.debug = forceDebugger = false;
			

		}
	}
}
