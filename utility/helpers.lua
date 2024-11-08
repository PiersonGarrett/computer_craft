helpers = {}

function helpers.dig_forwards(x)
    for i = 1, x do
        if turtle.detect() then
            turtle.dig()
        end
        turtle.forward()
    end
end

function helpers.dig_up(x)
    if turtle.detectUp() then
        turtle.digUp()
    end
    turtle.up()
end

function helpers.dig_down(x)
    for i = 1, x do
        if turtle.detectDown() then
            turtle.digDown()
        end
        turtle.down()
    end
end

function helpers.find_next()
    repeat
        turtle.forward()
    until turtle.detect()
end

function helpers.turnAround()
    turtle.turnRight()
    turtle.turnRight()
end

function helpers.moveForward(x)
    for i = 1, x do -- Changed from 0 to 1
        turtle.forward()
    end
end

function helpers.moveUp(x)
    for i = 1, x do -- Changed from 0 to 1
        turtle.up()
    end
end

function helpers.moveDown(x)
    for i = 1, x do -- Changed from 0 to 1
        turtle.down()
    end
end

function helpers.dig_section_horizontal(w, h)
    helpers.dig_forwards(1)
    turtle.turnRight()
    dir = 1

    w = w - 1 -- adjust width so that turtle does actual
    for i = 1, h do
        helpers.dig_forwards(w)

        if i ~= h then
            helpers.dig_up()
        end
        helpers.turnAround()
        dir = -1 * dir
        print("dir: ", dir)
    end

    helpers.moveDown(h)
    if dir == 1 then
        turtle.turnLeft()
    else
        helpers.moveForward(w)
        turtle.turnRight()
    end
end

function helpers.dig_section_vertical(l, w, up)
    if up == -1 then
        helpers.dig_down(1)
        print("down")
    else
        helpers.dig_up(1)
        print("up")
    end

    turtle.turnRight()

    dir = 1

    w = w - 1 -- adjust width so that turtle does actual
    for i = 1, l do
        helpers.dig_forwards(w)
        if dir == 1 then
            turtle.turnLeft()
            helpers.dig_forwards(1)
            turtle.turnLeft()
        else
            turtle.turnRight()
            helpers.dig_forwards(1)
            turtle.turnRight()
        end
        dir = -1 * dir
    end

    if dir == 1 then
        helpers.turnAround()
        helpers.moveForward(w)
    end

    turtle.turnLeft()
    helpers.moveForward(l)
    helpers.turnAround()
end

function helpers.return_to_start(w, h, dir)
    if (dir == 1) and (w ~= 1 and h ~= 1) then
        helpers.turnAround()
    end
    helpers.moveDown(h)
    helpers.moveForward(w) -- Removed math.floor as it is not necessary
    turtle.turnRight()
end

function helpers.dig_tunnel(l, w, h)
    -- dig l sections of w x h
    print("l: ", l, "w: ", w, "h: ", h)
    for i = 1, l do -- Changed from 0 to 1
        -- dig w x h section
        helpers.dig_section_horizontal(w, h)
    end
    helpers.turnAround()
    helpers.moveForward(l)
    helpers.turnAround()
end

function helpers.dig_shaft(l, w, h, dir)
    print("l: ", l, "w: ", w, "h: ", h)
    for i = 1, h do
        helpers.dig_section_vertical(l, w, dir)
    end

    helpers.moveUp(h)
end

return helpers

-- local l tonumber(arg[1]) or 1
-- local w tonumber(arg[2]) or 1
-- local h tonumber(arg[3]) or 1
-- https://kb.netgear.com/9665/How-do-I-perform-a-factory-reset-on-my-NETGEAR-router
