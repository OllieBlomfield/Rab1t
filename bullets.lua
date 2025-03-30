bullets = {}
bullet_img = love.graphics.newImage('sprites/Bullet_test2.png')

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
            if circle_vs_circle(b.x+4,b.y+4,4,e.x+8,e.y+8,8) then 
                table.remove(enemies,j) 
                table.remove(bullets,i)
            end
        end
    end
end

function bullet_draw()
    for i,b in ipairs(bullets) do
        love.graphics.draw(bullet_img,b.x,b.y,b.rot,1,1,4,8)
    end
end