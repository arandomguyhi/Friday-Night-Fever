luaDebugMode = true

path='../week2/minus/'
cu=1

function createObject(name,x,y,anim)
    makeAnimatedLuaSprite('obj'..cu, path..name, getProperty('bg.x') + (x * getProperty('bg.scale.x')), getProperty('bg.y') + (y * getProperty('bg.scale.y')))
    addAnimationByPrefix('obj'..cu, 'i', #anim > 1 and anim or name, 24, true)
    playAnim('obj'..cu, 'i')
    setProperty('obj'..cu..'.origin.x',0) setProperty('obj'..cu..'.origin.y',0)
    scaleObject('obj'..cu, 1.5, 1.5, false)
    setProperty('obj'..cu..'.antialiasing', true)
    addLuaSprite('obj'..cu)
    cu=cu+1
end

function onCreate()
    makeLuaSprite('bg', path..'bg', -920, -840)
    setProperty('bg.origin.x',0) setProperty('bg.origin.y',0)
    scaleObject('bg', 1.5, 1.5, false)
    setProperty('bg.antialiasing', true)
    addLuaSprite('bg')

    createObject("monitors", 118, 578, "screen thing")
    createObject("creatura", 502, 417, "craetura")
    createObject("candles1", 1742, 198, "")
    createObject("candles2", 1512, 702, "")
    createObject("candles3", 691, 636, "")
end

function onCreatePost()
    setScrollFactor('gf', 1, 1)

    setProperty('boyfriendCameraOffset[0]', boyfriendName == 'bf-minus' and -850 or -550)
    setProperty('boyfriendCameraOffset[1]', boyfriendName == 'bf-minus' and -90 or -130)
end