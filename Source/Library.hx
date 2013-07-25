package ;

import flash.text.Font;
import flash.display.BitmapData;

@:font("assets/font/slkscr.ttf") class PixelFont extends Font { }
@:bitmap("assets/graphics/barrackb.png") class BitmapDataBarrackB extends BitmapData { }
@:bitmap("assets/graphics/barrackn.png") class BitmapDataBarrackN extends BitmapData { }
@:bitmap("assets/graphics/barrackr.png") class BitmapDataBarrackR extends BitmapData { }

class Library
{
    static public function init() : Void
    {
        //Font.registerFont(PixelFont);
    }
    
    private function new()
    {
    }
}