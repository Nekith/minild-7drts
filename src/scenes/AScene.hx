package scenes;

import haxe.Timer;
import flash.display.Sprite;
import flash.display.Shape;
import flash.display.Graphics;
import flash.geom.Point;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.events.KeyboardEvent;
import flash.ui.Mouse;
import flash.Lib;

class AScene extends Sprite
{
    public var dimension(default, null) : Point;
    public var mouse(default, null) : Point;
    public var click(default, null) : Bool;
    public var keys(default, null) : Array<Bool>;
    public var focus(default, null) : Bool;
    private var _currentTime : Float = 0;
    private var _accumulator : Float = 0;
    private var _cursor : Shape;
    
    public function new()
    {
        super();
		var stage = Lib.current.stage;
        stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
        stage.addEventListener(KeyboardEvent.KEY_UP, onKeyUp);
        stage.addEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
        stage.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
        stage.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
        stage.addEventListener(Event.ENTER_FRAME, onEnter);
        stage.addEventListener(Event.DEACTIVATE, onDeactivate);
        stage.addEventListener(Event.ACTIVATE, onActivate);
        _currentTime = Timer.stamp();
        dimension = new Point(1000, 600);
        mouse = new Point(0, 0);
        click = false;
        keys = [];
        focus = true;
        Mouse.hide();
        this._cursor = new Shape();
        var g : Graphics = this._cursor.graphics;
        g.clear();
        g.beginFill(0x6AA84F);
        g.drawRect(-1, -12, 3, 7);
        g.beginFill(0x6AA84F);
        g.drawRect(-1, 5, 3, 7);
        g.beginFill(0x6AA84F);
        g.drawRect(-12, -1, 7, 3);
        g.beginFill(0x6AA84F);
        g.drawRect(5, -1, 7, 3);
        addChild(this._cursor);
    }
    
    public function onKeyDown(event : KeyboardEvent) : Void
    {
        if (false == keys[event.keyCode]) {
            keys[event.keyCode] = true;
        }
    }
    
    public function onKeyUp(event : KeyboardEvent) : Void
    {
        keys[event.keyCode] = false;
    }
    
    public function onMouseMove(event : MouseEvent) : Void
    {
        mouse.x = event.stageX;
        mouse.y = event.stageY;
    }
    
    public function onMouseDown(event : MouseEvent) : Void
    {
        click = true;
    }
    
    public function onMouseUp(event : MouseEvent) : Void
    {
        click = false;
    }
    
    public function onEnter(event : Event) : Void
    {
        var newTime : Float = Timer.stamp();
        var frameTime : Float = newTime - _currentTime;
        _currentTime = newTime;
        _accumulator += frameTime;
        while (1 / 60.0 <= _accumulator) {
            var scene : AScene = update();
            if (scene != this) {
                this.clean();
                Lib.current.addChild(scene);
                return;
            }
            _accumulator -= 1 / 60.0;
        }
        draw();
    }
    
    public function onDeactivate(event : Event) : Void
    {
        focus = false;
    }
    
    public function onActivate(event : Event) : Void
    {
        focus = true;
    }
    
    public function update() : AScene
    {
        return this;
    }
    
    public function draw() : Void
    {
        this._cursor.x = mouse.x;
        this._cursor.y = mouse.y;
        setChildIndex(this._cursor, this.numChildren - 1);
    }
    
    public function clean() : Void
    {
        var stage = Lib.current.stage;
        stage.removeEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
        stage.removeEventListener(KeyboardEvent.KEY_UP, onKeyUp);
        stage.removeEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
        stage.removeEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
        stage.removeEventListener(MouseEvent.MOUSE_UP, onMouseUp);
        stage.removeEventListener(Event.ENTER_FRAME, onEnter);
        stage.removeEventListener(Event.DEACTIVATE, onDeactivate);
        stage.removeEventListener(Event.ACTIVATE, onActivate);
        Lib.current.removeChild(this);
    }
}