package entities;

import flash.geom.Point;
import flash.geom.Rectangle;
import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.Shape;
import flash.display.Graphics;
import scenes.ALevel;
import entities.AEntity;
import Library;

class Node extends AEntity
{
    public var linked(default, null) : AEntity;
    public var ways(default, null) : Array<Node>;
    public var playerOrder(default, default) : Int;
    public var enemyOrder(default, default) : Int;
    private var _figure : Shape;
    private var _flag : Bitmap;
    private var _flagData : BitmapData;
    private var _mouseRect : Rectangle;
    private var _changedAt : Int;
    private var _anim : Int;
    
    public function new(level : ALevel, position : Point, ?linked : AEntity)
    {
        super(level, position);
        level.addBuilding(this);
        type = "node";
        this.linked = linked;
        ways = [];
        playerOrder = 0;
        enemyOrder = 0;
        // figure
        this._figure = new Shape();
        var g : Graphics = this._figure.graphics;
        g.clear();
        g.lineStyle(1, 0x14DC3C);
        g.drawCircle(0, 0, 12);
        g.moveTo(-10, -8);
        g.lineTo(0, -25);
        g.moveTo(10, -8);
        g.lineTo(0, -25);
        addChild(this._figure);
        // flag
        this._flag = new Bitmap(new BitmapData(16, 16, true));
        if (null != linked) {
            if (Owner.PLAYER == linked.owner) {
                this._flagData = Library.getInstance().flagR;
            }
            else if (Owner.ENEMY == linked.owner) {
                this._flagData = Library.getInstance().flagB;
            }
            else {
                this._flagData = Library.getInstance().flagN;
            }
        }
        else {
            this._flag.alpha = 0;
        }
        var pf : Point = Point.polar(15, 2 * Math.PI * Math.random());
        this._flag.x = pf.x;
        this._flag.y = pf.y;
        addChild(this._flag);
        this._anim = 0;
        // mouse & order
        this._mouseRect = new Rectangle(position.x - 15, position.y -15, 30, 30);
        this._changedAt = 0;
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
            if (Owner.PLAYER == linked.owner) {
                this._flagData = Library.getInstance().flagR;
            }
            else if (Owner.ENEMY == linked.owner) {
                this._flagData = Library.getInstance().flagB;
            }
            else {
                this._flagData = Library.getInstance().flagN;
            }
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
        super.draw();
        // rotate
        this._figure.rotation = -90 + 180 / Math.PI * Math.atan2(y - ways[playerOrder].y, x - ways[playerOrder].x);
        // flag
        if (null != this._flagData) {
            var vx : Int = 0;
            if (28 <= this._anim) {
                this._anim = -1;
            }
            else if (21 <= this._anim) {
                vx = 16;
            }
            else if (14 <= this._anim) {
                vx = 32;
            }
            else if (7 <= this._anim) {
                vx = 48;
            }
            this._flag.bitmapData.copyPixels(this._flagData, new Rectangle(vx, 0, 16, 16), new Point(0, 0));
            ++this._anim;
        }
    }
    
    public override function clean() : Void
    {
        removeChild(this._figure);
        removeChild(this._flag);
        level.removeChild(this);
        super.clean();
    }
}