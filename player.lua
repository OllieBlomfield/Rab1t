function player_init()
    plr = {
        x=112,
        y=46,
        rot=0,
        speed=15,
        reload_time=0,
        ship_sprite=love.graphics.newImage('sprites/ship/testShip.png')
        --plr_sprite
    }
end

function player_update(dt)
    if love.keyboard.isDown("a") then
        plr.rot = plr.rot + 1 * dt
    end
    if love.keyboard.isDown("d") then
        plr.rot = plr.rot - 1 * dt
    end

    if love.keyboard.isDown("w") then
        plr.x = plr.x + plr.speed * math.cos(plr.rot) * dt
        plr.y = plr.y + plr.speed * math.sin(plr.rot) * dt
    end

    if love.keyboard.isDown("m") and plr.reload_time==0 then
        add_bullet(plr.x,plr.y,plr.rot,50,1)
        plr.reload_time=0.3
    end

    plr.reload_time=math.max(plr.reload_time-dt,0)
    
end

function player_draw()
    love.graphics.draw(plr.ship_sprite,plr.x,plr.y,plr.rot,1,1,16,16)
end