package ;

import hxhockeyapp.services.crashes.HockeyAppCrashesService;
import hxhockeyapp.services.transport.HockeyAppServerLoader;

#if flash
import flash.events.UncaughtErrorEvent;
import flash.Lib;
#elseif js
import js.Browser;
import js.html.ProgressEvent;
import js.html.XMLHttpRequestResponseType;
import js.html.XMLHttpRequest;
#end

import haxe.Http;

class Main {
	static var id:String = "da6c8f7efc6241a49b55c63ad29d4fa5";
	static var token:String = "2f6e1aeaaa2c4c5e9e66f893be9dc59c";
	static var url:String = "https://rink.hockeyapp.net/api/2/apps/";

	static var crashesUrl(get, never):String;
	static function get_crashesUrl():String {
		return '$url$id/crashes/upload';
	}

	static var crashesReasonUrl(get, never):String;
	static function get_crashesReasonUrl():String {
		return '$url$id/crash_reasons';
	}

	static var crashLog:String = "Package: test.app
Version: 0.3.24
Language: en-US
Platform: Win32
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/55.0.2883.87 Safari/537.36

TypeError: Cannot read property charAt of null
    at Function.Main.main (file:///D:/Storm/Repositories/hxhockeyapp/export/js/hockeyapp.js:10:6)
    at file:///D:/Storm/Repositories/hxhockeyapp/export/js/hockeyapp.js:134:6
    at file:///D:/Storm/Repositories/hxhockeyapp/export/js/hockeyapp.js:135:3";

	public function new() {
	}

	public static function main() {
#if flash
		Lib.current.stage.loaderInfo.uncaughtErrorEvents.addEventListener(UncaughtErrorEvent.UNCAUGHT_ERROR, onError);
#end

//		haxe.Timer.delay(function() {
//			var str:String = null;
//			str.charAt(0);
//		}, 1000);

		try {
			trace("try to get value from null");
			var str:String = null;
			str.charAt(0);
		}
		catch(e:Dynamic) {
			trace("exception catched");
			sendBaseCrash(e);
		}
	}

#if flash
	static function onError(e:UncaughtErrorEvent) {
		var http:Http = new Http("");

		flash.Lib.current.stage.color = 0xffff0000;
		trace("hokeyapp test");

//		e.preventDefault();
	}
#end

	static function sendError(e:Dynamic) {
		trace("send error");
#if flash
		var log:String = "Package: de.codenauts.hockeyapp\nVersion: 33\nOS: 2.2\nManufacturer: HTC\nModel: HTC Desire\nDate: Sun Nov 27 17:35:08 GMT+01:00 2011\nCrashReporter Key: 1C6ADE7f-643E-A5F3-5CBF-E496CE21DEAA218624AF";

		var http:haxe.Http = new haxe.Http(crashesUrl);
		http.setHeader("X-HockeyAppToken", token);
		http.setHeader("Content-Type", "application/json");
		http.setParameter("log", log);
		http.onData = function(val:String){trace('data: $val');};
		http.onError = function(val:String){trace('error: $val');};
		http.request(true);

#elseif js
		var vals:String = "";
		vals += "Package: " + "test.app.testapp \n";
		vals += "Version: " + "0.3.23\n";
		vals += "Language: " + Browser.window.navigator.language + "\n";
		vals += "Platform: " + Browser.window.navigator.platform + "\n";
		vals += "User-Agent: " + Browser.window.navigator.userAgent + "\n\n";
		vals += e.stack;

		var d:Dynamic = {"log":vals};

//		var log:String = "Package: de.codenauts.hockeyapp\nVersion: 33\nOS: 2.2\nManufacturer: HTC\nModel: HTC Desire\nDate: Sun Nov 27 17:35:08 GMT+01:00 2011\nCrashReporter Key: 1C6ADE7f-643E-A5F3-5CBF-E496CE21DEAA218624AF";
//
		var req:XMLHttpRequest = new XMLHttpRequest();
		//?log=" + vals
		req.open("GET", crashesReasonUrl, true);
		req.setRequestHeader("X-HockeyAppToken", token);
		req.setRequestHeader("Content-Type", "application/json");
//		req.setRequestHeader("Content-Type", "multipart/form-data");
//		req.setRequestHeader("Origin", Browser.location.hostname);
//		req.setRequestHeader("Access-Control-Allow-Origin", Browser.location.hostname);
		req.onload = function(val:Dynamic){
			sendCrash(e);
		};
		req.onerror = function(e:Dynamic){trace('error');};
		req.onprogress = function(e:ProgressEvent){trace('progress');};
		req.send(null);

//		var req:XMLHttpRequest = new XMLHttpRequest();
//		//?log=" + vals
//		req.open("POST", "https://rink.hockeyapp.net/api/2/apps/a58ae23d606d44349b691d57f690ae39/crashes/upload/", true);
//		req.setRequestHeader("X-HockeyAppToken", "2edf73908d544a0aa8162475259dad94");
////		req.setRequestHeader("Content-Type", "application/json");
//		req.setRequestHeader("Content-Type", "multipart/form-data");
////		req.setRequestHeader("Origin", Browser.location.hostname);
////		req.setRequestHeader("Access-Control-Allow-Origin", Browser.location.hostname);
//		req.onload = function(e:Dynamic){trace('data');};
//		req.onerror = function(e:Dynamic){trace('error');};
//		req.onprogress = function(e:ProgressEvent){trace('progress');};
//		req.send(null);


//		var http:haxe.Http = new haxe.Http("https://rink.hockeyapp.net/api/2/apps/a58ae23d606d44349b691d57f690ae39/crashes/upload");
//		http.setHeader("X-HockeyAppToken", "2edf73908d544a0aa8162475259dad94");
//		http.setHeader("Content-Type", "application/json");
////		http.setPostData(d);
//		http.setParameter("log", vals);
//		http.onData = function(val:String){trace('data: $val');};
//		http.onError = function(val:String){trace('error: $val');};
//		http.request(true);
#end
	}

	static function sendBaseCrash(e:Dynamic) {
		var service:HockeyAppCrashesService = new HockeyAppCrashesService(id, "0.3.36", "test.app");
		service.send(e);

//		var hasl:HockeyAppServerLoader = new HockeyAppServerLoader(crashesUrl);
//
//
//		var boundary:String = Std.string(Math.random()).substr(2);
//		var data:String = '\r\n--$boundary\r\nContent-Disposition: form-data; name="log"; filename="log.txt"
//Content-Type: text/plain
//
//$crashLog\r\n--$boundary--\r\n';
//
//		trace("multipart/form-data; boundary=" + boundary);
//		trace(data);
//
//		var http:Http = new Http(crashesUrl);
//		http.setHeader("Content-Type", "multipart/form-data; boundary=" + boundary);
//		http.setPostData(data);
//		http.onData = function(val:String){trace('data: $val');};
//		http.onError = function(val:String){trace('error: $val');};
//		http.request(true);
	}

	static function sendCrash(e:Dynamic) {
#if js
		var vals:String = "";
		vals += "Package: " + "test.app.testapp \n";
		vals += "Version: " + "0.3.23\n";
		vals += "Language: " + Browser.window.navigator.language + "\n";
		vals += "Platform: " + Browser.window.navigator.platform + "\n";
		vals += "User-Agent: " + Browser.window.navigator.userAgent + "\n\n";
		vals += e.stack;

		var req:XMLHttpRequest = new XMLHttpRequest();
		req.open("POST", crashesUrl, true);
//		req.setRequestHeader("X-HockeyAppToken", token);
//		req.setRequestHeader("Content-Type", "application/json");


		var boundary:String = Std.string(Math.random()).substr(2);
		var data:String = '\r\n--$boundary\r\nContent-Disposition: form-data; name="log"; filename="log.txt"
Content-Type: text/plain

$crashLog\r\n--$boundary--\r\n';

		trace("multipart/form-data; boundary=" + boundary);
		trace(data);
		req.setRequestHeader("Content-Type", "multipart/form-data; boundary=" + boundary);
		req.send(data);
#end
	}
}
