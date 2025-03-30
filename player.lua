local keyPress = ''


function player_init()
    plr = {
        state=1, --0 tank, 1 rabbit, 2 dead
        x=112,
        y=46,
        dx=0,
        dy=0,
        rot=0,
        bt_rot=0,
        hp=5,
        max_hp=5,
        tank_speed=30,
        rot_speed=2,
        rabbit_speed=6,
        reload_time=0,
        tank_sprite=love.graphics.newImage('sprites/tank/tank_top.png'),
        tank_base_sprite=love.graphics.newImage('sprites/tank/tank_bottom.png'),
        rabbit_idle_sprite = love.graphics.newImage('sprites/idlerabbit.png'),
        animation = newAnimation(love.graphics.newImage("sprites/weakplayer.png"), 32, 32, 0.3)

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

    plr.animation.currentTime = plr.animation.currentTime + dt
    if plr.animation.currentTime >= plr.animation.duration then
        plr.animation.currentTime = plr.animation.currentTime - plr.animation.duration
    end
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
        plr.bt_rot=plr.rot
    end

    if love.keyboard.isDown("s") then
        plr.x = plr.x - plr.tank_speed * math.cos(plr.rot) * dt
        plr.y = plr.y - plr.tank_speed * math.sin(plr.rot) * dt
        plr.bt_rot=plr.rot
    end

    if love.keyboard.isDown("m") and plr.reload_time==0 then
        
        add_bullet(plr.x+10*math.cos(plr.rot),plr.y+17*math.sin(plr.rot),plr.rot,90,1)
        plr.reload_time=0.3
    end
end

function love.keypressed(key)
    keyPress = key
end

function newAnimation(image, width, height, duration)
    local animation = {}
    animation.spriteSheet = image;
    animation.quads = {};

    for y = 0, image:getHeight() - height, height do
        for x = 0, image:getWidth() - width, width do
            table.insert(animation.quads, love.graphics.newQuad(x, y, width, height, image:getDimensions()))
        end
    end

    animation.duration = duration or 1
    animation.currentTime = 0

    return animation
end

function player_draw()
    if plr.state == 0 then
        --display player in tank mode
        love.graphics.draw(plr.tank_base_sprite,plr.x,plr.y,plr.bt_rot,1,1,7,8)
        love.graphics.draw(plr.tank_sprite,plr.x,plr.y,plr.rot,1,1,7,8)
        --love.graphics.circle('line',plr.x,plr.y,16)
    elseif plr.state == 1 then
        --display player in rabbit mode
        if math.abs(plr.dx) > 0.01 or math.abs(plr.dy) > 0.01 then
            --if moving
            local spriteNum = math.floor(plr.animation.currentTime / plr.animation.duration * #plr.animation.quads) + 1
            love.graphics.draw(plr.animation.spriteSheet, plr.animation.quads[spriteNum], plr.x, plr.y, 0, 0.5)
        else
            --if not moving
            plr.animation.currentTime = 0
            love.graphics.draw(plr.rabbit_idle_sprite, plr.x, plr.y, 0, 0.5)
        end
    end
end
