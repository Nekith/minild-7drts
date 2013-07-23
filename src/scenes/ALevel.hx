package scenes;

import flash.geom.Point;
import flash.ui.Keyboard;
import flash.display.Shape;
import flash.display.Graphics;
import scenes.AScene;

class ALevel extends AScene
{
    public var size(default, null) : Point;
    private var _background : Shape;
    
    public function new(size : Point, start : Point)
    {
        super();
        dimension = size;
        this._background = new Shape();
        var g : Graphics = this._background.graphics;
        g.clear();
        g.beginFill(0x909090);
        g.drawRect(0, 0, dimension.x, dimension.y);
        addChild(this._background);
        x = -start.x + 500;
        y = -start.y + 300;
    }
    
    public override function update() : AScene
    {
        if (true == focus) {
            if (true == keys[Keyboard.LEFT]) {
                x += 10;
            }
            if (true == keys[Keyboard.RIGHT]) {
                x -= 10;
            }
            if (true == keys[Keyboard.UP]) {
                y += 10;
            }
            if (true == keys[Keyboard.DOWN]) {
                y -= 10;
            }
            if (x < -dimension.x + 1000 - 50) {
                x = -dimension.x + 1000 - 50;
            }
            if (x > 50) {
                x = 50;
            }
            if (y > 50) {
                y = 50;
            }
            if (y < -dimension.y + 600 - 50) {
                y = -dimension.y + 600 - 50;
            }
        }
        else {
        }
        super.update();
        return this;
    }
    
    public override function draw() : Void
    {
        super.draw();
    }
    
    public override function clean() : Void
    {
        super.clean();
    }
}