function onCreate()
    makeLuaSprite('church', 'bg_taki', -200, -100)
    setProperty('church.antialiasing', true)
    addLuaSprite('church')
end

function onCreatePost()
    setProperty('boyfriend.x', 1828)
    setProperty('boyfriend.y', 1148)

    setProperty('gf.x', 948)
    setProperty('gf.y', 722)
    setScrollFactor('gf', 1, 1)

    makeLuaSprite('purpleOverlay')
    makeGraphic('purpleOverlay', screenWidth, screenHeight, '800080')
    setProperty('purpleOverlay.alpha', 0.33)
    addLuaSprite('purpleOverlay')
    setObjectCamera('purpleOverlay', 'camHUD')
    scaleObject('purpleOverlay', 1.5, 1.5)
    setProperty('purpleOverlay.alpha', 0.21)
end