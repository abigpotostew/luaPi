print("Running Example!")

counter = 0

----------------------------------------------------
function setup()
	print("script setup")

	of.background(255, 255, 255, 255)
	of.setWindowTitle("example")
	
	of.setFrameRate(60) -- if vertical sync is off, we can go a bit fast... this caps the framerate at 60fps
end

----------------------------------------------------
function update()
	counter = counter + 0.033
end

----------------------------------------------------
function draw()
end

----------------------------------------------------
function exit()
end

-- input callbacks

----------------------------------------------------
function keyPressed(key)
	if key == string.byte("q") then
      of.exit()
   end
end

