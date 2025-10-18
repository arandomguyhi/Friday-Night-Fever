local floatX, floatY = 0, 0
function onUpdate(elapsed)
    floatX = floatX + 0.02
    setProperty('dad.x', getProperty('dad.x') + math.sin(floatX))
    floatY = floatY + 0.07
    setProperty('dad.y', getProperty('dad.y') + math.sin(floatY))
end