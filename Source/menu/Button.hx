package menu;

import flash.geom.Point;
import flash.geom.Rectangle;
import flash.display.Sprite;
import flash.display.Shape;
import flash.display.Graphics;
import flash.text.TextField;
import flash.text.TextFormat;
import flash.text.TextFormatAlign;
import Library;

class Button extends Sprite
{
    public var rect(default, null) : Rectangle;
    private var _label : TextField;
    private var _help : TextField;
    
    public function new(rect : Rectangle, text : String, ?help : String = "")
    {
        super();
        this.rect = rect;
        x = rect.x;
        y = rect.y;
        // box
        var g : Graphics = graphics;
        g.beginFill(0x8C8C8C);
        g.drawRect(0, 0, rect.width, rect.height);
        g.beginFill(0x6B6B6B);
        g.drawRect(1, 1, rect.width - 2, rect.height - 2);
        g.endFill();
        // label
        var f : PixelFont = new PixelFont();
        var tf : TextFormat = new TextFormat(f.fontName, 14, 0xB2B2B2);
        tf.align = TextFormatAlign.CENTER;
        this._label = new TextField();
        this._label.embedFonts = true;
        this._label.defaultTextFormat = tf;
        this._label.selectable = false;
        this._label.text = text;
        this._label.y = 7;
        this._label.width = rect.width;
        addChild(this._label);
        // help
        var tfh : TextFormat = new TextFormat(f.fontName, 11, 0xB2B2B2);
        tfh.align = TextFormatAlign.CENTER;
        this._help = new TextField();
        this._help.embedFonts = true;
        this._help.defaultTextFormat = tfh;
        this._help.selectable = false;
        this._help.text = help;
        this._help.y = 35;
        this._help.width = rect.width;
        addChild(this._help);
    }
    
    public function clean() : Void
    {
        removeChild(this._label);
        removeChild(this._help);
    }
}