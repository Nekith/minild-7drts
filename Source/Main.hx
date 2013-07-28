package ;

import flash.display.Sprite;
import flash.events.Event;
import flash.Lib;
import UserInterface;
import Library;
import scenes.MainMenu;

class Main extends Sprite 
{
    static public function main()
    {
        var stage = Lib.current.stage;
        stage.scaleMode = flash.display.StageScaleMode.NO_SCALE;
        stage.align = flash.display.StageAlign.TOP_LEFT;
        Lib.current.addChild(new MainMenu());
        Lib.current.addChild(new UserInterface());
    }
}
