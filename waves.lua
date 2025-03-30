
function start_wave(n)
    local num_enemies = math.ceil(11 * math.log(n))
    while num_enemies > 0 do
        local x = math.random(0, 2400) 
        local x_offset = math.random(-50, 50)
        local y_offset = math.random(-50,50)
        local list = {-1, 1}
        local y = 1200 + (list[math.random(#list)]) * math.sqrt(1200^2 - (x - 1200)^2)
        add_enemy(x + x_offset, y + y_offset)
        num_enemies = num_enemies - 1
    end
end