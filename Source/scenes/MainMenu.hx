package scenes;

import flash.geom.Point;
import flash.geom.Rectangle;
import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.text.TextField;
import flash.text.TextFormat;
import flash.text.TextFormatAlign;
import scenes.AScene;
import scenes.FirstLevel;
import scenes.SecondLevel;
import scenes.ThirdLevel;
import scenes.FourthLevel;
import menu.Button;
import Library;

class MainMenu extends AScene
{
    private var _title : Bitmap;
    private var _subtitle : TextField;
    private var _message : TextField;
    private var _buttons : Array<Button>;
    
    public function new(?message : String = "")
    {
        super();
        // background
        this.graphics.beginFill(0x5F5F5F);
        this.graphics.drawRect(0, 0, dimension.x, dimension.y);
        this.graphics.endFill();
        // title
        this._title = new Bitmap(new BitmapDataTitle(0, 0));
        this._title.x = 48;
        this._title.y = 48;
        addChild(this._title);
        // subtitle
        var f : PixelFont = new PixelFont();
        var tf : TextFormat = new TextFormat(f.fontName, 13, 0xB2B2B2);
        this._subtitle = new TextField();
        this._subtitle.embedFonts = true;
        this._subtitle.defaultTextFormat = tf;
        this._subtitle.selectable = false;
        this._subtitle.text = "Super Simple Series #2.\nMini Ludum Dare #44 7dRTS entry.\n\nClick on :\n* waypoints to set orders for your robots\n* arrows on building to select which robot\n   you want to build (when available)\n\nPress :\n* arrows to move the view/camera\n* escape to abandon the stage";
        this._subtitle.x = 48;
        this._subtitle.y = 196;
        this._subtitle.width = 400;
        this._subtitle.height = 700;
        addChild(this._subtitle);
        // message
        var tfm : TextFormat = new TextFormat(f.fontName, 14, 0xFFA500);
        tfm.align = TextFormatAlign.CENTER;
        this._message = new TextField();
        this._message.embedFonts = true;
        this._message.defaultTextFormat = tfm;
        this._message.selectable = false;
        this._message.text = message;
        this._message.x = 512;
        this._message.y = 256;
        this._message.width = 300;
        addChild(this._message);
        // buttons
        this._buttons = [];
        this._buttons.push(new Button(new Rectangle(512, 128, 100, 30), "Stage 1", "New : Grunt"));
        this._buttons.push(new Button(new Rectangle(640, 128, 100, 30), "Stage 2", "New : Psycho"));
        this._buttons.push(new Button(new Rectangle(768, 128, 100, 30), "Stage 3"));
        this._buttons.push(new Button(new Rectangle(512, 240, 100, 30), "Stage 4"));
        for (b in this._buttons) {
            addChild(b);
        }
        init();
    }
    
    public override function update() : AScene
    {
        super.update();
        if (true == click) {
            var p : Point = new Point(mouse.x - x, mouse.y - y);
            if (true == this._buttons[0].rect.containsPoint(p)) {
                return new FirstLevel();
            }
            var p : Point = new Point(mouse.x - x, mouse.y - y);
            if (true == this._buttons[1].rect.containsPoint(p)) {
                return new SecondLevel();
            }
            var p : Point = new Point(mouse.x - x, mouse.y - y);
            if (true == this._buttons[2].rect.containsPoint(p)) {
                return new ThirdLevel();
            }
            var p : Point = new Point(mouse.x - x, mouse.y - y);
            if (true == this._buttons[3].rect.containsPoint(p)) {
                return new FourthLevel();
            }
        }
        return this;
    }
    
    public override function clean() : Void
    {
        removeChild(this._title);
        removeChild(this._subtitle);
        removeChild(this._message);
        while (this._buttons.length > 0) {
            var b : Button = this._buttons.pop();
            b.clean();
            removeChild(b);
        }
        super.clean();
    }
}