package scenes;

import flash.geom.Point;
import flash.ui.Keyboard;
import flash.display.Shape;
import flash.display.Graphics;
import scenes.AScene;
import entities.AEntity;
import entities.Node;

class ALevel extends AScene
{
    public var size(default, null) : Point;
    private var _entities : Array<AEntity>;
    private var _background : Shape;
    
    public function new(size : Point, start : Point)
    {
        super();
        dimension = size;
        this._entities = [];
        this._background = new Shape();
        var g : Graphics = this._background.graphics;
        g.clear();
        g.beginFill(0xF9CB9C);
        g.drawRect(0, 0, dimension.x, dimension.y);
        addChild(this._background);
        x = -start.x + 500;
        y = -start.y + 300;
    }
    
    public function addEntity(entity : AEntity) : Void
    {
        this._entities.push(entity);
        addChild(entity);
    }
    
    public function findNode(p : Point) : Node
    {
        for (e in this._entities) {
            if (true == Std.is(e, Node)) {
                if (15 > Math.sqrt(Math.pow(p.x - e.x, 2) + Math.pow(p.y - e.y, 2))) {
                    return cast(e, Node);
                }
            }
        }
        return null;
    }
    
    public override function update() : AScene
    {
        // parent update
        super.update();
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
        if (x < -dimension.x + 1000 - 50) {
            x = -dimension.x + 1000 - 50;
        }
        if (x > 50) {
            x = 50;
        }
        if (y > 50) {
            y = 50;
        }
        if (y < -dimension.y + 600 - 50) {
            y = -dimension.y + 600 - 50;
        }
        // entities update
        for (e in this._entities) {
            e.update();
        }
        return this;
    }
    
    public override function draw() : Void
    {
        for (e in this._entities) {
            e.draw();
        }
        super.draw();
    }
    
    public override function clean() : Void
    {
        while (this._entities.length > 0) {
            var e : AEntity = this._entities.pop();
            e.clean();
            removeChild(e);
        }
        super.clean();
    }
}