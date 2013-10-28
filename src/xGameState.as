package {
    import org.axgl.Ax;
	import org.axgl.AxSprite;
    import org.axgl.AxState;
    import org.axgl.render.AxColor;
    import org.axgl.text.AxText;
    
    public class GameState extends AxState 
	{
        override public function create():void 
		{
            Ax.background = new AxColor(.2,.2,.3);
            add(new AxText(10, 10, null, "Hello World!"));	
        }
    }
}