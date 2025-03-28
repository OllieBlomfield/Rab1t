
function love.load()
    require("player")
    require("enemy")
    player_init()
    enemy_init()
end

function love.update(dt)
    player_update()
    enemy_update()
    
end

function love.draw()
    player_draw()
    enemy_draw()
end