function circle_vs_circle(c1x, c1y, r1, c2x, c2y, r2)
    local dx, dy = c1x - c2x, c1y - c2y
    local distSq = dx*dx + dy*dy
    local radii = r1 + r2
    if distSq > radii*radii then
      return false
    end
    return true
end