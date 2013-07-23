package entities;

import flash.geom.Point;
import flash.display.Shape;
import flash.display.Graphics;
import scenes.ALevel;
import entities.AEntity;

class Barrack extends AEntity
{
    private var _figure : Shape;
    
    public function new(level : ALevel, position : Point, ?owner : Owner)
    {
        super(level, position);
        type = "building";
        this._figure = new Shape();
        var g : Graphics = this._figure.graphics;
        g.clear();
        if (Owner.PLAYER == owner) {
            g.beginFill(0xDC143C);
        }
        else if (Owner.ENEMY == owner) {
            g.beginFill(0x143CDC);
        }
        else {
            g.beginFill(0xCFE2F3);
        }
        g.drawRect(-30, -30, 60, 60);
        addChild(this._figure);
    }
}