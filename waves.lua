
function start_wave(n)
    local num_enemies = math.ceil(11 * math.log(n))
    while num_enemies > 0 do
        local x = math.random(plr.x-500, plr.x+500) 
        local x_offset = math.random(-50, 50)
        local y_offset = math.random(-50,50)
        local list = {-1, 1}
        local y = 500 + (list[math.random(#list)]) * math.sqrt(500^2 - (x - plr.x)^2)
        add_enemy(x + x_offset, y + y_offset)
        num_enemies = num_enemies - 1
    end
end