package entities;

import flash.geom.Point;
import flash.display.Shape;
import flash.display.Graphics;
import scenes.ALevel;
import entities.AEntity;

class Fort extends AEntity
{
    private var _figure : Shape;
    
    public function new(level : ALevel, position : Point, owner : Owner)
    {
        super(level, position);
        type = "building";
        this._figure = new Shape();
        var g : Graphics = this._figure.graphics;
        g.clear();
        if (Owner.PLAYER == owner) {
            g.beginFill(0xDC143C);
        }
        else {
            g.beginFill(0x143CDC);
        }
        g.drawRect(-50, -35, 100, 70);
        addChild(this._figure);
    }
}