package entities;

import flash.geom.Point;
import flash.geom.Rectangle;
import flash.display.Graphics;
import scenes.ALevel;
import entities.AEntity;

class Node extends AEntity
{
    public var linked(default, null) : AEntity;
    public var ways(default, null) : Array<Node>;
    public var playerOrder(default, default) : Int;
    public var enemyOrder(default, default) : Int;
    private var _mouseRect : Rectangle;
    private var _changedAt : Int;
    
    public function new(level : ALevel, position : Point, ?linked : AEntity)
    {
        super(level, position);
        level.addBuilding(this);
        type = "node";
        this.linked = linked;
        ways = [];
        playerOrder = 0;
        enemyOrder = 0;
        // mouse & order
        this._mouseRect = new Rectangle(position.x - 15, position.y -15, 30, 30);
        this._changedAt = 0;
        // figure
        var g : Graphics = graphics;
        g.clear();
        g.lineStyle(1, 0x14DC3C);
        g.drawCircle(0, 0, 12);
        g.moveTo(-10, -8);
        g.lineTo(0, -25);
        g.moveTo(10, -8);
        g.lineTo(0, -25);
    }
    
    public function addWay(node : Node) : Void
    {
        ways.push(node);
        node.ways.push(this);
    }
    
    public override function capture(attacker : Owner) : Void
    {
        if (null != linked) {
            linked.capture(attacker);
        }
    }
    
    public function getOrder(owner : Owner) : Node
    {
        if (Owner.PLAYER == owner) {
            return ways[playerOrder];
        }
        else {
            return ways[enemyOrder];
        }
        return this;
    }
    
    public function getDirection(p : Point) : Float
    {
        return Math.atan2(y - p.y, x - p.x);
    }
    
    public function switchEnemyOrder() : Void
    {
        ++enemyOrder;
        if (ways.length <= enemyOrder) {
            enemyOrder = 0;
        }
    }
    
    public override function update() : Void
    {
        --this._changedAt;
        if (level.click) {
            var p : Point = new Point(level.mouse.x - level.x, level.mouse.y - level.y);
            if (0 >= this._changedAt && this._mouseRect.containsPoint(p)) {
                ++playerOrder;
                if (ways.length <= playerOrder) {
                    playerOrder = 0;
                }
                this._changedAt = 15;
            }
        }
        super.update();
    }
    
    public override function draw() : Void
    {
        this.rotation = -90 + 180 / Math.PI * Math.atan2(y - ways[playerOrder].y, x - ways[playerOrder].x);
        super.draw();
    }
}