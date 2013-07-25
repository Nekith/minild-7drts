package ;

import flash.Lib;
import flash.display.Sprite;
import flash.display.Shape;
import flash.display.Graphics;
import flash.ui.Mouse;
import flash.events.MouseEvent;

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
        g.beginFill(0xDC143C);
        g.drawRect(0, 0, 2, 6);
        g.beginFill(0xDC143C);
        g.drawRect(0, 0, 6, 2);
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