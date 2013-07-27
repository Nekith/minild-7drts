package entities;

import flash.geom.Point;
import flash.display.BitmapData;
import flash.display.Graphics;
import scenes.ALevel;
import entities.AEntity;
import entities.ARobot;
import entities.Node;
import Library;

class Psycho extends ARobot
{
    public function new(level : ALevel, position : Point, owner : Owner)
    {
        super(level, position, owner, (Owner.PLAYER == owner ? Library.getInstance().psychoR : Library.getInstance().psychoB));
        // stats
        speed = 1.5;
        range = 20;
        reload = 20;
        damage = 2;
        armor = 2;
        life = 10;
    }
    
    public override function getCost() : Int
    {
        return 2;
    }
}