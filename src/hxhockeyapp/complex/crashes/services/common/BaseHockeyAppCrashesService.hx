package hxhockeyapp.complex.crashes.services.common;

import hxhockeyapp.transport.HockeyAppServerLoader;
import hxhockeyapp.transport.HockeyAppServerParameterType;
import hxhockeyapp.transport.HockeyAppServerParameter;

class BaseHockeyAppCrashesService {
	var _appId:String = null;
	var _appVersion:String = null;
	var _appPackage:String = null;
	var _osVersion(get, never):String;
	var _manufacturer(get, never):String;
	var _model(get, never):String;
	var _date(get, never):String;
	var _crashReporter(get, never):String;

	var _crashesUploadUrl(get, never):String;

	public function new(appId:String, appVersion:String, appPackage:String) {
		_appId = appId;
		_appVersion = appVersion;
		_appPackage = appPackage;
	}

	function getInfoBlock():String {
//		Package: de.codenauts.hockeyapp
//		Version: 33
//		OS: 2.2
//		Manufacturer: HTC
//		Model: HTC Desire
//		Date: Sun Nov 27 17:35:08 GMT+01:00 2011
//		CrashReporter Key: 1C6ADE7f-643E-A5F3-5CBF-E496CE21DEAA218624AF

		var info:String = '';

		info += getInfoPart("Package", _appPackage);
		info += getInfoPart("Version", _appVersion);
		info += getInfoPart("OS", _osVersion);
		info += getInfoPart("Manufacturer", _manufacturer);
		info += getInfoPart("Model", _model);
		info += getInfoPart("Date", _date);
		info += getInfoPart("CrashReporter", _crashReporter);

		return info;
	}

	function getInfoPart(prefix:String, data:String):String {
		return data != null && data.length > 0 ? '$prefix: $data\r\n' : "";
	}

	function sendCrash(callStack:String) {
		var data:String = '${getInfoBlock()}\r\n\r\n${callStack}';
		var param:HockeyAppServerParameter = new HockeyAppServerParameter("log", data, HockeyAppServerParameterType.FILE);

		trace("crash sended: \r\n" + data);

		var loader:HockeyAppServerLoader = new HockeyAppServerLoader(_crashesUploadUrl, [param]);
		loader.onComplete = onComplete;
		loader.load(true);
	}

	function onComplete(loader:HockeyAppServerLoader) {
		if(loader != null) {
			loader.dispose();
			loader = null;
		}
	}

	function get__crashesUploadUrl():String {
		return '${HockeyApp.HOCKEY_APP_URL}$_appId/crashes/upload';
	}

	function get__osVersion():String {
		return null;
	}

	function get__manufacturer():String {
		return null;
	}

	function get__model():String {
		return null;
	}

	function get__date():String {
		return DateTools.format(Date.now(), "%a %b %d %T GMT+00:00 %Y");
	}

	function get__crashReporter():String {
		return null;
	}
}
