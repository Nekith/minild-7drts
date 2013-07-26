package entities;

import flash.geom.Point;
import flash.display.Shape;
import flash.display.Graphics;
import scenes.ALevel;
import entities.AEntity;
import entities.ARobot;
import entities.Node;

class Grunt extends ARobot
{
    public function new(level : ALevel, position : Point, owner : Owner)
    {
        super(level, position, owner);
        // stats
        speed = 1.6;
        range = 20;
        reload = 30;
        damage = 2;
        armor = 1;
        life = 4;
    }
}