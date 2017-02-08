package ;

import hxhockeyapp.HockeyApp;
class Main {
	static var id:String = "da6c8f7efc6241a49b55c63ad29d4fa5";
	static var token:String = "2f6e1aeaaa2c4c5e9e66f893be9dc59c";

	public function new() {
	}

	public static function main() {
		HockeyApp.setup(id, "0.3.37", "test.app", true);

		try {
			trace("try to get value from null");
			var str:String = null;
			str.charAt(0);
		}
		catch(e:Dynamic) {
			trace("exception catched");
			sendBaseCrash(e);
		}

		var str:String = null;
		str.charAt(0);
//		throw "custom exception";
	}

	static function sendBaseCrash(e:Dynamic) {
//		var service:HockeyAppCrashesService = new HockeyAppCrashesService(id, "0.3.36", "test.app");
//		service.send(e);

		HockeyApp.sendCrash(e, "uncaught exception", "123456");
	}
}
