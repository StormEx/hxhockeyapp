package hxhockeyapp.complex.crashes.services;

#if js
import hxhockeyapp.complex.crashes.services.platforms.js.JsHockeyAppCrashesService;

typedef HockeyAppCrashesService = JsHockeyAppCrashesService;
#elseif flash
import hxhockeyapp.complex.crashes.services.platforms.flash.FlashHockeyAppCrashesService;

typedef HockeyAppCrashesService = FlashHockeyAppCrashesService;
#else
import hxhockeyapp.hxhockeyapp.complex.crashes.services.hxhockeyapp.complex.crashes.common.BaseHockeyAppCrashesService;

class HockeyAppCrashesService extends BaseHockeyAppCrashesService {
	public function new() {
		super();
	}
}
#end