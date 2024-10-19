local bunnies = {}

function onCreate()
    makeLuaSprite('bg', 'stages/week4/limo/bg', -1100, -360)
    setProperty('bg.antialiasing', true)
    scaleObject('bg', 0.9, 0.9, false)
    addLuaSprite('bg')

    makeAnimatedLuaSprite('lines', 'stages/week4/limo/road', -995, 500)
    addAnimationByPrefix('lines', 'idle', 'road', 24, true)
    playAnim('lines', 'idle')
    setProperty('lines.antialiasing', true)
    scaleObject('lines', 0.9, 0.9, false)
    addLuaSprite('lines')

    makeAnimatedLuaSprite('carBG', 'stages/week4/limo/limoBG', -845, 480)
    addAnimationByPrefix('carBG', 'idle', 'limobg', 24, true)
    playAnim('carBG', 'idle')
    setProperty('carBG.antialiasing', true)
    scaleObject('carBG', 0.9, 0.9, false)
    addLuaSprite('carBG')

    for i = 0, 2 do
	makeAnimatedLuaSprite('bunny'..i, 'stages/week4/limo/bunnyboppers', -145 + (160 * i), 236 - (30 * i))
	addAnimationByPrefix('bunny'..i, 'idle', 'bunnicus', 24, false)
	playAnim('bunny'..i, 'idle')
	setProperty('bunny'..i..'.antialiasing', true)
	scaleObject('bunny'..i, 0.9, 0.9, false)
	addLuaSprite('bunny'..i)
	table.insert(bunnies, 'bunny'..i)
    end

    makeAnimatedLuaSprite('carFG', 'stages/week4/limo/limoFG', -565, 555)
    addAnimationByPrefix('carFG', 'idle', 'limofg', 24, true)
    playAnim('carFG', 'idle')
    setProperty('carFG.antialiasing', true)
    scaleObject('carFG', 0.9, 0.9, false)
    addLuaSprite('carFG')
end

function onCreatePost()
    scaleObject('dad', 0.8, 0.8, false)
end

function onBeatHit()
    for i = 0, 2 do
	setProperty('bunny'..i..'.animation.curAnim.curFrame', 0)
	playAnim('bunny'..i, 'idle')
    end
end