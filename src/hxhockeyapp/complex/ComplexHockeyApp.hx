package hxhockeyapp.complex;

import hxhockeyapp.complex.crashes.services.HockeyAppCrashesService;

class ComplexHockeyApp {
	static inline public var HOCKEY_APP_URL:String = "https://rink.hockeyapp.net/api/2/apps/";

	var _token:String = null;
	var _appId:String = null;
	var _appVersion:String = null;
	var _appPackage:String = null;

	public function new(appId:String, appVersion:String, appPackage, token:String = null) {
		_appId = appId;
		_appVersion = appVersion;
		_appPackage = appPackage;
		_token = token;
	}

	public function createCrashesService():HockeyAppCrashesService {
		return new HockeyAppCrashesService(_appId, _appVersion, _appPackage);
	}
}
