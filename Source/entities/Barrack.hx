package entities;

import flash.geom.Point;
import flash.display.Shape;
import flash.display.Graphics;
import scenes.ALevel;
import entities.AEntity;

class Barrack extends AEntity
{
    public var buildingDirection(default, null) : Point;
    public var buildingTime(default, null) : Int;
    private var _figure : Shape;
    
    public function new(level : ALevel, position : Point, direction : Point, ?owner : Owner)
    {
        if (null == owner) {
            owner = Owner.NEUTRAL;
        }
        super(level, position, owner);
        type = "building";
        buildingDirection = direction;
        buildingTime = 600;
        this._figure = new Shape();
        addChild(this._figure);
    }
    
    public override function update() : Void
    {
        if (Owner.NEUTRAL != owner) {
            --buildingTime;
            if (0 == buildingTime) {
                var g : Grunt = new Grunt(level, new Point(x, y), owner);
            g.direction = buildingDirection;
                level.addEntity(g);
                buildingTime = 600;
            }
        }
        super.update();
    }
    
    public override function draw() : Void
    {
        super.draw();
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
    }
}