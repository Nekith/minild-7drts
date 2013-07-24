package entities;

import flash.geom.Point;
import flash.display.Shape;
import flash.display.Graphics;
import scenes.ALevel;
import entities.AEntity;
import entities.Robot;
import entities.Node;

class Grunt extends Robot
{
    public function new(level : ALevel, position : Point, owner : Owner)
    {
        super(level, position, owner);
        // stats
        speed = 1.5;
        range = 15;
        reload = 30;
        damage = 2;
        armor = 4;
    }
}