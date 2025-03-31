logo_image = love.graphics.newImage('sprites/titlecard.png')

function intro_draw()
    love.graphics.setDefaultFilter("nearest", "nearest")
    love.graphics.draw(logo_image,0,0)
    love.graphics.print({{0.8,0.8,0.8},"TANK RABBIT \npress x to start"},0,700,0,2,2)
    if love.keyboard.isDown('x') then
        level_init()
        game_state=1
    end
end