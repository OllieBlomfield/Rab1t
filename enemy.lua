enemies={}
enemy_img = love.graphics.newImage('sprites/Enemy_test.png')
require("collision")
require("player")

function add_enemy(x,y,spd)
    table.insert(enemies,{
        x=x,
        y=y,
        hp=3,
        spd=spd,
        animation = newAnimation(love.graphics.newImage("sprites/foxanimation.png"), 45, 32, 10),
        spriteNum = 1,
        timePassed = 0,
        facingRight = true
        --collider=world:newBSGRectangleCollider(x,y,16,16,8)
    })
end

function enemy_update(dt)
    for i,e in ipairs(enemies) do
        --e.collider:setFixedRotation(true)
        --plr.collider:setCollisionClass('Enemy')

        --sets enemy direction
        enemy_angle = math.atan2(plr.y - e.y, plr.x - e.x)
        e.x = e.x + e.spd * math.cos(enemy_angle) * dt
        e.y = e.y + e.spd * math.sin(enemy_angle) * dt

        if plr.x < e.x then 
            e.facingRight = false
        else 
            e.facingRight = true 
        end

        if circle_vs_circle(plr.x,plr.y,16,e.x+16,e.y+8,10) then
            if plr.state==0 and plr.inv==0 then
                plr.hp = plr.hp - 1
                plr.inv=plr.inv+2
            elseif plr.inv==0 then
                plr.state=2
            end
            table.remove(enemies,i)
        end
        --e.collider:setX(e.x)
        --e.collider:setY(e.y)
        e.timePassed = e.timePassed + dt
    end
end

function enemy_draw()
    for i,e in ipairs(enemies) do
        --love.graphics.circle('line',e.x+16,e.y+8,10)
        --love.graphics.draw(enemy_img,e.x,e.y)
        if e.timePassed > 0.27 then --prevents spazzing of animation
            e.spriteNum = e.spriteNum + 1
            e.timePassed = 0
        end

        if e.spriteNum > 4 then e.spriteNum = 1 end

        if e.facingRight then
            love.graphics.draw(e.animation.spriteSheet, e.animation.quads[e.spriteNum], e.x, e.y, 0, 1, 1)
        else
            love.graphics.draw(e.animation.spriteSheet, e.animation.quads[e.spriteNum], e.x + 45, e.y, 0, -1, 1)
        end
    end
end