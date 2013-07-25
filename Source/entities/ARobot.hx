package entities;

import flash.geom.Point;
import flash.display.Shape;
import flash.display.Graphics;
import scenes.ALevel;
import entities.AEntity;
import entities.Node;

class ARobot extends AEntity
{
    static public inline var TIME : Int = 540;
    public var speed(default, null) : Float;
    public var range(default, null) : Float;
    public var reload(default, null) : Int;
    public var damage(default, null) : Int;
    public var armor(default, null) : Int;
    public var life(default, null) : Int;
    public var direction(default, default) : Float;
    public var following(default, null) : Node;
    private var _recover : Int;
    private var _figure : Shape;
    
    private function new(level : ALevel, position : Point, owner : Owner)
    {
        super(level, position, owner);
        type = "robot";
        // states
        this._recover = 0;
        // figure
        this._figure = new Shape();
        var g : Graphics = this._figure.graphics;
        g.clear();
        if (Owner.PLAYER == owner) {
            g.beginFill(0xDC143C);
        }
        else {
            g.beginFill(0x143CDC);
        }
        g.drawCircle(0, 0, 6);
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
                this._recover = 3;
            }
        }
        else {
            --this._recover;
        }
        super.update();
    }
    
    public override function clean() : Void
    {
        removeChild(this._figure);
        super.clean();
    }
}