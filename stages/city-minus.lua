luaDebugMode = true

function onCreate()
    makeLuaSprite('sky', 'roboStage/grando/sky', 290, -340)
    setScrollFactor('sky', 0.96, 0.96)
    setProperty('sky.antialiasing', true)
    scaleObject('sky', 1.65, 1.65, false)
    addLuaSprite('sky')

    makeLuaSprite('bg', 'roboStage/grando/bg', -370, -100)
    setProperty('bg.antialiasing', true)
    scaleObject('bg', 1.65, 1.65, false)
    addLuaSprite('bg')

    makeAnimatedLuaSprite('roach', 'roboStage/grando/roach', getProperty('bg.x') + (614 * 1.65) - 750, getProperty('bg.y') + (886 * 1.65) - 350)
    addAnimationByPrefix('roach', 'bop', 'roach', 24, false)
    setProperty('roach.antialiasing', true)
    scaleObject('roach', 1.65, 1.65, false)
    addLuaSprite('roach')
end

function onCreatePost()
    setScrollFactor('gf', 1, 1)
    setProperty('dad.x', getProperty('dad.x') - 150)
    setProperty('boyfriend.x', getProperty('boyfriend.x') + 230)
    setProperty('boyfriend.y', getProperty('boyfriend.y') - 75)
end

function onBeatHit()
    playAnim('roach', 'bop')
end