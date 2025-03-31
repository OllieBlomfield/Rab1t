health_bar_outline = love.graphics.newImage('sprites/UI/Health Bar/hp_outline.png')
health_bar_fill = love.graphics.newImage('sprites/UI/Health Bar/hp_bar.png')
health_bar_warning1 = love.graphics.newImage('sprites/UI/Health Bar/hp_warning1.png')
health_bar_warning2 = love.graphics.newImage('sprites/UI/Health Bar/hp_warning2.png')


function ui_game_init()
end

function ui_game_update()
end

function ui_game_draw()
    if mid_wave_timer>7 then love.graphics.print({{0,0,0},"wave end :)"},270,280,0,4,4) end
    if mid_wave_timer>0.3 and mid_wave_timer<2.5 and wave_num>0 then
        if mid_wave_timer>2.4 then shake=0.1+t end
        --love.graphics.print({{0.80784,0.57255,0.2824},"wave "..wave_num},300,300,0,3.1,3.1)
        --love.graphics.print({{0.95294,0.65882,0.2},"wave "..wave_num},300,280,0,3,3)
        love.graphics.print({{0,0,0},"wave "..wave_num},300,280,0,4,4)
    end
    
    fill_quad = love.graphics.newQuad(0,0,3*(5+91*plr.hp/plr.max_hp),48,health_bar_fill)
    love.graphics.draw(health_bar_outline,2,2)
    if plr.state==0 then
        love.graphics.draw(health_bar_fill,fill_quad,2,2)
    elseif t%1>0.5 then
        love.graphics.draw(health_bar_warning1,2,2)
    else
        love.graphics.draw(health_bar_warning2,2,2)
    end
end