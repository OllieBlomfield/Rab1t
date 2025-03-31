enemies={}
enemy_img = love.graphics.newImage('sprites/Enemy_test.png')
require("collision")

function add_enemy(x,y,spd)
    table.insert(enemies,{
        x=x,
        y=y,
        hp=3,
        spd=spd,
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

        if (circle_vs_circle(plr.x,plr.y,48,e.x+16,e.y+16,16) and plr.state==0) or (circle_vs_circle(plr.x+16,plr.y+16,16,e.x+16,e.y+16,16) and plr.state==1) then
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
    end
end

function enemy_draw()
    for i,e in ipairs(enemies) do
        love.graphics.draw(enemy_img,e.x,e.y,0,2,2)
    end
end