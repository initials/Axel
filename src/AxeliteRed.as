package {
	import net.axgl.state.GameState;
	import net.axgl.state.TitleState;
	import com.initialsgames.axsrc.PCIntroState;
	
	import org.axgl.Ax;
	
	[SWF(width="1040", height="780", backgroundColor="#d3bdb2")]
	
	public class AxeliteRed extends Ax {
		public function AxeliteRed() {
			// Start in our TitleState
			super(TitleState);
		}
		
		override public function create():void {
			// Force ability to open debugger using ~ or \ even in release mode
			Ax.debuggerEnabled = true;
		}
	}
}