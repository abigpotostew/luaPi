time, timer = 0,0
bSmooth = false
lines = false

local hw_ratio = 1
local width, height = 0, 0
local h_width, h_height = 0, 0

local mouse = {x=0,y=0,dx=0,dy=0}

TWO_PI = math.pi * 2
HALF_PI = math.pi/2
SIXTH_PI = math.pi/6 --30 deg
THRD_PI = math.pi/3 --60 deg

local g = (1+math.sqrt(5))/2-1 --PHI
local ga = PI*2*g --phi angle

local function binomial()
	return math.random()-math.random()
end

local innerR, a, h, A, p = 10, 0, 0, 0, 0.003


local function map(value, in_from, in_to, out_from, out_to)
    return out_from+((value - in_from)/(in_to - in_from))*(out_to - out_from)
end

----------------------------------------------------
function setup()
	
	width = 900
	height = 900
	of.setWindowShape(width, height)
	
	h_width = width/2
	h_height = height/2
	hw_ratio = height / width
	

	of.setCircleResolution(50)
	math.randomseed(os.time())
	of.setWindowTitle("circles1")
	of.setFrameRate(30) -- if vertical sync is off, we can go a bit fast... this caps the framerate at 60fps
	of.setPolyMode(of.POLY.WINDING_NONZERO)
	of.noFill()
	
	
	of.setLineWidth(2)
	
	of.setBackgroundAuto(false)
	
	of.disableSmoothing()
	of.enableAlphaBlending()
	--of.disableBlendMode();
	
end


----------------------------------------------------
function update()
	dt = of.getElapsedTimef() - time
	time = of.getElapsedTimef() --seconds
	timer = timer + dt
	
	A = A +mouse.dx*0.00005
	mouse.dx = 0
end



--k required sin
--s optional scale
--o optional base offset
--example: norm_sin(k, 90, 10) returns value from [10..100]
local function norm_sin(k,s,o)
	return ((math.sin(k)+1)/2)*(s or 1) + (o or 0)
end
local function norm_cos(k,s,o)
	return ((math.cos(k)+1)/2)*(s or 1) + (o or 0)
end

----------------------------------------------------
function draw()
	
	of.clear(0,0,0)
	of.pushMatrix()
	of.translate(h_width,h_height)
	local a = A
	local r = innerR
	for i=1, 500 do
		a = a + ga + A
		r = r * 1.0099
		of.setColor(of.fromHsb(i/500*255,128,200,255))
		of.circle(math.cos(a)*r, math.sin(a)*r, r/14)
	end
	A = A + p * dt
	of.popMatrix()
end

----------------------------------------------------
function exit()
	print("script finished")
end

-- input callbacks

----------------------------------------------------
function keyPressed(key)
	if key == string.byte("s") then
		bSmooth = not bSmooth
		if bSmooth then of.enableSmoothing()
		else of.disableSmoothing() end
	end
	if key == string.byte('l') then
		lines = not lines
	end
end

function mouseMoved(x, y)
	mouse.dx, mouse.dy = x - mouse.x, y - mouse.y
	mouse.x, mouse.y = x, y
end

function mousePressed(x,y)
	--table.insert(lines, Line.new())
end

