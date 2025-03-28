function player_init()
    plr = {
        x=0,
        y=0,
        dx=0,
        dy=0,
        ship_sprite=love.graphics.newImage('sprites/ship/testShip.png')
        --plr_sprite
    }
end

function player_update()

end

function player_draw()
    love.graphics.draw(plr.ship_sprite,plr.x,plr.y)
end