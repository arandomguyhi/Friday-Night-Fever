function onCreate()
    makeLuaSprite('bg', 'stages/week2/images/takiBG')
    setProperty('bg.antialiasing', true)
    addLuaSprite('bg')
end

function onCreatePost()
    setScrollFactor('gf', 1, 1)

    makeLuaSprite('moreDark') makeGraphic('moreDark', 1280, 720, '000000')
    setProperty('moreDark.alpha', 0.498)
    scaleObject('moreDark', 1.5, 1.5, false)
    setObjectCamera('moreDark', 'camHUD')
    addLuaSprite('moreDark')
end