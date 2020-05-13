--[[Paddle]]

Paddleai = Class{}

function Paddleai:init(x,y,width,height)
	self.x =x
	self.y = y
	self.width = width
	self.height = height

	self.dy = 0
end

function Paddleai:update(dt,ballx,bally)
	if bally > (self.y + self.width) then
		self.dy = 90
	elseif bally <self.y + 5 then 
		self.dy = -90
	else
		self.dy = 0
	end
	if self.dy < 0 then
		self.y = math.max(40,self.y + self.dy*dt)
	elseif self.dy > 0 then
		self.y = math.min(380,self.y + self.dy*dt)
	end

	
end

function Paddleai:render()
	love.graphics.rectangle('fill', self.x, self.y ,self.width , self.height)
end


