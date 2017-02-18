package hxhockeyapp;

#if (hxhockeyapp_full && (flash || js))
import hxhockeyapp.complex.ComplexHockeyApp;

typedef HockeyApp = ComplexHockeyApp;
#else
import hxhockeyapp.simple.SimpleHockeyApp;

typedef HockeyApp = SimpleHockeyApp;
#end