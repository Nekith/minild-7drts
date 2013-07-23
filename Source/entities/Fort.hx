package entities;

import flash.geom.Point;
import flash.display.Shape;
import flash.display.Graphics;
import scenes.ALevel;
import entities.AEntity;

class Fort extends AEntity
{
    public var buildingDirection(default, null) : Point;
    public var buildingTime(default, null) : Int;
    private var _figure : Shape;
    
    public function new(level : ALevel, position : Point, direction : Point, owner : Owner)
    {
        super(level, position, owner);
        type = "building";
        buildingDirection = direction;
        buildingTime = 600;
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
    
    public override function update() : Void
    {
        --buildingTime;
        if (0 == buildingTime) {
            var g : Grunt = new Grunt(level, new Point(x, y), owner);
            g.direction = buildingDirection;
            level.addEntity(g);
            buildingTime = 600;
        }
        super.update();
    }
}