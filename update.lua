print("Running Wedge Update")

pos = vector.new(0,0,0)
rotation = 0
rotationCount = 4

rotationNames = {}
rotationNames[0] = "forward"
rotationNames[1] = "right"
rotationNames[2] = "back"
rotationNames[3] = "left"

rotationDirections = {}
rotationDirections[0] = vector.new(0,1,0)
rotationDirections[1] = vector.new(1,0,0)
rotationDirections[2] = vector.new(0,-1,0)
rotationDirections[3] = vector.new(-1,0,0)

function main()
	print(pos)
	while true do
		if not update() then
			break
		end
	end
end

function update()
	while turtle.getFuelLevel() < 200 do
		if not turtle.refuel(1) then
			sleep(5)
			print("Out of fuel!")
		end
	end
	
	turnAround()
	moveForward(2)
	turnLeft()
	moveForward(3)
	turnRight()
	moveForward()
	turnLeft()
	moveForward(2)
	returnHome()
end

function moveForward(units)
	if units == nil then
		print("UNITS WAS NIL")
		units = 1
	end
	
	for i = 1, units do
		if turtle.forward() then
			print(rotation)
			pos = pos + rotationDirections[rotation]
			print(pos)
		end
	end
end

function turnLeft()
	if turtle.turnLeft() then
		rotation = (rotation - 1) % rotationCount
	end
	print("rotation: " .. rotation)
end

function turnRight()
	if turtle.turnRight() then
		rotation = (rotation + 1) % rotationCount
	end
	print("rotation: " .. rotation)
end

function rotateBy(units)
	print("rotate by " .. units)
	while units > 0 do
		turnRight()
		units = units - 1
	end
	
	while units < 0 do
		turnLeft()
		units = units + 1
	end
end

function rotateTo(desiredRotation)
	print("rotate from " .. rotation .. " to " .. desiredRotation)
	local rotateAmount = (desiredRotation - rotation) % rotationCount
	if rotateAmount > 2 then
		rotateAmount = rotateAmount - rotationCount
	end
	rotateBy(rotateAmount)
end

function turnAround()
	rotateBy(2)
end

function returnHome()
	local move = -pos
	
	print("return home to: ")
	print(move)
	
	desiredRotation = 0
	if move.x > 0 then
		desiredRotation = 1
	else
		desiredRotation = 3
	end
	
	rotateTo(desiredRotation)
	moveForward(math.abs(move.x))
	
	if move.y > 0 then
		desiredRotation = 0
	else
		desiredRotation = 2
	end
	
	rotateTo(desiredRotation)
	moveForward(math.abs(move.y))
end

main()
