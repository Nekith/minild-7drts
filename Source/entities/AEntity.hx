package entities;

import flash.geom.Point;
import flash.display.Sprite;
import scenes.ALevel;

enum Owner
{
    NEUTRAL;
    PLAYER;
    ENEMY;
}

class AEntity extends Sprite
{
    public var type(default, null) : String;
    public var owner(default, null) : Owner;
    public var level(default, null) : ALevel;
    
    public function new(level : ALevel, position : Point, ?owner : Owner)
    {
        super();
        this.level = level;
        x = position.x;
        y = position.y;
        this.owner = owner;
    }
    
    public function update() : Void
    {
    }
    
    public function draw() : Void
    {
    }
    
    public function clean() : Void
    {
        level.removeChild(this);
    }
}