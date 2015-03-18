--The Walking Guy

function love.load()
    
    require("AnAL")
    
    --background = love.graphics.newImage("bg.png")
    
    loader = require("AdvTiledLoader.Loader")
    loader.path = "map/" --Change this to wherever your .tmx files are
    map = loader.load("bg.tmx") --Change this to the name of your mapfile
    tx = 0
    ty = 0
    scale = 1 -- Adjust zoom with this

	anispeed = 0.1
	x = 364.5
	y = 249.5
	speed = 100	
    
    local imgup  = love.graphics.newImage("/hero/heroanimeup.png")
    walking_up = newAnimation(imgup, 71, 101, anispeed, 3)
    
    local imgdown  = love.graphics.newImage("/hero/heroanimedown.png")
    walking_down = newAnimation(imgdown, 71, 101, anispeed, 3)
    
    local imgright  = love.graphics.newImage("/hero/heroanimeright.png")
    walking_right = newAnimation(imgright, 71, 101, anispeed, 3)
    
    local imgleft  = love.graphics.newImage("/hero/heroanimeleft.png")
    walking_left = newAnimation(imgleft, 71, 101, anispeed, 3)
    
    local imgrightS  = love.graphics.newImage("/hero/5.png")
    heroRightS = newAnimation(imgrightS, 71, 101, 0.1, 0)
    
	local imgleftS = love.graphics.newImage("/hero/11.png")
	heroLeftS = newAnimation(imgleftS, 71, 101, 0.1, 0)
    
    local imgdownS = love.graphics.newImage("/hero/fstand.png")
    heroDownS = newAnimation(imgdownS, 71, 101, 0.1, 0)
    
    local imgupS  = love.graphics.newImage("/hero/1.png")
    heroUpS = newAnimation(imgupS, 71, 101, 0.1, 0)
      
    hero = heroDownS -- the player starts looking forward
end

function love.update(dt)

    walking_up:update(dt)
    walking_down:update(dt)
    walking_left:update(dt)
    walking_right:update(dt)
    
    if love.keyboard.isDown("w") then 
        ty = ty + speed*dt 
    end
    if love.keyboard.isDown("s") then 
        ty = ty - speed*dt 
    end
    if love.keyboard.isDown("a") then 
        tx = tx + speed*dt 
    end
    if love.keyboard.isDown("d") then 
        tx = tx - speed*dt 
    end

    -- keyboard actions for our hero
	if love.keyboard.isDown("a") then
		--x = x - (speed*dt)
		hero = walking_left
	elseif love.keyboard.isDown("d") then
		--x = x + (speed*dt)
		hero = walking_right
	elseif love.keyboard.isDown("w") then
		--y = y - (speed*dt)
		hero = walking_up
	elseif love.keyboard.isDown("s") then
		--y = y + (speed*dt)
		hero = walking_down
	end
	
	if love.keyboard.isDown("lshift") then
	    speed = 200
	    anispeed = 0.05
	end
	
	if love.keyboard.isDown("lctrl") then
	    speed = 50
	    anispeed = 0.15
	end
	
end

function love.keyreleased(key)
        if key == "a" then
            hero = heroLeftS
        elseif key == "w" then
            hero = heroUpS
        elseif key == "d" then
            hero = heroRightS
        elseif key == "s" then
            hero = heroDownS
        end
        
        if key == "lshift" then
            speed = 100
            anispeed = 0.1
        elseif key == "lctrl" then
            speed = 100
            anispeed = 0.1
        elseif key == "q" then
            speed = (speed+100)
        end
end

function love.draw()
	
	--love.graphics.draw(background)
	
	local ftx, fty = math.floor(tx), math.floor(ty)
    love.graphics.push()
    love.graphics.scale(scale)
    love.graphics.translate(ftx, fty)
    map:draw()
    love.graphics.pop()
  
	hero:draw(x, y)
    	
end
