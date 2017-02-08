package hxhockeyapp.transport;

class HockeyAppServerParameter {
	public var type(default, null):HockeyAppServerParameterType;
	public var name(default, null):String;
	public var value(default, null):String;

	public function new(name:String, value:String, type:HockeyAppServerParameterType = HockeyAppServerParameterType.VALUE) {
		this.name = name;
		this.value = value;
		this.type = type;
	}
}
