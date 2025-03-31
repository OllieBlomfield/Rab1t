require("level")
require("game_over")

--sets window stuffs
love.window.setTitle("Tank-Rabbit")
love.graphics.setDefaultFilter("nearest","nearest")
love.window.setMode(800,600)

pixel_font = love.graphics.newFont('font/HomeVideoBold-R90Dv.ttf')
pixel_font:setFilter("nearest","nearest")
u_font = love.graphics.newFont('font/HomeVideo-BLG6G.ttf')
score=0
game_state = 2 --0 for menu, 1 for game, 2 for game_over

function love.load()
    if game_state==1 then
        level_init()
    elseif game_state==2 then
        over_init()
    end
end

function love.update(dt)
    if game_state==1 then
        level_update(dt)
    else
        over_update(dt)
    end
end

function love.draw()
    love.graphics.setFont(pixel_font)
    if game_state==1 then
        level_draw()
    elseif game_state==2 then
        over_draw()
    end
end