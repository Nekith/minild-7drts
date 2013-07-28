package entities;

import flash.geom.Point;
import flash.geom.Rectangle;
import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.Graphics;
import scenes.ALevel;
import entities.AEntity;
import entities.Node;

class ARobot extends AEntity
{
    static public inline var TIME : Int = 600;
    public var speed(default, null) : Float;
    public var range(default, null) : Float;
    public var reload(default, null) : Int;
    public var damage(default, null) : Int;
    public var armor(default, null) : Int;
    public var life(default, null) : Int;
    public var direction(default, default) : Float;
    public var following(default, null) : Node;
    public var sprite(default, null) : BitmapData;
    private var _recover : Int;
    private var _anim : Int;
    private var _figure : Bitmap;
    private var _figureData : BitmapData;
    
    private function new(level : ALevel, position : Point, owner : Owner, sprite : BitmapData)
    {
        super(level, position, owner);
        level.addEntity(this);
        type = "robot";
        // states
        this._recover = 0;
        this._anim = 0;
        this.sprite = sprite;
        this._figureData = new BitmapData(16, 16, true);
        this._figure = new Bitmap(this._figureData);
        this._figure.x = -8;
        this._figure.y = -8;
        addChild(this._figure);
    }
    
    public function getCost() : Int
    {
        return 1;
    }
    
    public function hit(damage : Int) : Void
    {
        life -= (armor >= damage ? 1 : damage - armor);
        if (0 >= life) {
            clean();
        }
    }
    
    public override function update() : Void
    {
        if (0 >= this._recover) {
            var p : Point = new Point(x, y);
            var a : Array<ARobot> = level.findRobots(p, (Owner.PLAYER == owner ? Owner.ENEMY : Owner.PLAYER), range);
            if (0 != a.length) {
                // shoot
                var t : ARobot = a[Std.random(a.length)];
                t.hit(damage);
                this._recover = reload;
            }
            else {
                // move
                var n : Node = level.findNode(p);
                if (null != n) {
                    n.capture(owner);
                    var o : Node = n.getOrder(owner);
                    if (null != o) {
                        direction = o.getDirection(p);
                        following = n;
                    }
                    else {
                        direction = 0;
                    }
                }
                else {
                    n = level.findNode(p, 40);
                    if (null != n && n != following) {
                        direction = n.getDirection(p);
                    }
                }
                var v : Point = Point.polar(speed, direction);
                x += v.x * speed;
                y += v.y * speed;
                this._recover = 2;
            }
        }
        else {
            --this._recover;
        }
        super.update();
    }
    
    public override function draw() : Void
    {
        super.draw();
        if (2 >= this._recover) {
            ++this._anim;
            var vx : Int = 0;
            var vy : Int = 0;
            var v : Point = Point.polar(speed, direction);
            if (Math.abs(v.y) >= Math.abs(v.x)) {
                if (v.y >= 0) {
                    vy = 0;
                }
                else {
                    vy = 32;
                }
            }
            else {
                if (v.x >= 0) {
                    vy = 48;
                }
                else {
                    vy = 16;
                }
            }
            if (30 <= this._anim) {
                vx = 0;
                this._anim = 0;
            }
            else if (15 <= this._anim) {
                vx = 16;
            }
            this._figureData.copyPixels(sprite, new Rectangle(vx, vy, 16, 16), new Point(0, 0));
        }
    }
    
    public override function clean() : Void
    {
        removeChild(this._figure);
        level.removeEntity(this);
        super.clean();
    }
}