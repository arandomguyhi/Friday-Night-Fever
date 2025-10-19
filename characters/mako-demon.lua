local floatY = 0
function onUpdate(elapsed)
    floatY = floatY + 0.1
    setProperty('dad.y', getProperty('dad.y') + math.sin(floatY))
end