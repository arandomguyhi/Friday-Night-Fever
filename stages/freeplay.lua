luaDebugMode = true
function onCreate()
    setProperty('camGame.zoom', 1)
    setProperty('camHUD.alpha', 0)
    startTween('hudalphie', 'camHUD', {alpha = 1}, 0.76, {ease = 'quadInOut'})

    makeLuaSprite('bg', 'freeplay/bg')
    setProperty('bg.antialiasing', true)
    addLuaSprite('bg')    

    makeAnimatedLuaSprite('peeps', 'freeplay/peeps', 19, 65)
    addAnimationByPrefix('peeps', 'bop', 'people', 24, false)
    playAnim('peeps', 'bop')
    setProperty('peeps.origin.x', 0) setProperty('peeps.origin.y', 0)
    scaleObject('peeps', 0.67, 0.67, false)
    setProperty('peeps.antialiasing', true)
    addLuaSprite('peeps')

    makeLuaSprite('chairs', 'freeplay/chairs', 319, 134)
    setProperty('chairs.antialiasing', true)
    addLuaSprite('chairs')

    makeLuaSprite('seats', 'freeplay/frontChairs')
    setProperty('seats.antialiasing', true)
    addLuaSprite('seats')

    if songName == 'Mechanical' then
	makeAnimatedLuaSprite('hands', 'characters/scarlet/hands')
	addAnimationByPrefix('hands', 'come', 'scarlet', 24, false)
	playAnim('hands', 'come')
	scaleObject('hands', 0.67, 0.67, false)
	setProperty('hands.antialiasing', true)
    end

    makeAnimatedLuaSprite('phands', 'characters/pepper/hands', 259, 16)
    addAnimationByPrefix('phands', 'idle', 'pepper', 24, false)
    playAnim('phands', 'idle')
    scaleObject('phands', 0.67, 0.67, false)
    setProperty('phands.antialiasing', true)

    makeAnimatedLuaSprite('classic', 'freeplay/classicm', 609, 456)
    addAnimationByPrefix('classic', 'n', 'Classicn', 0)
    addAnimationByPrefix('classic', 's', 'Classics', 0)
    playAnim('classic', not luaSpriteExists('hands') and 's' or 'n')
    scaleObject('classic', 0.67, 0.67, false)
    setProperty('classic.antialiasing', true)

    makeAnimatedLuaSprite('frenzy', 'freeplay/frenzym', 374, 456)
    addAnimationByPrefix('frenzy', 'n', 'Frenzyn', 0)
    addAnimationByPrefix('frenzy', 's', 'Frenzys', 0)
    playAnim('frenzy', not luaSpriteExists('hands') and 'n' or 's')
    scaleObject('frenzy', 0.67, 0.67, false)
    setProperty('frenzy.antialiasing', true)
end

function onCreatePost()
    callMethod('boyfriend.setPosition', {742, 115})
    callMethod('gf.setPosition', {154, 291})

    setProperty('dad.x', getProperty('dad.x') + 250)
    setProperty('dad.y', getProperty('dad.y') - 110)

    makeLuaSprite('table', 'freeplay/table', 257, 385)
    setProperty('table.antialiasing', true)
    addLuaSprite('table', true)
    addLuaSprite('classic', true)
    addLuaSprite('frenzy', true)

    if luaSpriteExists('hands') then
	setProperty('hands.visible', false)
	addLuaSprite('hands', true)
	callMethod('hands.setPosition', {getProperty('bg.x') + 255, getProperty('bg.y') + 350})
    end
    addLuaSprite('phands', true)

    if dadName == 'scarlet-freeplay' then
	scaleObject('dad', 0.67, 0.67, false)
	runHaxeCode([[
	    for (ii in dad.animOffsets.keys())
		dad.animOffsets[ii] = [dad.animOffsets[ii][0] * 0.67, dad.animOffsets[ii][1] * 0.67];
	]])
    end

    setProperty('isCameraOnForcedPos', true)
    setProperty('camGame.scroll.x', 0) setProperty('camGame.scroll.y', 0)
    setProperty('camFollow.x', 640) setProperty('camFollow.y', 360)
end

function onBeatHit()
    setProperty('peeps.animation.curAnim.curFrame', 0)
    setProperty('phands.animation.curAnim.curFrame', 0)

    playAnim('peeps', 'bop')
    playAnim('phands', 'idle')
end