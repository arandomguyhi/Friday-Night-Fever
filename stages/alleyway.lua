local prefix = 'roboStage/'

luaDebugMode = true
function onCreate()
    setProperty('defaultCamZoom', songName == 'Bloom' and 0.6 or 0.7)

    makeLuaSprite('whittyBG', prefix..(songName == 'Bloom' and 'alleyway-night' or 'alleywaybroken'), -728, -230)
    setProperty('whittyBG.antialiasing', true)
    setScrollFactor('whittyBG', 0.9, 0.9)
    scaleObject('whittyBG', 1.25, 1.25, false)
    addLuaSprite('whittyBG')

    if songName == 'Princess' then
	makeLuaSprite('princessBG', prefix..'princessBG', -446, -611)
	setProperty('princessBG.antialiasing', true)
	setScrollFactor('princessBG', 0.75, 0.8)
	scaleObject('princessBG', 1.25, 1.25, false)
	addLuaSprite('princessBG')
	setProperty('princessBG.visible', false)

	makeLuaSprite('princessFloor', prefix..'princessFloor', -446, -611)
	setProperty('princessFloor.antialiasing', true)
	setScrollFactor('princessFloor', 0.9, 0.9)
	scaleObject('princessFloor', 1.25, 1.25, false)
	addLuaSprite('princessFloor')
	setProperty('princessFloor.visible', false)

	makeLuaSprite('princessCrystals', prefix..'princessCrystals', -446, -591)
	setProperty('princessCrystals.antialiasing', true)
	setScrollFactor('princessCrystals', 0.9, 0.9)
	scaleObject('princessCrystals', 1.25, 1.25, false)
	addLuaSprite('princessCrystals')
	setProperty('princessCrystals.visible', false)
	startTween('crystalTween', 'princessCrystals', {y = getProperty('princessCrystals.y') - 70}, 3.4, {type = 'pingpong'})
    elseif songName == 'Bloom' then
	makeLuaSprite('clocks', prefix..'princessClocks', 200, 80)
	scaleObject('clocks', 2.55, 2.55, false)
	setProperty('clocks.antialiasing', true)
	addLuaSprite('clocks')
	setProperty('clocks.visible', false)

	makeLuaSprite('clockScar', prefix..'princessClock', -190, 680)
	scaleObject('clockScar', 1.65, 1.65, false)
	setProperty('clockScar.antialiasing', true)
	addLuaSprite('clockScar')
	setProperty('clockScar.visible', false)

	makeLuaSprite('clockFever', prefix..'princessClock', 990, 695)
	scaleObject('clockFever', 1.25, 1.25, false)
	setProperty('clockFever.antialiasing', true)
	addLuaSprite('clockFever')
	setProperty('clockFever.visible', false)
    end
end

function onCreatePost()
    if songName == 'Bloom' then
	initLuaShader('WiggleEffect')

	setSpriteShader('clocks', 'WiggleEffect')
	setShaderInt('clocks', 'effectType', 4)
	setShaderFloat('clocks', 'uWaveAmplitude', 0.02)
	setShaderFloat('clocks', 'uFrequency', 3)
	setShaderFloat('clocks', 'uSpeed', 0.71)

	setProperty('dad.color', 0xA569BC)
	setProperty('boyfriend.color', 0xA569BC)
    end

    setProperty('boyfriend.x', 1085.2)
    setProperty('boyfriend.y', 375)
    setProperty('gf.x', 327)
    setProperty('gf.y', 40)

    setScrollFactor('boyfriend', 0.9, 0.9)
    setScrollFactor('gf', 0.9, 0.9)
end

local test = 0
function onUpdate(elapsed)
    test = test + elapsed
    if luaSpriteExists('clocks') then setShaderFloat('clocks', 'uTime', test) end
end

function onStepHit()
    if songName:lower() == 'princess' then
	if curStep == 128 then
	    cameraFlash('camHUD', 'FFFFFF', 0.5)
	    setProperty('princessBG.visible', true)
	    setProperty('princessFloor.visible', true)
	    setProperty('princessCrystals.visible', true)
	    setProperty('defaultCamZoom', 0.65)
	    setProperty('gf.y', getProperty('gf.y') + 60)
	end
    elseif songName:lower() == 'bloom' then
	if curStep == 256 then
	    setProperty('dad.color', 0xFFFFFF) setProperty('boyfriend.color', 0xFFFFFF)
	    setProperty('defaultCamZoom', 0.53)
	    cameraFlash('camHUD', 'FFFFFF', 0.5)
	    setProperty('clocks.visible', true)
	    setProperty('clockScar.visible', true)
	    setProperty('clockFever.visible', true)
	end
    end
end

function opponentNoteHit(id, noteData, noteType, isSustainNote)
    if songName:lower() == 'princess' and noteData == 2 then
	if curBeat == 309 or curBeat == 367 then
	    setProperty('dad.holdTimer', 0)
	    playAnim('dad', 'singLaugh', true) end
    end
end