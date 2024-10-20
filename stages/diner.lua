function onCreate()
    makeLuaSprite('bg', 'stages/week5/'..(songName == 'Party-Crasher' and 'yukichi' or 'diner'), -820, -200)
    setProperty('bg.antialiasing', true)
    setScrollFactor('bg', 0.9, 0.9)
    addLuaSprite('bg')

    makeLuaSprite('leo', 'stages/week5/leo', getProperty('bg.x') + 2087, getProperty('bg.y') + 171)
    setProperty('leo.origin.x', getProperty('leo.width') / 2) setProperty('leo.origin.y', getProperty('leo.height'))
    setProperty('leo.antialiasing', true)
    setScrollFactor('leo', 0.9, 0.9)
    scaleObject('leo', 0.9, 0.9, false)
    addLuaSprite('leo')

    makeAnimatedLuaSprite('bop', 'stages/week5/crowd', -420, 730)
    addAnimationByPrefix('bop', 'bop', 'people', 24, false)
    playAnim('bop', 'bop')
    setProperty('bop.antialiasing', true)
    setScrollFactor('bop', 0.85, 0.85)
    addLuaSprite('bop', true)
end

function onCreatePost()
    for _, i in pairs({'dad', 'gf', 'boyfriend'}) do
	setScrollFactor(i, 0.9, 0.9) end
end

function onBeatHit()
    playAnim('bop', 'bop')

    scaleObject('leo', 0.88, 0.9, false)
    startTween('leobop', 'leo.scale', {y = 0.86, x = 0.9}, crochet / 1000, {})
end