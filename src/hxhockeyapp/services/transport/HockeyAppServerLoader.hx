package hxhockeyapp.services.transport;

import haxe.Http;

class HockeyAppServerLoader {
	public var onComplete:HockeyAppServerLoader->Void = null;

	public var isValid(get, never):Bool;
	public var isSuccess(default, null):Bool = false;
	public var isCompleted(default, null):Bool = false;

	var _http:Http = null;
	var _url:String = null;
	var _data:Array<HockeyAppServerParameter> = null;
	var _token:String = null;

	public function new(url:String, data:Array<HockeyAppServerParameter> = null, token:String = null) {
		_url = url;
		_data = data;
		_token = token;
	}

	public function dispose() {
		onComplete = null;

		_http = null;
		_url = null;
		_data = null;
		_token = null;

		isSuccess = false;
	}

	public function load(isPost:Bool = false) {
		if(isCompleted) {
			return;
		}

		if(!isValid) {
			complete(false);

			return;
		}

		var http:Http = createHtpp(isPost);
		http.onData = onData;
		http.onError = onError;
		http.request(isPost);
	}

	function createHtpp(isPost:Bool = false):Http {
		var http:Http = new Http(_url);

		if(isSimpleData()) {
			if(_data != null && _data.length > 0) {
				var data:String = "";
				for(p in _data) {
					data += ((data != "" ? '&' : '') + '${p.name}=${p.value}');
				}
				http.setHeader("Content-Type", "application/x-www-form-urlencoded");
				http.setPostData(data);
			}
		}
		else {
			var boundary:String = generateBoundary();
			var data:String = '';
			for(p in _data) {
				switch(p.type) {
					case HockeyAppServerParameterType.FILE:
						data += '\r\n--$boundary\r\nContent-Disposition: form-data; name="${p.name}"; filename="${p.name}.txt"\r\nContent-Type: text/plain\r\n\r\n${p.value}';
					default:
						data += '\r\n--$boundary\r\nContent-Disposition: form-data; name="${p.name}"r\n\r\n${p.value}';
				}
			}
			data += '\r\n--$boundary--\r\n';
			http.setHeader("Content-Type", "multipart/form-data; boundary=" + boundary);
			http.setPostData(data);
		}

		if(_token != null && _token.length > 0) {
			http.setHeader("X-HockeyAppToken", _token);
		}

		return http;
	}

	function performComplete() {
	}

	function performFail() {
	}

	function complete(isSuccess:Bool) {
		isSuccess ? performComplete() : performFail();

		this.isSuccess = isSuccess;
		isCompleted = true;

		if(onComplete != null) {
			onComplete(this);
		}
	}

	function generateBoundary():String {
		return Std.string(Math.random()).substr(2);
	}

	function isSimpleData():Bool {
		if(_data == null || _data.length == 0) {
			return true;
		}

		for(p in _data) {
			if(p.type == HockeyAppServerParameterType.FILE) {
				return false;
			}
		}

		return true;
	}

	function onData(val:String) {
		complete(true);
	}

	function onError(val:String) {
		complete(false);
	}

	inline function get_isValid():Bool {
		return _url != null && _url.length > 0;
	}
}
