package hxhockeyapp.systeminfo.platforms.js;

#if js
import js.Browser;

class JsHockeyAppSystemInfo {
	public var os(default, null):String = "";
	public var manufacturer(default, null):String = "";
	public var model(default, null):String = "";
	public var crashReporter(default, null):String = "";

	public function new() {
		os = Browser.window.navigator.platform;
	}
}
#end