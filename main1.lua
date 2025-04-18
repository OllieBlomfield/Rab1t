--Rab1t by OB and kudzo

--establishes all requirements (basically importing them)
push = require("libraries/push")
require("player")
require("enemy")
require("bullets")
require("collision")
require("ui")
require("waves")

--sets window stuffs
love.window.setTitle("Tank-Rabbit")
love.graphics.setDefaultFilter("nearest","nearest")
--push:setupScreen(256, 192, 1024, 768, {false, false, false, true})
wave_num = 0

function love.load()
    --globals
    --wf = require("libraries/windfield") --handles physics
    --world = wf.newWorld(0,0)
    
    --[[world:addCollisionClass('Bullet', {ignores = {'Bullet'}})
    world:addCollisionClass('Player', {ignores = {'Bullet'}})
    world:addCollisionClass('Enemy', {ignores = {'Player'}})
    world:addCollisionClass('Ghost', {ignores = {'Ghost'}})
    ]]
    camera = require('libraries/camera')
    cam = camera()
    sti = require("libraries/sti")
    game_map = sti('map/map_final.lua')
    shake=0
    t=0 --temporary time variable (number of frames since start, should be change to use delta time when I work that out)
    
    --initialises objects
    player_init()
end

function love.update(dt)
    t = t + dt

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
    if #enemies == 0 then
        wave_num = wave_num + 1
        start_wave(wave_num)
    end
    shoot_effect_update(dt)

    --world:update(dt)
end

--love.graphics.setBackgroundColor(0,0.8,0,0)
function love.draw()
    --push:apply("start")

    cam:attach()
        game_map:drawLayer(game_map.layers["Tile Layer 1"])
        if not (plr.inv>0 and t%0.25>0.125) then
            player_draw()
        end
        enemy_draw()
        bullet_draw()
        shoot_effect_draw()
        
        
    cam:detach()
    
    ui_game_draw()
    --world:draw()

    --push:apply("end")

end