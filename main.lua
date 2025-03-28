--Rab1t by OB and Kudzo

--establishes all requirements (basically importing them)
push = require("push")
require("player")
require("enemy")

--sets window stuffs
love.window.setTitle("Rab1t")
--push:setupScreen(256, 192, 1024, 768, {false, false, false, true})


function love.load()

    --globals
    t=0 --temporary time variable (number of frames since start, should be change to use delta time when I work that out)
    
    --initialises objects
    player_init()
    enemy_init()
end

function love.update(dt)
    t = t + 1

    --updates objects
    player_update()
    enemy_update()
end

function love.draw()
    --push:apply("start")
    love.graphics.setDefaultFilter("nearest","nearest")

    player_draw()
    enemy_draw()

    --push:apply("end")
end