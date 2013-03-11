print("Got this from git!")

while turtle.getFuelLevel() < 200 do
	if not turtle.refuel(1) then
		sleep(5)
		print("Out of fuel!")
	end
end

for i = 0,3 do
	if turtle.forward() then
		turtle.turnLeft()
	end
end