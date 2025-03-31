function over_init()

end

function over_update(dt)
    if love.keyboard.isDown('x') then
        level_init()
        game_state=1
    end
end

function over_draw()
    love.graphics.print("GAME OVER:"..score,0,0,0,5,5)
    love.graphics.print("press x to retry",0,50,0,3,3)
end