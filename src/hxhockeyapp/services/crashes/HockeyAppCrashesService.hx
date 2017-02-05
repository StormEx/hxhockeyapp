package hxhockeyapp.services.crashes;

#if js
import hxhockeyapp.services.crashes.platforms.js.JsHockeyAppCrashesService;

typedef HockeyAppCrashesService = JsHockeyAppCrashesService;
#elseif flash
import hxhockeyapp.services.crashes.platforms.flash.FlashHockeyAppCrashesService;

typedef HockeyAppCrashesService = FlashHockeyAppCrashesService;
#else
import hxhockeyapp.services.crashes.common.BaseHockeyAppCrashesService;

class HockeyAppCrashesService extends BaseHockeyAppCrashesService {
	public function new() {
		super();
	}
}
#end