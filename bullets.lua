bullets = {}
bullet_img = love.graphics.newImage('sprites/newcarrot.png')

function add_bullet(x,y,rot,spd,dmg)
    table.insert(bullets,{
        x=x,
        y=y,
        rot=rot,
        spd=spd,
        dmg=dmg,
        --collider = world:newBSGRectangleCollider(x,y,32,16,8)
    })
end

function bullet_update(dt)
    for i,b in ipairs(bullets) do
        --b.collider:setCollisionClass('Bullet')
        --b.collider:setAngle(b.rot)
        b.x = b.x + b.spd * math.cos(b.rot) * dt
        b.y = b.y + b.spd * math.sin(b.rot) * dt
        --b.collider:setX(b.x)
        --b.collider:setY(b.y)

        for j,e in ipairs(enemies) do
            if circle_vs_circle(b.x+4,b.y+4,4,e.x+22,e.y+10,16) then 
                table.remove(enemies,j) 
                table.remove(bullets,i)
                money = money + 1
                score = score + 1
                add_shoot_effect(e.x-10,e.y-10,4)
            end
        end
    end
end

function bullet_draw()
    for i,b in ipairs(bullets) do
        love.graphics.draw(bullet_img,b.x,b.y,b.rot,1.3,1.3,0,8)
    end
end