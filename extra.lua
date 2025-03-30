function lerp(a,b,t) -- a = current_value, b = target_value, t = percent max_value = 1
    return a * (1-t) + b * t
end