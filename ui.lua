health_bar_outline = love.graphics.newImage('sprites/UI/Health Bar/hp_outline.png')
health_bar_fill = love.graphics.newImage('sprites/UI/Health Bar/hp_bar.png')
health_bar_warning1 = love.graphics.newImage('sprites/UI/Health Bar/hp_warning1.png')
health_bar_warning2 = love.graphics.newImage('sprites/UI/Health Bar/hp_warning2.png')


function ui_game_init()
end

function ui_game_update()
end

function ui_game_draw()
    --canvas:setFilter("nearest", "nearest")
    fill_quad = love.graphics.newQuad(0,0,5+91*plr.hp/plr.max_hp,16,health_bar_fill)
    love.graphics.draw(health_bar_outline,2,2,0,3,3)
    if plr.state==0 then
        love.graphics.draw(health_bar_fill,fill_quad,2,2,0,3,3)
    elseif t%1>0.5 then
        love.graphics.draw(health_bar_warning1,2,2,0,3,3)
    else
        love.graphics.draw(health_bar_warning2,2,2,0,3,3)
    end
end