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
    public var ways(default, null) : Array<AEntity>;
    public var playerOrder(default, default) : Int;
    public var enemyOrder(default, default) : Int;
    private var _mouseRect : Rectangle;
    private var _changedAt : Int;
    private var _figure : Shape;
    private var _arrow : Shape;
    
    public function new(level : ALevel, position : Point, ?linked : AEntity)
    {
        super(level, position);
        type = "node";
        this.linked = linked;
        ways = [];
        playerOrder = -1;
        enemyOrder = -1;
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
        this._arrow.alpha = 0;
        addChild(this._arrow);
    }
    
    public function addWay(node : Node) : Void
    {
        ways.push(node);
        node.ways.push(this);
    }
    
    public function getDirection(owner : Owner) : Point
    {
        var vx : Float = 0;
        var vy : Float = 0;
        if (Owner.PLAYER == owner) {
            if (-1 != playerOrder) {
                vx = ways[playerOrder].x;
                vy = ways[playerOrder].y;
            }
        }
        else {
            if (-1 != enemyOrder) {
                vx = ways[enemyOrder].x;
                vy = ways[enemyOrder].y;
            }
        }
        if (0 != vx && 0 != vy) {
            if (vx >= vy) {
                vy = vy / vx;
                vx = 1;
            }
            else {
                vx = vx / vy;
                vy = 1;
            }
        }
        return new Point(vx, vy);
    }
    
    public override function update() : Void
    {
        --this._changedAt;
        if (level.click) {
            var p : Point = new Point(level.mouse.x - level.x, level.mouse.y - level.y);
            if (0 >= this._changedAt && this._mouseRect.containsPoint(p)) {
                if (-1 == playerOrder) {
                    playerOrder = 0;
                }
                else {
                    ++playerOrder;
                    if (ways.length <= playerOrder) {
                        playerOrder = -1;
                    }
                }
                this._changedAt = 15;
            }
        }
        super.update();
    }
    
    public override function draw() : Void
    {
        if ( -1 != playerOrder) {
            this._arrow.rotation = -90 + 180 / Math.PI * Math.atan2(y - ways[playerOrder].y, x - ways[playerOrder].x);
            this._arrow.alpha = 1;
        }
        else {
            this._arrow.alpha = 0;
        }
        super.draw();
    }
}