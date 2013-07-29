package nme;


import openfl.Assets;


class AssetData {

	
	public static var className = new #if haxe3 Map <String, #else Hash <#end Dynamic> ();
	public static var library = new #if haxe3 Map <String, #else Hash <#end LibraryType> ();
	public static var type = new #if haxe3 Map <String, #else Hash <#end AssetType> ();
	
	private static var initialized:Bool = false;
	
	
	public static function initialize ():Void {
		
		if (!initialized) {
			
			className.set ("assets/font/slkscr.ttf", nme.NME_assets_font_slkscr_ttf);
			type.set ("assets/font/slkscr.ttf", Reflect.field (AssetType, "font".toUpperCase ()));
			className.set ("assets/graphics/barracka.png", nme.NME_assets_graphics_barracka_png);
			type.set ("assets/graphics/barracka.png", Reflect.field (AssetType, "image".toUpperCase ()));
			className.set ("assets/graphics/barrackb.png", nme.NME_assets_graphics_barrackb_png);
			type.set ("assets/graphics/barrackb.png", Reflect.field (AssetType, "image".toUpperCase ()));
			className.set ("assets/graphics/barrackn.png", nme.NME_assets_graphics_barrackn_png);
			type.set ("assets/graphics/barrackn.png", Reflect.field (AssetType, "image".toUpperCase ()));
			className.set ("assets/graphics/barrackr.png", nme.NME_assets_graphics_barrackr_png);
			type.set ("assets/graphics/barrackr.png", Reflect.field (AssetType, "image".toUpperCase ()));
			className.set ("assets/graphics/flagb.png", nme.NME_assets_graphics_flagb_png);
			type.set ("assets/graphics/flagb.png", Reflect.field (AssetType, "image".toUpperCase ()));
			className.set ("assets/graphics/flagn.png", nme.NME_assets_graphics_flagn_png);
			type.set ("assets/graphics/flagn.png", Reflect.field (AssetType, "image".toUpperCase ()));
			className.set ("assets/graphics/flagr.png", nme.NME_assets_graphics_flagr_png);
			type.set ("assets/graphics/flagr.png", Reflect.field (AssetType, "image".toUpperCase ()));
			className.set ("assets/graphics/forta.png", nme.NME_assets_graphics_forta_png);
			type.set ("assets/graphics/forta.png", Reflect.field (AssetType, "image".toUpperCase ()));
			className.set ("assets/graphics/fortb.png", nme.NME_assets_graphics_fortb_png);
			type.set ("assets/graphics/fortb.png", Reflect.field (AssetType, "image".toUpperCase ()));
			className.set ("assets/graphics/fortr.png", nme.NME_assets_graphics_fortr_png);
			type.set ("assets/graphics/fortr.png", Reflect.field (AssetType, "image".toUpperCase ()));
			className.set ("assets/graphics/grounda.png", nme.NME_assets_graphics_grounda_png);
			type.set ("assets/graphics/grounda.png", Reflect.field (AssetType, "image".toUpperCase ()));
			className.set ("assets/graphics/groundb.png", nme.NME_assets_graphics_groundb_png);
			type.set ("assets/graphics/groundb.png", Reflect.field (AssetType, "image".toUpperCase ()));
			className.set ("assets/graphics/groundc.png", nme.NME_assets_graphics_groundc_png);
			type.set ("assets/graphics/groundc.png", Reflect.field (AssetType, "image".toUpperCase ()));
			className.set ("assets/graphics/groundd.png", nme.NME_assets_graphics_groundd_png);
			type.set ("assets/graphics/groundd.png", Reflect.field (AssetType, "image".toUpperCase ()));
			className.set ("assets/graphics/gruntb.png", nme.NME_assets_graphics_gruntb_png);
			type.set ("assets/graphics/gruntb.png", Reflect.field (AssetType, "image".toUpperCase ()));
			className.set ("assets/graphics/gruntr.png", nme.NME_assets_graphics_gruntr_png);
			type.set ("assets/graphics/gruntr.png", Reflect.field (AssetType, "image".toUpperCase ()));
			className.set ("assets/graphics/psychob.png", nme.NME_assets_graphics_psychob_png);
			type.set ("assets/graphics/psychob.png", Reflect.field (AssetType, "image".toUpperCase ()));
			className.set ("assets/graphics/psychor.png", nme.NME_assets_graphics_psychor_png);
			type.set ("assets/graphics/psychor.png", Reflect.field (AssetType, "image".toUpperCase ()));
			className.set ("assets/graphics/title.png", nme.NME_assets_graphics_title_png);
			type.set ("assets/graphics/title.png", Reflect.field (AssetType, "image".toUpperCase ()));
			
			
			initialized = true;
			
		}
		
	}
	
	
}


class NME_assets_font_slkscr_ttf extends flash.text.Font { }
class NME_assets_graphics_barracka_png extends flash.display.BitmapData { public function new () { super (0, 0); } }
class NME_assets_graphics_barrackb_png extends flash.display.BitmapData { public function new () { super (0, 0); } }
class NME_assets_graphics_barrackn_png extends flash.display.BitmapData { public function new () { super (0, 0); } }
class NME_assets_graphics_barrackr_png extends flash.display.BitmapData { public function new () { super (0, 0); } }
class NME_assets_graphics_flagb_png extends flash.display.BitmapData { public function new () { super (0, 0); } }
class NME_assets_graphics_flagn_png extends flash.display.BitmapData { public function new () { super (0, 0); } }
class NME_assets_graphics_flagr_png extends flash.display.BitmapData { public function new () { super (0, 0); } }
class NME_assets_graphics_forta_png extends flash.display.BitmapData { public function new () { super (0, 0); } }
class NME_assets_graphics_fortb_png extends flash.display.BitmapData { public function new () { super (0, 0); } }
class NME_assets_graphics_fortr_png extends flash.display.BitmapData { public function new () { super (0, 0); } }
class NME_assets_graphics_grounda_png extends flash.display.BitmapData { public function new () { super (0, 0); } }
class NME_assets_graphics_groundb_png extends flash.display.BitmapData { public function new () { super (0, 0); } }
class NME_assets_graphics_groundc_png extends flash.display.BitmapData { public function new () { super (0, 0); } }
class NME_assets_graphics_groundd_png extends flash.display.BitmapData { public function new () { super (0, 0); } }
class NME_assets_graphics_gruntb_png extends flash.display.BitmapData { public function new () { super (0, 0); } }
class NME_assets_graphics_gruntr_png extends flash.display.BitmapData { public function new () { super (0, 0); } }
class NME_assets_graphics_psychob_png extends flash.display.BitmapData { public function new () { super (0, 0); } }
class NME_assets_graphics_psychor_png extends flash.display.BitmapData { public function new () { super (0, 0); } }
class NME_assets_graphics_title_png extends flash.display.BitmapData { public function new () { super (0, 0); } }
