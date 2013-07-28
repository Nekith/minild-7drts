package entities;

import flash.geom.Point;
import flash.geom.Rectangle;
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

class Barrack extends AEntity
{
    public var buildingOrder(default, default) : Node;
    public var buildingIndex(default, null) : Int;
    public var buildingTime(default, null) : Int;
    private var _figure : Bitmap;
    private var _lights : Bitmap;
    private var _robot : Bitmap;
    private var _robotData : BitmapData;
    private var _timer : TextField;
    private var _anim : Int;
    private var _changedAt : Int;
    
    public function new(level : ALevel, position : Point, ?owner : Owner)
    {
        if (null == owner) {
            owner = Owner.NEUTRAL;
        }
        super(level, position, owner);
        level.addBuilding(this);
        type = "building";
        buildingIndex = 0;
        var g : ARobot = Type.createInstance(level.barrackOptions[buildingIndex], [ level, new Point(x, y), owner ]);
        buildingTime = g.getCost() * ARobot.TIME;
        g.clean();
        this._anim = 0;
        this._changedAt = 0;
        // robot
        this._robotData = new BitmapData(16, 16, true);
        this._robotData.copyPixels(g.sprite, new Rectangle(80, 0, 16, 16), new Point(0, 0));
        this._robot = new Bitmap(this._robotData);
        this._robot.x = -8;
        this._robot.y = -8;
        this._robot.alpha = 0;
        addChild(this._robot);
        // figure
        this._figure = new Bitmap(Library.getInstance().barrackN);
        this._figure.x = -32;
        this._figure.y = -32;
        addChild(this._figure);
        this._lights = new Bitmap(Library.getInstance().barrackA);
        this._lights.x = -32;
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
        this._timer.text = Std.string(Math.fround(buildingTime / 60));
        this._timer.x = 10;
        this._timer.y = 6;
        this._timer.width = 18;
        this._timer.alpha = 0;
        addChild(this._timer);
    }
    
    public override function capture(owner : Owner) : Void
    {
        if (this.owner != owner) {
            this.owner = owner;
            removeChild(this._figure);
            if (Owner.PLAYER == owner) {
                this._figure = new Bitmap(Library.getInstance().barrackR);
                this._timer.alpha = 1;
                this._robot.alpha = 1;
            }
            else if (Owner.ENEMY == owner) {
                this._figure = new Bitmap(Library.getInstance().barrackB);
                this._timer.alpha = 1;
                this._robot.alpha = 1;
            }
            else {
                this._figure = new Bitmap(Library.getInstance().barrackN);
                this._timer.alpha = 0;
                this._robot.alpha = 0;
            }
            this._figure.x = -32;
            this._figure.y = -32;
            addChild(this._figure);
            removeChild(this._lights);
            addChild(this._lights);
            removeChild(this._timer);
            addChild(this._timer);
            // update robot
            var g : ARobot = Type.createInstance(level.barrackOptions[buildingIndex], [ level, new Point(x, y), owner ]);
            removeChild(this._robot);
            this._robotData.copyPixels(g.sprite, new Rectangle(80, 0, 16, 16), new Point(0, 0));
            addChild(this._robot);
            g.clean();
        }
    }
    
    public override function update() : Void
    {
        if (Owner.NEUTRAL != owner) {
            --buildingTime;
            if (0 == buildingTime) {
                var g : ARobot = Type.createInstance(level.barrackOptions[buildingIndex], [ level, new Point(x, y), owner ]);
                g.direction = buildingOrder.getDirection(new Point(x, y));
                buildingTime = g.getCost() * ARobot.TIME;
            }
            if (Owner.PLAYER == owner) {
                if (true == level.click && 0 >= this._changedAt) {
                    var p : Point = new Point(level.mouse.x - level.x - x, level.mouse.y - level.y - y);
                    if (-9 <= p.x && 8 >= p.x && -29 <= p.y && -9 >= p.y) {
                        --buildingIndex;
                        if (0 > buildingIndex) {
                            buildingIndex = level.barrackOptions.length - 1;
                        }
                        var g : ARobot = Type.createInstance(level.barrackOptions[buildingIndex], [ level, new Point(x, y), owner ]);
                        buildingTime = g.getCost() * ARobot.TIME;
                        this._robotData.copyPixels(g.sprite, new Rectangle(80, 0, 16, 16), new Point(0, 0));
                        g.clean();
                        this._changedAt = 15;
                    }
                    else if (11 <= p.x && 28 >= p.x && -29 <= p.y && -9 >= p.y) {
                        ++buildingIndex;
                        if (level.barrackOptions.length <= buildingIndex) {
                            buildingIndex = 0;
                        }
                        var g : ARobot = Type.createInstance(level.barrackOptions[buildingIndex], [ level, new Point(x, y), owner ]);
                        buildingTime = g.getCost() * ARobot.TIME;
                        this._robotData.copyPixels(g.sprite, new Rectangle(80, 0, 16, 16), new Point(0, 0));
                        g.clean();
                        this._changedAt = 15;
                    }
                }
                else if (0 < this._changedAt) {
                    --this._changedAt;
                }
            }
        }
        super.update();
    }
    
    public override function draw() : Void
    {
        super.draw();
        if (Owner.NEUTRAL != owner) {
            ++this._anim;
            if (120 <= this._anim) {
                this._lights.alpha = 1;
                this._anim = 0;
            }
            else if (60 <= this._anim) {
                this._lights.alpha = 0;
            }
        }
        this._timer.text = Std.string(Math.fround(buildingTime / 60));
    }
    
    public override function clean() : Void
    {
        removeChild(this._figure);
        removeChild(this._lights);
        removeChild(this._robot);
        removeChild(this._timer);
        level.removeChild(this);
        super.clean();
    }
}