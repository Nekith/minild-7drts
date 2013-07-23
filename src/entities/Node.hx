package entities;

import flash.geom.Point;
import flash.display.Shape;
import flash.display.Graphics;
import scenes.ALevel;
import entities.AEntity;

class Node extends AEntity
{
    public var linked(default, null) : AEntity;
    public var ways(default, null) : Array<AEntity>;
    private var _figure : Shape;
    
    public function new(level : ALevel, position : Point, ?linked : AEntity)
    {
        super(level, position);
        type = "node";
        this.linked = linked;
        ways = [];
        this._figure = new Shape();
        var g : Graphics = this._figure.graphics;
        g.clear();
        g.beginFill(0xCFE2F3);
        g.drawCircle(0, 0, 12);
        addChild(this._figure);
    }
    
    public function addWay(node : Node) : Void
    {
        ways.push(node);
        node.ways.push(this);
    }
}