require("player")
require("enemy")
require("bullets")
require("collision")
require("ui")
require("waves")



function level_init()
    wave_num = 1
    barn = love.graphics.newImage('sprites/barn.png')
    upgrade_background = love.graphics.newImage('sprites/upgrade_bg.png')
    arrow_img = love.graphics.newImage('sprites/arrow.png')
    camera = require('libraries/camera')
    cam = camera()
    sti = require("libraries/sti")
    game_map = sti('map/map_final.lua')
    shake=0
    in_wave=false
    mid_wave_timer=5
    upgrade_menu=false
    upgrade_selection=0
    money=0
    --score=0
    t=0 --temporary time variable (number of frames since start, should be change to use delta time when I work that out)
    
    --initialises objects
    player_init()
end

function level_update(dt)
    t = t + dt

    if not upgrade_menu then
        --updates objects
        player_update(dt)
        cam:lookAt(plr.x,plr.y)
        local w = love.graphics.getWidth()
        local h = love.graphics.getHeight()
        local map_w = game_map.width * game_map.tilewidth
        local map_h = game_map.height * game_map.tileheight

        if cam.x < w/2 then
            cam.x = w/2
        end

        if cam.y < h/2 then
            cam.y = h/2
        end

        if cam.x > (map_w - w/2) then
            cam.x = map_w - w/2
        end

        if cam.y > (map_h - h/2) then
            cam.y = map_h - h/2
        end

        if t < shake then
            local offx = love.math.random(-3, 3)
            local offy = love.math.random(-3, 3)
            cam:move(offx, offy)
        end

        enemy_update(dt)
        bullet_update(dt)
        if #enemies == 0 and in_wave then
            mid_wave_timer=8
            plr.hp= plr.hp + 1
            in_wave=false
        end
        if #enemies==0 and not in_wave and mid_wave_timer==0 then
            in_wave=true
            wave_num = wave_num + 1
            start_wave(wave_num)
        end
        mid_wave_timer = math.max(0,mid_wave_timer-dt)

        shoot_effect_update(dt)
    else
        if love.keyboard.isDown('z') then 
            upgrade_menu=false 
            upgrade_selection=0 
            if plr.state==1 then
                plr.state=0
                plr.hp=1
            end
        end

        if keyPress=='x' and money>=5 then
            score = score + 1
            if upgrade_selection==0 then
                plr.tank_speed = plr.tank_speed+5
            elseif upgrade_selection==1 then
                plr.max_hp = plr.max_hp+1
                plr.hp = plr.hp + 1
            elseif upgrade_selection==2 then
                plr.bullet_spd = plr.bullet_spd+1
            end
            money = money - 5
        end

        if keyPress=='s' then
            upgrade_selection = math.min(2,upgrade_selection+1)
        end
        if keyPress=='w' then
            upgrade_selection = math.max(0,upgrade_selection-1)
        end
    end

    keyPress = ''

end

function love.keyreleased(key)
    keyPress = key
end

function level_draw()
    
    cam:attach()
        game_map:drawLayer(game_map.layers["Tile Layer 1"])
        love.graphics.draw(barn,1200,1200,0,3,3)
        if not (plr.inv>0 and t%0.25>0.125) then
            player_draw()
        end
        enemy_draw()
        bullet_draw()
        shoot_effect_draw()
        
        
        
    cam:detach()

    

    --print("wave",700,560)
    love.graphics.setDefaultFilter("nearest","nearest")
    ui_game_draw()

    if upgrade_menu then
        love.graphics.setFont(u_font)
        love.graphics.draw(upgrade_background,400-4*32,300-4*64,0,4,4)
        love.graphics.print({{44/255,30/255,49/255},"UPGRADES, $5"},420-(4*32),320-(4*64),0,2,2)
        love.graphics.print({{44/255,30/255,49/255},"tank speed:"..plr.tank_speed},420-(4*32),350-(4*64),0,2,2)
        love.graphics.print({{44/255,30/255,49/255},"tank health:"..plr.max_hp},420-(4*32),380-(4*64),0,2,2)
        love.graphics.print({{44/255,30/255,49/255},"shot speed:"..plr.bullet_spd},420-(4*32),410-(4*64),0,2,2)

        love.graphics.print({{250/255,110/255,121/255},"cash:$"..money},412-(4*32),485,0,2,2)
        love.graphics.print({{44/255,30/255,49/255},"press z to exit"},412-(4*32),515,0,2,2)
        love.graphics.setFont(pixel_font)
        love.graphics.draw(arrow_img,260,(upgrade_selection*30)+345-4*64,0,2,2)
    end
end