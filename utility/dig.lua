-- dig_task = { l = 0, w = 0, h = 0, dir = "forward" }
helpers = require("helpers")

util = {}
function util.make_dig_task(l, w, h, dir)
    local found = false
    for _, v in ipairs({ "forwards", "up", "down" }) do
        if dir == v then
            found = true
            break
        end
    end
    local dig_task = { l = l or 0, w = w or 0, h = h or 0, dir = dir or "forward" }
    local valid = found
    return valid, dig_task
end

function helpers.dig_forwards(x)
    for i = 1, x do
        if turtle.detect() then
            turtle.dig()
        end
        turtle.forward()
    end
end

function util.dig(dig_task)
    local x, y, z, dir = dig_task.l, dig_task.w, dig_task.h, dig_task.dir

    for i = 1, x do
        for j = 1, y do
            helpers.dig_forwards(z - 1)

            if i % 2 == 1 then
                turtle.turnRight()
                helpers.dig_forwards(1)
                turtle.turnRight()
            else
                turtle.turnLeft()
                helpers.dig_forwards(1)
                turtle.turnLeft()
            end
        end

        helpers.turnAround()
        if dir == "down" then
            helpers.dig_down(1)
        else
            helpers.dig_up(1)
        end
    end
end

return util
