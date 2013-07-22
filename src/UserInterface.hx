package ;

import nme.Lib;
import nme.display.Sprite;
import nme.display.Shape;
import nme.display.Graphics;
import nme.ui.Mouse;
import nme.events.MouseEvent;

class UserInterface extends Sprite
{
    public var cursor(default, null) : Shape;
    
    public function new()
    {
        super();
        Mouse.hide();
        cursor = new Shape();
        var g : Graphics = cursor.graphics;
        g.clear();
        g.beginFill(0x6AA84F);
        g.drawRect(-1, -12, 3, 7);
        g.beginFill(0x6AA84F);
        g.drawRect(-1, 5, 3, 7);
        g.beginFill(0x6AA84F);
        g.drawRect(-12, -1, 7, 3);
        g.beginFill(0x6AA84F);
        g.drawRect(5, -1, 7, 3);
        addChild(cursor);
		var stage = Lib.current.stage;
        stage.addEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
    }
    
    public function onMouseMove(event : MouseEvent) : Void
    {
        cursor.x = event.stageX;
        cursor.y = event.stageY;
    }
}