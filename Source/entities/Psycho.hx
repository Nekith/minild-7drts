package entities;

import flash.geom.Point;
import flash.display.Shape;
import flash.display.Graphics;
import scenes.ALevel;
import entities.AEntity;
import entities.ARobot;
import entities.Node;

class Psycho extends ARobot
{
    static public inline var COST = 2;
    
    public function new(level : ALevel, position : Point, owner : Owner)
    {
        super(level, position, owner);
        // stats
        speed = 1.4;
        range = 15;
        reload = 20;
        damage = 2;
        armor = 2;
        life = 8;
        // figure
        var g : Graphics = this._figure.graphics;
        g.clear();
        if (Owner.PLAYER == owner) {
            g.beginFill(0xFF003C);
        }
        else {
            g.beginFill(0x143CDC);
        }
        g.drawCircle(0, 0, 12);
    }
    
    public override function getCost() : Int
    {
        return 2;
    }
}