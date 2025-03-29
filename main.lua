--Rab1t by OB and Kudzo

--establishes all requirements (basically importing them)
push = require("push")
require("player")
require("enemy")
require("bullets")

--sets window stuffs
love.window.setTitle("Rab1t")
push:setupScreen(256, 192, 1024, 768, {false, false, false, true})


function love.load()

    --globals
    t=0 --temporary time variable (number of frames since start, should be change to use delta time when I work that out)
    
    --initialises objects
    player_init()
    enemy_init()
end

function love.update(dt)
    t = t + dt

    --updates objects
    player_update(dt)
    enemy_update(dt)
    bullet_update(dt)
end

--love.graphics.setBackgroundColor(0,0.8,0,0)
function love.draw()
    push:apply("start")
    love.graphics.setDefaultFilter("nearest","nearest")

    
    player_draw()
    enemy_draw()
    bullet_draw()

    push:apply("end")
end