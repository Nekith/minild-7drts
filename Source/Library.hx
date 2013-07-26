package ;

import flash.text.Font;
import flash.display.BitmapData;

@:font("assets/font/slkscr.ttf") class PixelFont extends Font { }
@:bitmap("assets/graphics/barrackb.png") class BitmapDataBarrackB extends BitmapData { }
@:bitmap("assets/graphics/barrackn.png") class BitmapDataBarrackN extends BitmapData { }
@:bitmap("assets/graphics/barrackr.png") class BitmapDataBarrackR extends BitmapData { }

class Library
{
    static private var _instance : Library = null;
    public var barrackB(default, null) : BitmapData;
    public var barrackN(default, null) : BitmapData;
    public var barrackR(default, null) : BitmapData;
    
    static public function getInstance() : Library
    {
        if (null == _instance) {
            _instance = new Library();
        }
        return _instance;
    }
    
    private function new()
    {
        barrackB = new BitmapDataBarrackB(0, 0);
        barrackN = new BitmapDataBarrackN(0, 0);
        barrackR = new BitmapDataBarrackR(0, 0);
    }
}