package hxhockeyapp.complex.crashes.services.platforms.js;

#if js
import js.Error;
import js.Browser;
import hxhockeyapp.complex.crashes.services.common.BaseHockeyAppCrashesService;

class JsHockeyAppCrashesService extends BaseHockeyAppCrashesService {
	public function new(appId:String, appVersion:String, appPackage:String) {
		super(appId, appVersion, appPackage);
	}

	public function send(e:Error) {
		sendCrash(e.stack);
	}

	override function get__osVersion():String {
		return Browser.window.navigator.platform;
	}
}
#end