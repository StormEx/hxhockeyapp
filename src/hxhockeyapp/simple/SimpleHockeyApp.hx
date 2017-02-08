package hxhockeyapp.simple;

import hxhockeyapp.transport.HockeyAppServerParameterType;
import hxhockeyapp.transport.HockeyAppServerParameter;
import hxhockeyapp.transport.HockeyAppServerLoader;
import hxhockeyapp.systeminfo.HockeyAppSystemInfo;

#if js
import js.Error;
import js.Browser;
import js.html.ErrorEvent;
#elseif flash
import flash.errors.Error;
import flash.events.ErrorEvent;
import flash.events.UncaughtErrorEvent;
import flash.Lib;
#end


class SimpleHockeyApp {
	static inline public var HOCKEY_APP_URL:String = "https://rink.hockeyapp.net/api/2/apps/";

	static var _appId:String = null;
	static var _appVersion:String = null;
	static var _appPackage:String = null;

	static var _info:HockeyAppSystemInfo = null;

	static public function setup(appId:String, appVersion:String, appPackage:String, catchUncaghtException:Bool = false) {
		_appId = appId;
		_appVersion = appVersion;
		_appPackage = appPackage;

		fillSystemInfo();

		if(catchUncaghtException) {
#if js
			Browser.window.addEventListener("error", onUncaghtError);
#elseif flash
			Lib.current.loaderInfo.uncaughtErrorEvents.addEventListener(UncaughtErrorEvent.UNCAUGHT_ERROR, onUncaghtError);
#end
		}
	}

#if js
	static function onUncaghtError(e:ErrorEvent) {
		trace(e);
		sendCallStack(e.error == null ? e.message : e.error.stack);
	}
#elseif flash
	static function onUncaghtError(e:UncaughtErrorEvent) {
		var callStack:String = "";
		var error:Error = Std.instance(e.error, Error);
		if(error == null) {
			callStack = e.toString();
		}
		else {
			callStack = error.getStackTrace();
		}

		sendCallStack(callStack);

		e.preventDefault();
	}
#end

	static public function sendCrash(e:Error, description:String = null, userId:String = null) {
#if js
		sendCallStack(e.stack, description, userId);
#elseif flash
		sendCallStack(e.getStackTrace(), description, userId);
#end
	}

	static function sendCallStack(callStack:String, description:String = null, userId:String = null) {
		if(_appId != null && _appId.length > 0 &&
		_appVersion != null && _appVersion.length > 0 &&
		_appPackage != null && _appPackage.length > 0 &&
		_info != null) {

			var info:String = '';

			info += _appPackage != null && _appPackage.length > 0 ? 'Package: $_appPackage\r\n' : "";
			info += _appVersion != null && _appVersion.length > 0 ? 'Version: $_appVersion\r\n' : "";
			info += _info.os != null && _info.os.length > 0 ? 'OS: ${_info.os}\r\n' : "";
			info += _info.manufacturer != null && _info.manufacturer.length > 0 ? 'Manufacturer: ${_info.manufacturer}\r\n' : "";
			info += _info.model != null && _info.model.length > 0 ? 'Model: ${_info.model}\r\n' : "";
			info += 'Date: ${DateTools.format(Date.now(), "%a %b %d %T GMT+00:00 %Y")}\r\n';
			info += _info.crashReporter != null && _info.crashReporter.length > 0 ? 'CrashReporter: ${_info.crashReporter}\r\n' : "";

			info = '${info}\r\n\r\n${callStack}';

			var params:Array<HockeyAppServerParameter> = [];
			params.push(new HockeyAppServerParameter("log", info, HockeyAppServerParameterType.FILE));
			if(description != null && description.length > 0) {
				params.push(new HockeyAppServerParameter("description", description, HockeyAppServerParameterType.FILE));
			}
			if(userId != null && userId.length > 0) {
				params.push(new HockeyAppServerParameter("userID", userId, HockeyAppServerParameterType.VALUE));
			}

			var url:String = '${HockeyApp.HOCKEY_APP_URL}$_appId/crashes/upload';

			var loader:HockeyAppServerLoader = new HockeyAppServerLoader(url, params);
			loader.onComplete = function(l:HockeyAppServerLoader) {
				if(l != null) {
					l.dispose();
					l = null;
				}
			};
			loader.load(true);
		}
	}

	static function fillSystemInfo() {
		if(_info == null) {
			_info = new HockeyAppSystemInfo();
		}
	}
}
