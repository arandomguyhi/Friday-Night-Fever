function onCreate()
    makeLuaSprite('spookyBG', 'week2bgtaki', -200, -100)
    setProperty('spookyBG.antialiasing', true)
    addLuaSprite('spookyBG')
end

function onCreatePost()
    setScrollFactor('gf', 1, 1)

    makeLuaSprite('moreDark') makeGraphic('moreDark', screenWidth, screenHeight, '000000')
    setProperty('moreDark.alpha', 0.498)
    scaleObject('moreDark', 1.5, 1.5, false)
    setObjectCamera('moreDark', 'camHUD')
    addLuaSprite('moreDark', true)
end