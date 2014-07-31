#include "ofMain.h"
//#include "ofGlProgrammableRenderer.h"
#include "luaOfApp.h"

#include "boost/program_options.hpp"

namespace 
{ 
   const size_t ERROR_IN_COMMAND_LINE = 1; 
   const size_t SUCCESS = 0; 
   const size_t ERROR_UNHANDLED_EXCEPTION = 2; 
          
} // namespace 


//========================================================================
int main( int argc, char** argv ){

   try { //Parse options
      
      int width = 1024;
      int height = 768;
      bool windowed = false;
      string script;

      namespace po = boost::program_options;
      po::options_description desc ("Options");
      desc.add_options()
         ("help,h",     "Print help message")
         ("windowed",   "Use windowed mode. Default is fullscreen.")
         ("width,w",    po::value<int>(), 
                        "Width of app window. Default 1024.")
         ("height,h",   po::value<int>(), 
                        "Height of app window. Default 768.")
         ("script,s",   po::value<std::string>()->required(), 
                        "Path to your lua script.")  
         ;

      po::variables_map vm;

      try { // Retreive options here
         po::store(po::parse_command_line(argc, argv, desc), vm);

         if (vm.count("help")){
            std::cout<< "LuaPi: execute a lua script in the fashion of an \
               OpenFrameworks app. Check here for documentation \
               https://github.com/danomatika/ofxLua." << 
               std::endl << desc << std::endl;
            return SUCCESS;
         }

         po::notify(vm);

      }
      catch (po::error& e){
         std::cerr << "ERROR: "<< e.what() << std::endl << std::endl;
         std::cerr << desc << std::endl;
         return ERROR_IN_COMMAND_LINE;
      }    //End retreive options    

      //Now actually get the options  
      
      script = vm["script"].as<std::string>();

      if (vm.count("width")){
         width = vm["width"].as<int>();
      }
      if (vm.count("height")){
         height = vm["height"].as<int>();
      }
      if (vm.count("windowed")){
         windowed = true;
      }

      
      // Now run our app with options ///////////////////////////////

   	// Setup the GL context
#ifdef TARGET_OPENGLES
      ofSetCurrentRenderer(ofGLProgrammableRenderer::TYPE);
#endif
      ofSetupOpenGL (width, height, windowed? OF_WINDOW: OF_FULLSCREEN);

	   // this kicks off the running of my app
	   // can be OF_WINDOW or OF_FULLSCREEN
	   // pass in width and height too:
	   ofRunApp ( new LuaOfApp (&script));
   }
   catch (std::exception& e){
      std::cerr << "Unhandled Exception reached the top of main: " 
              << e.what() << ", application will now exit" << std::endl; 
      return ERROR_UNHANDLED_EXCEPTION;
   } //End parse partions 
   
   return SUCCESS;
}
