package hxhockeyapp.services.crashes.platforms.flash;

#if flash
import flash.system.Capabilities;
import hxhockeyapp.services.transport.HockeyAppServerLoader;
import flash.errors.Error;
import hxhockeyapp.services.crashes.common.BaseHockeyAppCrashesService;

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