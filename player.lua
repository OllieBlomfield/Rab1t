local keyPress = ''

function player_init()
    plr = {
        state=0, --0 tank, 1 rabbit, 2 dead
        x=112,
        y=46,
        dx=0,
        dy=0,
        rot=0,
        hp=5,
        tank_speed=30,
        rot_speed=2,
        rabbit_speed=10,
        reload_time=0,
        tank_sprite=love.graphics.newImage('sprites/ship/testShip.png'),
        --is_hopping=0,
        --plr_sprite
    }
    --plr.collider = world:newBSGRectangleCollider(112,46,32,32,5)
    --plr.collider:setFixedRotation(true)
    --plr.collider:setCollisionClass("Player")
end

function player_update(dt)
    if plr.state==0 then
        tank_update(dt)
    elseif plr.state==1 then
        rabbit_update(dt)
    end
    
    --[[if plr.collider:enter('Enemy') then
        plr.state=1
    end]]

    plr.reload_time=math.max(plr.reload_time-dt,0)
    keyPress = ''
    --plr.collider:setX(plr.x) 
    --plr.collider:setY(plr.y)
    
end

function rabbit_update(dt)
    plr.dx = plr.dx  * 0.5
    plr.dy = plr.dy  * 0.5
    if keyPress=='a' and plr.dx<0.01 and plr.dy<0.01 then
        plr.dx=-plr.rabbit_speed
    end
    if keyPress=='d' and plr.dx<0.01 and plr.dy<0.01 then
        plr.dx=plr.rabbit_speed
    end
    if keyPress=='w' and plr.dx<0.01 and plr.dy<0.01 then
        plr.dy=-plr.rabbit_speed
    end
    if keyPress=='s' and plr.dx<0.01 and plr.dy<0.01 then
        plr.dy=plr.rabbit_speed
    end
    plr.x = plr.x + plr.dx
    plr.y = plr.y + plr.dy
end

function tank_update(dt)
    if love.keyboard.isDown("d") then
        plr.rot = plr.rot + plr.rot_speed * dt
    end
    if love.keyboard.isDown("a") then
        plr.rot = plr.rot - plr.rot_speed * dt
    end

    if love.keyboard.isDown("w") then
        plr.x = plr.x + plr.tank_speed * math.cos(plr.rot) * dt
        plr.y = plr.y + plr.tank_speed * math.sin(plr.rot) * dt
    end

    if love.keyboard.isDown("s") then
        plr.x = plr.x - plr.tank_speed * math.cos(plr.rot) * dt
        plr.y = plr.y - plr.tank_speed * math.sin(plr.rot) * dt
    end

    if love.keyboard.isDown("m") and plr.reload_time==0 then
        add_bullet(plr.x,plr.y,plr.rot,90,1)
        plr.reload_time=0.3
    end
end

function love.keypressed(key)
    keyPress = key
end

function player_draw()
    love.graphics.draw(plr.tank_sprite,plr.x,plr.y,plr.rot,1,1,16,16)
    love.graphics.print(plr.hp,20,20,0,1,1)
end