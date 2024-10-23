luaDebugMode = true
function onCreate()
    precacheImage('mechanicShit/paintingShit')

    makeLuaSprite('bg', 'week2bghallow', -200, -100)
    setProperty('bg.antialiasing', true)
    addLuaSprite('bg')

    if songName ~= 'Hallow' then
	makeLuaSprite('painting', 'week2bghallowpainting', -200, -100)
	setProperty('painting.antialiasing', true)
	addLuaSprite('painting')
	setProperty('painting.visible', false)

	createInstance('paste', 'objects.Character', {625, 66, 'gf-paste'})
	addInstance('paste')
	setProperty('paste.alpha', 0.001)
    end
end

function onCreatePost()
    makeLuaSprite('moreDark') makeGraphic('moreDark', 1280, 720, '000000')
    setProperty('moreDark.alpha', 0.498)
    scaleObject('moreDark', 1.5, 1.5, false)
    setObjectCamera('moreDark', 'camHUD')
    addLuaSprite('moreDark')
end

function onBeatHit()
    if callMethod('paste.exists', {''}) then
	callMethod('paste.dance', {''}) end
end

function onUpdate(elapsed)
    for i = 0, getProperty('notes.length')-1 do
	local noteStrumTime = getPropertyFromGroup('notes', i, 'strumTime') - getSongPosition()
	local noteToHit = getPropertyFromGroup('notes', i, 'noteType')

	if noteToHit == 'Hallow' then
	    if noteStrumTime <= 750 * playbackRate and noteStrumTime >= 718 then -- this is maybe dumb
		summonPainting()
	    end
	end
    end
end

function changeBG()
    if not luaSpriteExists('painting') then
	return end

    if curBeat > 0 then
	cameraFlash('camHUD', 'FFFFFF', 0.5)
    end

    setProperty('painting.visible', true) setProperty('moreDark.visible', false)
    setProperty('paste.alpha', 1) setObjectOrder('paste', getObjectOrder('gfGroup'))
    setProperty('gf.visible', false)
end

local paint = 1
function summonPainting()
    makeAnimatedLuaSprite('mechanic'..paint, 'mechanicShit/paintingShit', 1240, 300)
    addAnimationByPrefix('mechanic'..paint, 'idle', 'paintingShit', 30, false)
    playAnim('mechanic'..paint, 'idle')
    setProperty('mechanic'..paint..'.antialiasing', true)
    addLuaSprite('mechanic'..paint, true)

    runHaxeCode([[
	var mechanic = game.getLuaObject('mechanic]]..paint..[[');

	mechanic.animation.finishCallback = function(anim) {
	    mechanic.destroy();
	}
    ]])

    paint = paint + 1
end