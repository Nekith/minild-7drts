package entities;

import flash.geom.Point;
import flash.display.BitmapData;
import flash.display.Graphics;
import scenes.ALevel;
import entities.AEntity;
import entities.ARobot;
import entities.Node;
import Library;

class Grunt extends ARobot
{
    public function new(level : ALevel, position : Point, owner : Owner)
    {
        super(level, position, owner, (Owner.PLAYER == owner ? Library.getInstance().gruntR : Library.getInstance().gruntB));
        // stats
        speed = 1.6;
        range = 30;
        reload = 30;
        damage = 2;
        armor = 1;
        life = 4;
    }
    
    public override function getCost() : Int
    {
        return 1;
    }
}