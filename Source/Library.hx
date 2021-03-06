package ;

import flash.text.Font;
import flash.display.BitmapData;

@:font("assets/font/slkscr.ttf") class PixelFont extends Font { }
@:bitmap("assets/graphics/grounda.png") class BitmapDataGroundA extends BitmapData { }
@:bitmap("assets/graphics/groundb.png") class BitmapDataGroundB extends BitmapData { }
@:bitmap("assets/graphics/groundc.png") class BitmapDataGroundC extends BitmapData { }
@:bitmap("assets/graphics/groundd.png") class BitmapDataGroundD extends BitmapData { }
@:bitmap("assets/graphics/barracka.png") class BitmapDataBarrackA extends BitmapData { }
@:bitmap("assets/graphics/barrackb.png") class BitmapDataBarrackB extends BitmapData { }
@:bitmap("assets/graphics/barrackn.png") class BitmapDataBarrackN extends BitmapData { }
@:bitmap("assets/graphics/barrackr.png") class BitmapDataBarrackR extends BitmapData { }
@:bitmap("assets/graphics/forta.png") class BitmapDataFortA extends BitmapData { }
@:bitmap("assets/graphics/fortb.png") class BitmapDataFortB extends BitmapData { }
@:bitmap("assets/graphics/fortr.png") class BitmapDataFortR extends BitmapData { }
@:bitmap("assets/graphics/flagn.png") class BitmapDataFlagN extends BitmapData { }
@:bitmap("assets/graphics/flagb.png") class BitmapDataFlagB extends BitmapData { }
@:bitmap("assets/graphics/flagr.png") class BitmapDataFlagR extends BitmapData { }
@:bitmap("assets/graphics/gruntb.png") class BitmapDataGruntB extends BitmapData { }
@:bitmap("assets/graphics/gruntr.png") class BitmapDataGruntR extends BitmapData { }
@:bitmap("assets/graphics/psychob.png") class BitmapDataPsychoB extends BitmapData { }
@:bitmap("assets/graphics/psychor.png") class BitmapDataPsychoR extends BitmapData { }
@:bitmap("assets/graphics/title.png") class BitmapDataTitle extends BitmapData { }

class Library
{
    static private var _instance : Library = null;
    public var groundA(default, null) : BitmapData;
    public var groundB(default, null) : BitmapData;
    public var groundC(default, null) : BitmapData;
    public var groundD(default, null) : BitmapData;
    public var barrackA(default, null) : BitmapData;
    public var barrackB(default, null) : BitmapData;
    public var barrackN(default, null) : BitmapData;
    public var barrackR(default, null) : BitmapData;
    public var fortA(default, null) : BitmapData;
    public var fortB(default, null) : BitmapData;
    public var fortR(default, null) : BitmapData;
    public var flagN(default, null) : BitmapData;
    public var flagB(default, null) : BitmapData;
    public var flagR(default, null) : BitmapData;
    public var gruntB(default, null) : BitmapData;
    public var gruntR(default, null) : BitmapData;
    public var psychoB(default, null) : BitmapData;
    public var psychoR(default, null) : BitmapData;
    
    static public function getInstance() : Library
    {
        if (null == _instance) {
            _instance = new Library();
        }
        return _instance;
    }
    
    private function new()
    {
        groundA = new BitmapDataGroundA(0, 0);
        groundB = new BitmapDataGroundB(0, 0);
        groundC = new BitmapDataGroundC(0, 0);
        groundD = new BitmapDataGroundC(0, 0);
        barrackA = new BitmapDataBarrackA(0, 0);
        barrackB = new BitmapDataBarrackB(0, 0);
        barrackN = new BitmapDataBarrackN(0, 0);
        barrackR = new BitmapDataBarrackR(0, 0);
        fortA = new BitmapDataFortA(0, 0);
        fortB = new BitmapDataFortB(0, 0);
        fortR = new BitmapDataFortR(0, 0);
        flagN = new BitmapDataFlagN(0, 0);
        flagB = new BitmapDataFlagB(0, 0);
        flagR = new BitmapDataFlagR(0, 0);
        gruntB = new BitmapDataGruntB(0, 0);
        gruntR = new BitmapDataGruntR(0, 0);
        psychoB = new BitmapDataPsychoB(0, 0);
        psychoR = new BitmapDataPsychoR(0, 0);
    }
}