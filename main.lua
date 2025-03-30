--Rab1t by OB and kudzo

--establishes all requirements (basically importing them)
push = require("libraries/push")
require("player")
require("enemy")
require("bullets")
require("collision")
require("ui")

--sets window stuffs
love.window.setTitle("Tank-Rabbit")
love.graphics.setDefaultFilter("nearest","nearest")
--push:setupScreen(256, 192, 1024, 768, {false, false, false, true})


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
    t=0 --temporary time variable (number of frames since start, should be change to use delta time when I work that out)
    
    --initialises objects
    player_init()
    add_enemy(0,0)
    add_enemy(150,95)
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



    enemy_update(dt)
    bullet_update(dt)

    --world:update(dt)
end

--love.graphics.setBackgroundColor(0,0.8,0,0)
function love.draw()
    --push:apply("start")

    cam:attach()
        game_map:drawLayer(game_map.layers["Tile Layer 1"])
        player_draw()
        enemy_draw()
        bullet_draw()
    cam:detach()

    ui_game_draw()
    --world:draw()

    --push:apply("end")

end