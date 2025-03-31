shoot_effects = {}
shoot_anim = love.graphics.newImage('sprites/shoot_anim.png')

function add_shoot_effect(x,y,s)
    table.insert(shoot_effects,{
        x=x,
        y=y,
        frame=1,
        s=s or 1.5
    })
end

function shoot_effect_update(dt)
    for i,s in ipairs(shoot_effects) do
        s.frame= s.frame+dt*15
        if s.frame>=7 then
            table.remove(shoot_effects,i)
        end
    end
end

function shoot_effect_draw()
    for i,s in ipairs(shoot_effects) do
        qd = love.graphics.newQuad(math.floor(s.frame-1)*16,0,16,16,shoot_anim)
        love.graphics.draw(shoot_anim,qd,s.x,s.y,0,s.s,s.s)
    end
end