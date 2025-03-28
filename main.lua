shove = require("shove")


function love.load()
    require("player")
    require("enemy")
    shove.setResolution(160, 90, {fitMethod = "pixel"})
    shove.setWindowMode(1280, 720, {resizable = false})
    player_init()
    enemy_init()
end

function love.update(dt)
    player_update()
    enemy_update()
end

function love.draw()
    shove.beginDraw()
    player_draw()
    enemy_draw()
    shove.endDraw()
end