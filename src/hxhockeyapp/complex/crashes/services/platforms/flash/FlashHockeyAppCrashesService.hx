package hxhockeyapp.complex.crashes.services.platforms.flash;

#if flash
import flash.system.Capabilities;
import flash.errors.Error;
import hxhockeyapp.complex.crashes.services.common.BaseHockeyAppCrashesService;

class FlashHockeyAppCrashesService extends BaseHockeyAppCrashesService {
	public function new(appId:String, appVersion:String, appPackage:String) {
		super(appId, appVersion, appPackage);
	}

	public function send(e:Error) {
		sendCrash(e.getStackTrace());
	}

	override function get__osVersion():String {
		return Capabilities.os;
	}
}
#end