package scenes;

import flash.geom.Point;
import flash.geom.Rectangle;
import flash.ui.Keyboard;
import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.Sprite;
import flash.display.Graphics;
import scenes.AScene;
import scenes.MainMenu;
import entities.AEntity;
import entities.Node;
import entities.ARobot;
import Library;

class ALevel extends AScene
{
    public var barrackOptions(default, null) : Array<Class<ARobot>>;
    public var winner(default, null) : Owner;
    private var _buildings : Array<AEntity>;
    private var _units : Array<AEntity>;
    private var _background : Bitmap;
    private var _unitground : Sprite;
    
    private function new(size : Point, start : Point)
    {
        super();
        dimension = size;
        barrackOptions = [];
        winner = Owner.NEUTRAL;
        this._buildings = [];
        this._units = [];
        // background
        var bd : BitmapData = new BitmapData(Std.int(dimension.x), Std.int(dimension.y));
        var i : Int = -Std.random(32);
        var startj : Int = -Std.random(32);
        var rect : Rectangle = new Rectangle(0, 0, 32, 32);
        while (i < dimension.y) {
            var j : Int = startj;
            while (j < dimension.x) {
                var r : Int = Std.random(4);
                if (3 == r) {
                    bd.copyPixels(Library.getInstance().groundD, rect, new Point(j, i));
                }
                else if (2 == r) {
                    bd.copyPixels(Library.getInstance().groundC, rect, new Point(j, i));
                }
                else if (1 == r) {
                    bd.copyPixels(Library.getInstance().groundB, rect, new Point(j, i));
                }
                else {
                    bd.copyPixels(Library.getInstance().groundA, rect, new Point(j, i));
                }
                j += 32;
            }
            i += 32;
        }
        this._background = new Bitmap(bd);
        addChild(this._background);
        // unitground
        this._unitground = new Sprite();
        addChild(this._unitground);
        // start
        x = -start.x + 500;
        y = -start.y + 300;
    }
    
    public function addEntity(entity : AEntity) : Void
    {
        this._units.push(entity);
        this._unitground.addChild(entity);
    }
    
    public function removeEntity(entity : AEntity) : Void
    {
        this._units.remove(entity);
        this._unitground.removeChild(entity);
    }
    
    public function addBuilding(entity : AEntity) : Void
    {
        this._buildings.push(entity);
        addChild(entity);
    }
    
    public function findRobots(p : Point, owner : Owner, d : Float) : Array<ARobot>
    {
        var a : Array<ARobot> = new Array<ARobot>();
        for (e in this._units) {
            if (e.owner == owner && true == Std.is(e, ARobot)) {
                if (d > Math.sqrt(Math.pow(p.x - e.x, 2) + Math.pow(p.y - e.y, 2))) {
                    a.push(cast(e, ARobot));
                }
            }
        }
        return a;
    }
    
    public function findNode(p : Point, ?d : Float = 10) : Node
    {
        for (e in this._buildings) {
            if (true == Std.is(e, Node)) {
                if (d > Math.sqrt(Math.pow(p.x - e.x, 2) + Math.pow(p.y - e.y, 2))) {
                    return cast(e, Node);
                }
            }
        }
        return null;
    }
    
    public function win(owner : Owner) : Void
    {
        if (Owner.NEUTRAL == winner) {
            winner = owner;
        }
    }
    
    public function enemy() : Void
    {
    }
    
    public override function update() : AScene
    {
        super.update();
        enemy();
        // camera
        if (true == keys[Keyboard.LEFT]) {
            x += 10;
        }
        if (true == keys[Keyboard.RIGHT]) {
            x -= 10;
        }
        if (true == keys[Keyboard.UP]) {
            y += 10;
        }
        if (true == keys[Keyboard.DOWN]) {
            y -= 10;
        }
        if (x < -dimension.x + 1000) {
            x = -dimension.x + 1000;
        }
        if (x > 0) {
            x = 0;
        }
        if (y > 0) {
            y = 0;
        }
        if (y < -dimension.y + 600) {
            y = -dimension.y + 600;
        }
        // entities update
        for (e in this._buildings) {
            e.update();
        }
        for (e in this._units) {
            e.update();
        }
        if (Owner.NEUTRAL != winner) {
            return new MainMenu((Owner.PLAYER == winner ? "You got 'em !" : "You lost, as always."));
        }
        return this;
    }
    
    public override function draw() : Void
    {
        for (e in this._buildings) {
            e.draw();
        }
        for (e in this._units) {
            e.draw();
        }
        super.draw();
    }
    
    public override function clean() : Void
    {
        while (this._buildings.length > 0) {
            var e : AEntity = this._buildings.pop();
            e.clean();
        }
        while (this._units.length > 0) {
            var e : AEntity = this._units.pop();
            e.clean();
        }
        removeChild(this._background);
        removeChild(this._unitground);
        super.clean();
    }
}