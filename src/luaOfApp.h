#pragma once

#include "ofMain.h"

#include "ofxLua.h"
#include "bindings/ofxLuaBindings.h" //bind of api to lua

class LuaOfApp : public ofBaseApp, ofxLuaListener{
   private:
      //const std::vector<std::string>* scripts;
      ofxLua lua;
      const std::string* script;
	public:
      LuaOfApp (const std::string* _script) :script(_script){}

		void setup();
		void update();
		void draw();
      void exit();
		
      // input
		void keyPressed(int key);
		void keyReleased(int key);
		void mouseMoved(int x, int y);
		void mouseDragged(int x, int y, int button);
		void mousePressed(int x, int y, int button);
		void mouseReleased(int x, int y, int button);

      // ofxLua error callback
      void errorReceived(string& msg);

		void windowResized(int w, int h);
		void dragEvent(ofDragInfo dragInfo);
		void gotMessage(ofMessage msg);
};
