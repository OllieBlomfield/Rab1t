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
push:setupScreen(256, 192, 1024, 768, {false, false, false, true})


function love.load()
    --globals
    --wf = require("libraries/windfield") --handles physics
    --world = wf.newWorld(0,0)
    
    --[[world:addCollisionClass('Bullet', {ignores = {'Bullet'}})
    world:addCollisionClass('Player', {ignores = {'Bullet'}})
    world:addCollisionClass('Enemy', {ignores = {'Player'}})
    world:addCollisionClass('Ghost', {ignores = {'Ghost'}})
    ]]
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
    enemy_update(dt)
    bullet_update(dt)

    --world:update(dt)
end

--love.graphics.setBackgroundColor(0,0.8,0,0)
function love.draw()
    push:apply("start")
    

    
    player_draw()
    enemy_draw()
    bullet_draw()
    ui_game_draw()
    --world:draw()

    push:apply("end")

end