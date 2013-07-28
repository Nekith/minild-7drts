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
    
    public function new(level : ALevel, position : Point, owner : Owner)
    {
        super(level, position, owner);
        level.addBuilding(this);
        type = "building";
        var r : ARobot = Type.createInstance(level.barrackOptions[0], [ level, new Point(x, y), owner ]);
        buildingTime = r.getCost() * ARobot.TIME;
        r.clean();
        var g : Graphics = graphics;
        if (Owner.PLAYER == owner) {
            g.beginFill(0xDC143C);
        }
        else {
            g.beginFill(0x143CDC);
        }
        g.drawRect( -50, -35, 100, 70);
        g.endFill();
    }
    
    public override function capture(attacker : Owner) : Void
    {
        if (owner != attacker) {
            level.win(attacker);
            owner = attacker;
            var g : Graphics = graphics;
            if (Owner.PLAYER == owner) {
                g.beginFill(0xDC143C);
            }
            else {
                g.beginFill(0x143CDC);
            }
            g.drawRect( -50, -35, 100, 70);
            g.endFill();
        }
    }
    
    public override function update() : Void
    {
        --buildingTime;
        if (0 >= buildingTime) {
            var g : Grunt = new Grunt(level, new Point(x, y), owner);
            g.direction = buildingOrder.getDirection(new Point(x, y));
            buildingTime = g.getCost() * ARobot.TIME;
        }
        super.update();
    }
    
    public override function clean() : Void
    {
        level.removeChild(this);
        super.clean();
    }
}