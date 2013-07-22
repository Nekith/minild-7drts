package ;

import com.haxepunk.Engine;
import com.haxepunk.HXP;
import UserInterface;
import scenes.FirstLevel;

class Main extends Engine 
{
    public override function init() : Void
    {
#if debug
        HXP.console.enable();
#end
        HXP.scene = new FirstLevel();
        addChild(new UserInterface());
    }
	
    static public function main()
    {
        new Main();
    }
}
