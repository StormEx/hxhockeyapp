package ;

import flash.events.UncaughtErrorEvent;
import flash.Lib;
import haxe.Http;

class Main {
	public function new() {
	}

	public static function main() {
		var token:String = "2edf73908d544a0aa8162475259dad94";

		Lib.current.stage.loaderInfo.uncaughtErrorEvents.addEventListener(UncaughtErrorEvent.UNCAUGHT_ERROR, onError);

//		haxe.Timer.delay(function() {
//			var str:String = null;
//			str.charAt(0);
//		}, 1000);

		try {
			var str:String = null;
			str.charAt(0);
		}
		catch(e:Dynamic) {
			sendError(e);
		}
	}

	static function onError(e:UncaughtErrorEvent) {
		var http:Http = new Http("");

		flash.Lib.current.stage.color = 0xffff0000;
		trace("hokeyapp test");

//		e.preventDefault();
	}

	static function sendError(e:Dynamic) {
		var log:String = "Package: de.codenauts.hockeyapp\nVersion: 33\nOS: 2.2\nManufacturer: HTC\nModel: HTC Desire\nDate: Sun Nov 27 17:35:08 GMT+01:00 2011\nCrashReporter Key: 1C6ADE7f-643E-A5F3-5CBF-E496CE21DEAA218624AF";

		var http:haxe.Http = new haxe.Http("https://rink.hockeyapp.net/api/2/apps/a58ae23d606d44349b691d57f690ae39/crashes/upload");
		http.setHeader("X-HockeyAppToken", "2edf73908d544a0aa8162475259dad94");
		http.setHeader("Content-Type", "application/x-www-form-urlencoded");
//		http.setParameter("log", log);
		http.onData = function(val:String){trace('data: $val');};
		http.onError = function(val:String){trace('error: $val');};
		http.request(true);
	}
}
