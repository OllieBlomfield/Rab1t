bullets = {}
bullet_img = love.graphics.newImage('sprites/ship/TestBullet.png')

function add_bullet(x,y,rot,spd,dmg)
    table.insert(bullets,{
        x=x,
        y=y,
        rot=rot,
        spd=spd,
        dmg=dmg,
    })
end

function bullet_update(dt)
    for i,b in ipairs(bullets) do
        b.x = b.x + b.spd * math.cos(b.rot) * dt
        b.y = b.y + b.spd * math.sin(b.rot) * dt
    end
end

function bullet_draw()
    for i,b in ipairs(bullets) do
        love.graphics.draw(bullet_img,b.x,b.y,b.rot,1,1,4,8)
    end
end