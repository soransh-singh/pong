--[[main bfxr,p.1]]

math.randomseed(os.time())

Class = require 'Class'
push = require 'Push'

require 'Paddle'
require 'paddleai'
require 'Ball'

WIDTH = 800
HEIGHT = 460
score1 =0
score2 =0
speed =80

PADDLE_SPEED =200

state = 'pause'

sounds = {
		['paddle_hit'] = love.audio.newSource('paddle.mp3','static'),
		['point_scored'] = love.audio.newSource('over.mp3','static'),
		['wall_hit'] = love.audio.newSource('sidehit.mp3','static')
	}

mainFont = love.graphics.newFont('Minecraft.ttf',24)

function love.load()
	love.graphics.setFont(mainFont)
	love.window.setMode(WIDTH,HEIGHT,{
		resizable = true,
		vsync = true,
		fullscreen = false})

		paddle1 = Paddle(10,HEIGHT/2,20,80)
		paddle2 = Paddleai(770,HEIGHT/2,20,80)
		ball = Ball(WIDTH/2,HEIGHT/2,20,20)
end


function love.draw()
	ui()
	if state == 'pause' then
		love.graphics.print('Press ENTER to Continue',WIDTH/2-140,200)
	end
	paddle1:render()
	paddle2:render()	
	ball:render()
end

function ui()
	love.graphics.line(0,40,WIDTH,40)
	love.graphics.print('PONG !',WIDTH/2 - 30,10)
	love.graphics.print('SCORE : ' .. score1,0,10)
	love.graphics.print('SCORE : ' .. score2,WIDTH -140,10)
	if score1 == 3 then
	love.graphics.print('Player 1 Wins',WIDTH/2-70,150)
		state = 'pause'
	end
	if score2 == 3 then
		love.graphics.print('Player 2 Wins',WIDTH/2-70,150)
		state = 'pause'
	end
end



function love.update(dt)
   if state == 'play' then
	if ball:collides(paddle1)then
		ball.dx = -ball.dx
		ball.dy = math.random(-100,100)
		sounds['paddle_hit']:play()
	end
	if ball:collides(paddle2)then
		ball.dx = -ball.dx
		ball.dy = math.random(-100,100)
		sounds['paddle_hit']:play()
	end

	if ball.y <= 40 then
		ball.dy = -ball.dy
		ball.y = 40
		sounds['wall_hit']:play()
	end
	if ball.y >= HEIGHT - 20 then
		ball.dy = -ball.dy
		ball.y = HEIGHT - 20
		sounds['wall_hit']:play()
	end

	if ball.x < 0 then
		score2 =score2 +1
		sounds['point_scored']:play()
		ball:reset()
		ball.dx = 500
		
	end
	if ball.x > WIDTH then
		score1 =score1 +1
		sounds['point_scored']:play()
		ball:reset()
		ball.dx = -500
	end

	paddle1:update(dt)
	
	ball:update(dt)

	--[[paddle control for paddle1 ]]

	if love.keyboard.isDown('w') then
		paddle1.dy = -PADDLE_SPEED
	elseif love.keyboard.isDown('s')then
		paddle1.dy =  PADDLE_SPEED
	else
		paddle1.dy = 0
	end
	if ball.dx > 0 then
		paddle2:update(dt,ball.x,ball.y)
	end
	
    end
end



function love.keypressed(key)
	if key == 'escape' then

		love.event.quit()
	end
	if key == 'enter' or key == 'return' then
		if state == 'pause' then
			state = 'play'
		elseif state == 'play' then
			state = 'pause'
		end
		if score1 == 3 or score2 == 3 then
			score1=0
			score2=0
		end
	end
	
end