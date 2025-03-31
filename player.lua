local keyPress = ''
require("extra")
require("shoot_effect")


function player_init()
    plr = {
        state=0, --0 tank, 1 rabbit, 2 dead
        x=1200,
        y=1200,
        dx=0,
        dy=0,
        rot=0,
        bt_rot=0,
        hp=5,
        inv=0,
        max_hp=5,
        bullet_spd=280,
        tank_speed=100,
        rot_speed=2,
        rabbit_speed=20,
        reload_time=0,
        tank_sprite=love.graphics.newImage('sprites/tank/tank_top.png'),
        tank_base_sprite=love.graphics.newImage('sprites/tank/tank_bottom.png'),
        rabbit_idle_sprite = love.graphics.newImage('sprites/idlerabbit.png'),
        animation = newAnimation(love.graphics.newImage("sprites/weakplayer.png"), 32, 32, 0.23),
        start_jump=false
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
    elseif plr.state==2 then
        game_state=2
    end
    
    --[[if plr.collider:enter('Enemy') then
        plr.state=1
    end]]

    plr.reload_time=math.max(plr.reload_time-dt,0)
    keyPress = ''

    plr.inv=math.max(0,plr.inv-dt)
    --plr.collider:setX(plr.x) 
    --plr.collider:setY(plr.y)
    
end

function rabbit_update(dt)
    plr.dx = plr.dx  * 0.5
    plr.dy = plr.dy  * 0.5
    if keyPress=='a' and plr.dx<0.01 and plr.dy<0.01 then
        plr.dx=-plr.rabbit_speed
        plr.start_jump=true
    end
    if keyPress=='d' and plr.dx<0.01 and plr.dy<0.01 then
        plr.dx=plr.rabbit_speed
        plr.start_jump=true
    end
    if keyPress=='w' and plr.dx<0.01 and plr.dy<0.01 then
        plr.dy=-plr.rabbit_speed
        plr.start_jump=true
    end
    if keyPress=='s' and plr.dx<0.01 and plr.dy<0.01 then
        plr.dy=plr.rabbit_speed
        plr.start_jump=true
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
        plr.bt_rot=lerp(plr.bt_rot,plr.rot,0.05)
    end

    if love.keyboard.isDown("s") then
        plr.x = plr.x - plr.tank_speed * math.cos(plr.rot) * dt
        plr.y = plr.y - plr.tank_speed * math.sin(plr.rot) * dt
        plr.bt_rot=lerp(plr.bt_rot,plr.rot,0.05)
    end

    if love.keyboard.isDown("m") and plr.reload_time==0 then
        local spx = (plr.x-5)+48*math.cos(plr.rot)
        local spy = (plr.y-8)+48*math.sin(plr.rot)
        add_shoot_effect(spx,spy)
        add_bullet(spx,spy,plr.rot,plr.bullet_spd,1)
        shake=0.1+t
        --add_bullet(plr.x,plr.y,plr.rot,90,1)
        plr.reload_time=0.3
    end

    if plr.hp<=0 then
        add_shoot_effect(plr.x-20,plr.y-16,5)
        plr.state=1
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
    if plr.state==0 then
        love.graphics.draw(plr.tank_base_sprite,plr.x,plr.y,plr.bt_rot,3,3,7,8)
        love.graphics.draw(plr.tank_sprite,plr.x,plr.y,plr.rot,3,3,7,8)
    elseif plr.state == 1 then
        --display player in rabbit mode
        if plr.start_jump then
            --if moving
            local spriteNum = math.floor(plr.animation.currentTime / plr.animation.duration * #plr.animation.quads) + 1
            if spriteNum >= 7 then plr.start_jump=false end
            love.graphics.draw(plr.animation.spriteSheet, plr.animation.quads[spriteNum], plr.x, plr.y,0,1,1)
            --plr.dx<0 and -1 or 1
        else
            --if not moving
            plr.animation.currentTime = 0
            love.graphics.draw(plr.rabbit_idle_sprite, plr.x, plr.y,0,1,1)
        end
    end
    --love.graphics.circle('line',1200+1.5*64,1200+1.5*48,140)
    if circle_vs_circle(plr.x,plr.y,48,1200+1.5*64,1200+1.5*48,140) and wave_num>0 and upgrade_menu==false then
        if mid_wave_timer>2.5 or plr.state==1 then
            love.graphics.print({{0,0,0},"x to enter barn"},plr.x-100,plr.y-40)
            if love.keyboard.isDown('x') and t>0.1 then upgrade_menu=true end
        else
            love.graphics.print({{0.8,0,0},"cannot enter barn"},plr.x-100,plr.y-40)
        end
    end

    --love.graphics.circle('line',plr.x+16,plr.y+16,16)

end