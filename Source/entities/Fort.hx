package entities;

import flash.geom.Point;
import flash.display.Shape;
import flash.display.Graphics;
import scenes.ALevel;
import entities.AEntity;
import entities.ARobot;
import entities.Grunt;

class Fort extends AEntity
{
    public var buildingOrder(default, default) : Node;
    public var buildingTime(default, null) : Int;
    private var _figure : Shape;
    
    public function new(level : ALevel, position : Point, owner : Owner)
    {
        super(level, position, owner);
        type = "building";
        buildingTime = Grunt.COST * ARobot.TIME;
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
    
    public override function capture(owner : Owner) : Void
    {
        if (this.owner != owner) {
            // end
        }
    }
    
    public override function update() : Void
    {
        --buildingTime;
        if (0 >= buildingTime) {
            var g : Grunt = new Grunt(level, new Point(x, y), owner);
            g.direction = buildingOrder.getDirection(new Point(x, y));
            buildingTime = Grunt.COST * ARobot.TIME;
        }
        super.update();
    }
}