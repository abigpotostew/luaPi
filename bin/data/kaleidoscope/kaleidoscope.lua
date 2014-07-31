

local time = 0
local time_scalar = 10
local bSmooth = false

local kaleidoscope_img = of.Image()

local shader = of.Shader()

local target = of.TARGET.CURRENT


local error = nil
----------------------------------------------------
function setup()
    width = of.getWidth()--800
    height = of.getHeight()--800
    h_width = width/2
    h_height = height/2

    of.setWindowTitle("kaleido")
    
    of.setFrameRate(30) -- if vertical sync is off, we can go a bit fast... this caps the framerate at 60fps
   
   local path_from_datadir_to_this = "kaleidoscope"  
   kaleidoscope_img:loadImage( path_from_datadir_to_this..
                    --"opal.jpg"
                    --"ballet.jpg"
                    --"ballet2.jpg"
                    --"eyes.jpg"
                    "volcano.jpg"
                    )
    
   of.setTextureWrap(of.Texture.WRAP.MIRRORED_REPEAT, of.Texture.WRAP.MIRRORED_REPEAT)

    shader:setUniform2i('resolution', width, height)
    
   --Load correct shader
    if target == of.TARGET.RASPBERRYPI then
      shader:load(path_from_datadir_to_this..'es2/kaleidoscope')
    elseif of.isGLProgrammableRenderer() then
        shader:load(path_from_datadir_to_this..'gl3/kaleidoscope')
    else
      shader:load(path_from_datadir_to_this..'gl2/kaleidoscope')
   end
    
    shader:setUniform2f('resolution', width, height)
    shader:setUniform2f('mouse', h_width, h_height)
    
    if not shader:isLoaded() then
        --og.Log()
    end
end

----------------------------------------------------
function update()
    time = of.getElapsedTimef()
end

----------------------------------------------------
function draw()
    of.clear(255,255,255,255)
    
    if not shader:isLoaded() then
        return
    end

    shader:beginShader()

    shader:setUniform2f('mouse',of.getMouseX(),of.getMouseY())
    shader:setUniform1f('time', of.getElapsedTimef()*time_scalar)
    shader:setUniform2f('resolution', width, height)
    
        kaleidoscope_img:draw(0,0,width,height) --this binds the texture and draws a plane with correct tex coords.

    shader:endShader()

end

----------------------------------------------------
function exit()
    --print("script finished")
end

-- input callbacks

----------------------------------------------------
function keyPressed(key)
   if key == string.byte("w") then
      time_scalar = time_scalar + 1
      print("w")
   elseif key == string.byte("q") then
      time_scalar = time_scalar - 1
      print("q")
   end
end

function mouseMoved(x, y)
    
end

