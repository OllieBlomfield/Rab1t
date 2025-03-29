health_bar_outline = love.graphics.newImage('sprites/UI/Health Bar/hp_outline.png')
health_bar_fill = love.graphics.newImage('sprites/UI/Health Bar/hp_bar.png')


function ui_game_init()
end

function ui_game_update()
end

function ui_game_draw()
    love.graphics.draw(health_bar_outline,2,2)
    love.graphics.draw(health_bar_fill,2,2)
end