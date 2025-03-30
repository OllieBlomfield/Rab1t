function lerp(a,b,t) -- a = current_value, b = target_value, t = percent max_value = 1
    return a * (1-t) + b * t
end


--[[offset=4
offset_x=0
offset_y=0
function screen_shake(dt)
    local fade = 0.95
    offset = 0.15
    offset_x, offset_y = (20-math.random(40))*offset*dt, (20-math.random(40))*offset*dt
    offset= offset*fade
    if offset<0.05 then
      offset=0
      --offset_x=0
      --offset_y=0
    end
end]]