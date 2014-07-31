#include "luaOfApp.h"


//--------------------------------------------------------------
void LuaOfApp::setup(){

   ofSetVerticalSync (true);
   //ofSetLogLevel("ofxLua", OF_LOG_VERBOSE);

   // Clear lua state
   lua.init (true);

   // Set error catching
   lua.addListener (this);

   // Bind of api
   lua.bind<ofxLuaBindings>();

   // Add script path to lua path so require() works correctly
   std::string fullpath = ofFilePath::getAbsolutePath(ofToDataPath(*script));
   std::string folder = ofFilePath::getEnclosingDirectory(fullpath);
   std::string new_path("package.path = '");
   new_path.append(folder);
   new_path.append("?.lua;' .. package.path;");
   lua.doString(new_path);

   // Run a script for the first pass
   lua.doScript (*script);

   // Call script's setup()
   lua.scriptSetup();
}

//--------------------------------------------------------------
void LuaOfApp::update(){
   lua.scriptUpdate();
}

//--------------------------------------------------------------
void LuaOfApp::draw(){
   lua.scriptDraw();
}

//--------------------------------------------------------------
void LuaOfApp::keyPressed(int key){
   lua.scriptKeyPressed (key);
}

//--------------------------------------------------------------
void LuaOfApp::keyReleased(int key){
   lua.scriptKeyReleased (key);
}

//--------------------------------------------------------------
void LuaOfApp::mouseMoved(int x, int y){
   lua.scriptMouseMoved (x, y);
}

//--------------------------------------------------------------
void LuaOfApp::mouseDragged(int x, int y, int button){
   lua.scriptMouseDragged (x, y, button);
}

//--------------------------------------------------------------
void LuaOfApp::mousePressed(int x, int y, int button){
   lua.scriptMousePressed (x, y, button);
}

//--------------------------------------------------------------
void LuaOfApp::mouseReleased(int x, int y, int button){
   lua.scriptMouseReleased (x, y, button);
}

//--------------------------------------------------------------
void LuaOfApp::windowResized(int w, int h){

}

//--------------------------------------------------------------
void LuaOfApp::gotMessage(ofMessage msg){

}

//--------------------------------------------------------------
void LuaOfApp::dragEvent(ofDragInfo dragInfo){ 

}

void LuaOfApp::errorReceived(string& msg){
   ofLogNotice() << "script error: " << msg;
}

void LuaOfApp::exit(){
   lua.scriptExit();

   lua.clear();
}
