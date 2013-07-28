package entities;

import flash.geom.Point;
import flash.display.Shape;
import flash.display.Graphics;
import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.text.TextField;
import flash.text.TextFormat;
import flash.text.TextFormatAlign;
import scenes.ALevel;
import entities.AEntity;
import entities.ARobot;
import entities.Grunt;
import Library;

class Fort extends AEntity
{
    public var buildingOrder(default, default) : Node;
    public var buildingTime(default, null) : Int;
    private var _figure : Bitmap;
    private var _lights : Bitmap;
    private var _timer : TextField;
    private var _anim : Int;
    
    public function new(level : ALevel, position : Point, owner : Owner)
    {
        super(level, position, owner);
        level.addBuilding(this);
        type = "building";
        var r : Grunt = new Grunt(level, new Point(x, y), owner);
        buildingTime = r.getCost() * ARobot.TIME;
        r.clean();
        this._anim = 0;
        // figure
        this._figure = new Bitmap((Owner.PLAYER == owner ? Library.getInstance().fortR : Library.getInstance().fortB));
        this._figure.x = -48;
        this._figure.y = -32;
        addChild(this._figure);
        this._lights = new Bitmap(Library.getInstance().fortA);
        this._lights.x = -48;
        this._lights.y = -32;
        this._lights.alpha = 0;
        addChild(this._lights);
        // timer
        var f : PixelFont = new PixelFont();
        var tf : TextFormat = new TextFormat(f.fontName, 12, 0x00FF00);
        tf.align = TextFormatAlign.RIGHT;
        this._timer = new TextField();
        this._timer.embedFonts = true;
        this._timer.defaultTextFormat = tf;
        this._timer.selectable = false;
        this._timer.text = Std.string(Math.ffloor(buildingTime / 60));
        this._timer.x = -9;
        this._timer.y = 1;
        this._timer.width = 18;
        addChild(this._timer);
    }
    
    public override function capture(attacker : Owner) : Void
    {
        if (owner != attacker) {
            level.win(attacker);
        }
    }
    
    public override function update() : Void
    {
        --buildingTime;
        if (0 >= buildingTime) {
            var g : Grunt = new Grunt(level, new Point(x, y), owner);
            g.direction = buildingOrder.getDirection(new Point(x, y));
            buildingTime = g.getCost() * ARobot.TIME;
        }
        super.update();
    }
    
    public override function draw() : Void
    {
        super.draw();
        ++this._anim;
        if (60 <= this._anim) {
            this._lights.alpha = 1;
            this._anim = 0;
        }
        else if (30 <= this._anim) {
            this._lights.alpha = 0;
        }
        this._timer.text = Std.string(Math.ffloor(buildingTime / 60));
    }
    
    public override function clean() : Void
    {
        removeChild(this._figure);
        removeChild(this._lights);
        removeChild(this._timer);
        level.removeChild(this);
        super.clean();
    }
}