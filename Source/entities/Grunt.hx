package entities;

import flash.geom.Point;
import flash.display.Shape;
import flash.display.Graphics;
import scenes.ALevel;
import entities.AEntity;
import entities.Node;

class Grunt extends AEntity
{
    public var speed(default, null) : Float;
    public var direction(default, default) : Point;
    private var _recover : Int;
    private var _figure : Shape;
    
    public function new(level : ALevel, position : Point, owner : Owner)
    {
        super(level, position, owner);
        type = "grunt";
        // stats
        speed = 1.5;
        // states
        this._recover = 0;
        // figure
        this._figure = new Shape();
        var g : Graphics = this._figure.graphics;
        g.clear();
        if (Owner.PLAYER == owner) {
            g.beginFill(0xDC143C);
        }
        else {
            g.beginFill(0x143CDC);
        }
        g.drawCircle(0, 0, 6);
        addChild(this._figure);
    }
    
    public override function update() : Void
    {
        if (0 == this._recover) {
            var n : Node = level.findNode(new Point(x, y));
            if (null != n) {
                direction = n.getDirection(owner);
            }
            x += direction.x * speed;
            y += direction.y * speed;
            this._recover = 3;
        }
        else {
            --this._recover;
        }
        super.update();
    }
}