package hxhockeyapp;

#if (hxhockeyapp_simple && (flash || js))
import hxhockeyapp.simple.SimpleHockeyApp;

typedef HockeyApp = SimpleHockeyApp;
#else
import hxhockeyapp.complex.ComplexHockeyApp;

typedef HockeyApp = ComplexHockeyApp;
#end