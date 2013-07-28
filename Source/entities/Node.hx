package entities;

import flash.geom.Point;
import flash.geom.Rectangle;
import flash.display.Shape;
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
    private var _figure : Shape;
    private var _arrow : Shape;
    
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
        this._figure = new Shape();
        var g : Graphics = this._figure.graphics;
        g.clear();
        g.beginFill(0xCFE2F3);
        g.drawCircle(0, 0, 12);
        addChild(this._figure);
        // arrow
        this._arrow = new Shape();
        g = this._arrow.graphics;
        g.clear();
        g.beginFill(0x00FF00);
        g.drawRect(-2, -30, 5, 30);
        addChild(this._arrow);
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
        this._arrow.rotation = -90 + 180 / Math.PI * Math.atan2(y - ways[playerOrder].y, x - ways[playerOrder].x);
        super.draw();
    }
}