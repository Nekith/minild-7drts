package scenes;

import flash.geom.Point;
import flash.geom.Rectangle;
import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.text.TextField;
import flash.text.TextFormat;
import scenes.AScene;
import menu.Button;
import Library;

class MainMenu extends AScene
{
    private var _title : Bitmap;
    private var _subtitle : TextField;
    private var _buttons : Array<Button>;
    
    public function new()
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
        this._subtitle.text = "Super Simple Series #2.\nMini Ludum Dare #44 7dRTS entry.\n\nClick on :\n* arrows on building\n* waypoints\n\nKeyboard arrows move the view/camera.";
        this._subtitle.x = 48;
        this._subtitle.y = 196;
        this._subtitle.width = 400;
        addChild(this._subtitle);
        // buttons
        this._buttons = [];
        this._buttons.push(new Button(new Rectangle(512, 128, 100, 30), "Stage 1"));
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
        }
        return this;
    }
    
    public override function clean() : Void
    {
        removeChild(this._title);
        removeChild(this._subtitle);
        while (this._buttons.length > 0) {
            var b : Button = this._buttons.pop();
            b.clean();
            removeChild(b);
        }
        super.clean();
    }
}