package hxhockeyapp.systeminfo;

#if js
import hxhockeyapp.systeminfo.platforms.js.JsHockeyAppSystemInfo;

typedef HockeyAppSystemInfo = JsHockeyAppSystemInfo
#elseif flash
import hxhockeyapp.systeminfo.platforms.flash.FlashHockeyAppSystemInfo;

typedef HockeyAppSystemInfo = FlashHockeyAppSystemInfo
#else
class HockeyAppSystemInfo {
	public var os(default, null):String = "";
	public var manufacturer(default, null):String = "";
	public var model(default, null):String = "";
	public var crashReporter(default, null):String = "";

	public function new() {
	}
}
#end
