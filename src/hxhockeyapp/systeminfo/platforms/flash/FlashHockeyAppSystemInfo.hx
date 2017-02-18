package hxhockeyapp.systeminfo.platforms.flash;

import flash.system.Capabilities;

#if flash
class FlashHockeyAppSystemInfo {
	public var os(default, null):String = "";
	public var manufacturer(default, null):String = "";
	public var model(default, null):String = "";
	public var crashReporter(default, null):String = "";

	public function new() {
		os = Capabilities.os;
	}
}
#end
