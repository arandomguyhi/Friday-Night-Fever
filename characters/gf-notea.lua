local floatAngle, floatY = 0, 0
function onUpdate(elapsed)
    floatY = floatY + 0.07
    setProperty('gf.y', getProperty('gf.y') + math.sin(floatY))
    floatAngle = floatAngle + 0.05
    setProperty('gf.angle', math.sin(floatAngle))
end