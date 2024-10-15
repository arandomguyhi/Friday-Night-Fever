addHaxeLibrary('FlxBasePoint', 'flixel.math')

local strumLine1Visible = true
local strumLine2Visible = true
local showOnlyStrums = false

luaDebugMode = true
function onCreate()
    setProperty('camZoomingMult', 0)

    showOnlyStrums = true
    strumLine1Visible = false
    strumLine2Visible = false
end

function onCreatePost()
    ogBF = {getProperty('boyfriend.x'), getProperty('boyfriend.y')}
    ogTaki = {getProperty('dad.x'), getProperty('dad.y')}
    ogGF = {getProperty('gf.x'), getProperty('gf.y')}
    ogBG = {getProperty('church.x'), getProperty('church.y')}

    runHaxeCode([[
	var trail = new flixel.addons.effects.FlxTrail(game.dad, null, 4, 24, 0.3, 0.069);
	trail.color = 0x0;
	setVar('trail', trail);
    ]])

    makeLuaSprite('darken')
    makeGraphic('darken', screenWidth, screenHeight, '000000')
    setScrollFactor('darken', 0, 0)
    setProperty('darken.alpha', 0)
end

function onUpdate(elapsed)
    if curStep == 1 then
	setHudZoom(1)
    end

    if curStep >= 128 and curStep < 130 then
	strumLine2Visible = true
	setCamZoom(0.65)
    end
	

    if curStep >= 128 and curStep < 152 then
	local currentBeat = (getSongPosition() / 1000)*(curBpm/60)
	for i=0,7 do
	    local note = i > 3 and 'defaultPlayerStrum' or 'defaultOpponentStrum'
	    setProperty((i > 3 and 'playerStrums' or 'opponentStrums')..'.members['..(i%4)..'].x', _G[note..'X'..(i%4)] + 12 * math.cos((currentBeat + i*0.25) * math.pi))
	    setProperty((i > 3 and 'playerStrums' or 'opponentStrums')..'.members['..(i%4)..'].y', _G[note..'Y'..(i%4)] + 12 * math.cos((currentBeat + i*0.25) * math.pi))
	end
    end

    if curStep >= 152 and curStep < 160 then
	local currentBeat = (getSongPosition() / 1000)*(curBpm/60)
	for i=0,7 do
	    local note = i > 3 and 'defaultPlayerStrum' or 'defaultOpponentStrum'
	    setProperty((i > 3 and 'playerStrums' or 'opponentStrums')..'.members['..(i%4)..'].x', _G[note..'X'..(i%4)] + 50 * math.cos((currentBeat + i*0.25) * math.pi))
	    setProperty((i > 3 and 'playerStrums' or 'opponentStrums')..'.members['..(i%4)..'].y', _G[note..'Y'..(i%4)] + 50 * math.cos((currentBeat + i*0.25) * math.pi))
	end
    end

    if curStep >= 160 and curStep < 184 then
	local currentBeat = (getSongPosition() / 1000)*(curBpm/60)
	for i=0,7 do
	    local note = i > 3 and 'defaultPlayerStrum' or 'defaultOpponentStrum'
	    setProperty((i > 3 and 'playerStrums' or 'opponentStrums')..'.members['..(i%4)..'].x', _G[note..'X'..(i%4)] + 12 * math.cos((currentBeat + i*0.25) * math.pi))
	    setProperty((i > 3 and 'playerStrums' or 'opponentStrums')..'.members['..(i%4)..'].y', _G[note..'Y'..(i%4)] + 12 * math.cos((currentBeat + i*0.25) * math.pi))
	end
    end

    if curStep >= 184 and curStep < 192 then
	local currentBeat = (getSongPosition() / 1000)*(curBpm/60)
	for i=0,7 do
	    local note = i > 3 and 'defaultPlayerStrum' or 'defaultOpponentStrum'
	    setProperty((i > 3 and 'playerStrums' or 'opponentStrums')..'.members['..(i%4)..'].x', _G[note..'X'..(i%4)] + -50 * math.cos((currentBeat + i*0.25) * math.pi))
	    setProperty((i > 3 and 'playerStrums' or 'opponentStrums')..'.members['..(i%4)..'].y', _G[note..'Y'..(i%4)] + -50 * math.cos((currentBeat + i*0.25) * math.pi))
	end
    end

    if curStep == 192 then
	strumLine1Visible = true
    end

    if curStep >= 192 and curStep < 216 then
	local currentBeat = (getSongPosition() / 1000)*(curBpm/60)
	for i=0,7 do
	    local note = i > 3 and 'defaultPlayerStrum' or 'defaultOpponentStrum'
	    setProperty((i > 3 and 'playerStrums' or 'opponentStrums')..'.members['..(i%4)..'].x', _G[note..'X'..(i%4)] + 12 * math.cos((currentBeat + i*0.25) * math.pi))
	    setProperty((i > 3 and 'playerStrums' or 'opponentStrums')..'.members['..(i%4)..'].y', _G[note..'Y'..(i%4)] + 12 * math.cos((currentBeat + i*0.25) * math.pi))
	end
    end

    if curStep >= 216 and curStep < 224 then
	local currentBeat = (getSongPosition() / 1000)*(curBpm/60)
	for i=0,7 do
	    local note = i > 3 and 'defaultPlayerStrum' or 'defaultOpponentStrum'
	    setProperty((i > 3 and 'playerStrums' or 'opponentStrums')..'.members['..(i%4)..'].x', _G[note..'X'..(i%4)] + 50 * math.cos((currentBeat + i*0.25) * math.pi))
	    setProperty((i > 3 and 'playerStrums' or 'opponentStrums')..'.members['..(i%4)..'].y', _G[note..'Y'..(i%4)] + 50 * math.cos((currentBeat + i*0.25) * math.pi))
	end
    end

    if curStep >= 224 and curStep < 248 then
	local currentBeat = (getSongPosition() / 1000)*(curBpm/60)
	for i=0,7 do
	    local note = i > 3 and 'defaultPlayerStrum' or 'defaultOpponentStrum'
	    setProperty((i > 3 and 'playerStrums' or 'opponentStrums')..'.members['..(i%4)..'].x', _G[note..'X'..(i%4)] + 12 * math.cos((currentBeat + i*0.25) * math.pi))
	    setProperty((i > 3 and 'playerStrums' or 'opponentStrums')..'.members['..(i%4)..'].y', _G[note..'Y'..(i%4)] + 12 * math.cos((currentBeat + i*0.25) * math.pi))
	end
    end

    if curStep >= 248 and curStep < 256 then
	local currentBeat = (getSongPosition() / 1000)*(curBpm/60)
	for i=0,7 do
	    local note = i > 3 and 'defaultPlayerStrum' or 'defaultOpponentStrum'
	    setProperty((i > 3 and 'playerStrums' or 'opponentStrums')..'.members['..(i%4)..'].x', _G[note..'X'..(i%4)] + 50 * math.cos((currentBeat + i*0.25) * math.pi))
	    setProperty((i > 3 and 'playerStrums' or 'opponentStrums')..'.members['..(i%4)..'].y', _G[note..'Y'..(i%4)] + 5 * math.cos((currentBeat + i*0.25) * math.pi))
	end
    end


    if curStep == 256 or curStep == 624 or curStep == 888 or curStep == 1776 or curStep == 2048 then
	for i=0, 7 do
	    local note = i > 3 and 'defaultPlayerStrum' or 'defaultOpponentStrum'
	    startTween('culol'..i, (i > 3 and 'playerStrums' or 'opponentStrums')..'.members['..(i%4)..']', {x = _G[note..'X'..(i%4)], y = _G[note..'Y'..(i%4)], angle = 0}, 0.6, {})
	end
    end


    if curStep == 256 then
	showOnlyStrums = false
    end


    if curStep == 322 or curStep == 1346 or curStep == 1858 then
	setCamZoom(0.51)
	setHudZoom(1.01)
    end

    if curStep == 326 or curStep == 1350 or curStep == 1862 then
	setCamZoom(0.51)
	setHudZoom(1.01)
    end

    if curStep == 330 or curStep == 1354 or curStep == 1866 then
	setCamZoom(0.51)
	setHudZoom(1.01)
    end

    if curStep == 334 or curStep == 1358 or curStep == 1870 then
	setCamZoom(0.51)
	setHudZoom(1.01)
    end

    if curStep == 338 or curStep == 1362 or curStep == 1874 then
	setCamZoom(0.51)
	setHudZoom(1.01)
    end

    if curStep == 342 or curStep == 1366 or curStep == 1878 then
	setCamZoom(0.51)
	setHudZoom(1.01)
    end

    if curStep == 346 or curStep == 1370 or curStep == 1882 then
	setCamZoom(0.51)
	setHudZoom(1.01)
    end

    if curStep == 350 or curStep == 1374 or curStep == 1886 then
	setCamZoom(0.51)
	setHudZoom(1.01)
    end


    if curStep >= 384 and curStep < 512 or curStep >= 640 and curStep < 768 or curStep >= 1408 and curStep < 1536 then
	local currentBeat = (getSongPosition() / 1000)*(curBpm/60)
	for i=0,7 do
	    local note = i > 3 and 'defaultPlayerStrum' or 'defaultOpponentStrum'
	    setProperty((i > 3 and 'playerStrums' or 'opponentStrums')..'.members['..(i%4)..'].y', _G[note..'Y'..(i%4)] + 10 * math.cos((currentBeat + i*0.25) * math.pi))
	end
    end

    if curStep >= 512 and curStep < 624 or curStep >= 768 and curStep < 888 or curStep >= 1536 and curStep < 1664 then
	local currentBeat = (getSongPosition() / 1000)*(curBpm/60)
	for i=0,7 do
	    local note = i > 3 and 'defaultPlayerStrum' or 'defaultOpponentStrum'
	    setProperty((i > 3 and 'playerStrums' or 'opponentStrums')..'.members['..(i%4)..'].x', _G[note..'X'..(i%4)] + 10 * math.cos((currentBeat + i*0.25) * math.pi))
	end
    end

    if curStep >= 1664 and curStep < 1728 then
	local currentBeat = (getSongPosition() / 1000)*(curBpm/60)
	for i=0,7 do
	    local note = i > 3 and 'defaultPlayerStrum' or 'defaultOpponentStrum'
	    setProperty((i > 3 and 'playerStrums' or 'opponentStrums')..'.members['..(i%4)..'].x', _G[note..'X'..(i%4)] + 20 * math.cos((currentBeat + i*0.25) * math.pi))
	    setProperty((i > 3 and 'playerStrums' or 'opponentStrums')..'.members['..(i%4)..'].y', _G[note..'Y'..(i%4)] + 20 * math.cos((currentBeat + i*0.25) * math.pi))
	end
    end

    if curStep >= 1728 and curStep < 1776 then
	local currentBeat = (getSongPosition() / 1000)*(curBpm/60)
	for i=0,7 do
	    local note = i > 3 and 'defaultPlayerStrum' or 'defaultOpponentStrum'
	    setProperty((i > 3 and 'playerStrums' or 'opponentStrums')..'.members['..(i%4)..'].x', _G[note..'X'..(i%4)] + 10 * math.cos((currentBeat + i*0.25) * math.pi))
	    setProperty((i > 3 and 'playerStrums' or 'opponentStrums')..'.members['..(i%4)..'].y', _G[note..'Y'..(i%4)] + 10 * math.cos((currentBeat + i*0.25) * math.pi))
	end
    end



    if curStep >= 896 and curStep < 1152 or curStep >= 1920 and curStep < 2048 then
	local currentBeat = (getSongPosition() / 1000)*(curBpm/240)
	for i=0,7 do
	    local note = i > 3 and 'defaultPlayerStrum' or 'defaultOpponentStrum'
	    setProperty((i > 3 and 'playerStrums' or 'opponentStrums')..'.members['..(i%4)..'].x', _G[note..'X'..(i%4)] + 25 * math.cos((currentBeat + i*0.25) * math.pi))
	    setProperty((i > 3 and 'playerStrums' or 'opponentStrums')..'.members['..(i%4)..'].y', _G[note..'Y'..(i%4)] + 10 * math.cos((currentBeat + i*0.25) * math.pi))
	end
    end


    if curStep == 1152 then
	showOnlyStrums = true
	strumLine1Visible = false
	strumLine2Visible = false
    end

    if curStep == 1920 then
	showOnlyStrums = true
	strumLine2Visible = false
    end

    if curStep == 2048 then
	strumLine1Visible = false
	showOnlyStrums = false
    end

    if curStep == 2072 then
	showOnlyStrums = true
    end


    if curStep == 1280 then
	showOnlyStrums = false
	strumLine1Visible = true
	strumLine2Visible = true
	for i=0, 7 do
	    local note = i > 3 and 'defaultPlayerStrum' or 'defaultOpponentStrum'
	    startTween('culol'..i, (i > 3 and 'playerStrums' or 'opponentStrums')..'.members['..(i%4)..']', {x = _G[note..'X'..(i%4)], y = _G[note..'Y'..(i%4)], angle = 0}, 0.6, {})
	end
    end

    if curStep >= 1392 and curStep < 1404 then
	setCamZoom(0.7)
	showOnlyStrums = true
	strumLine1Visible = false
	strumLine2Visible = false
    end

    if curStep == 1404 then
	showOnlyStrums = false
	strumLine1Visible = true
	strumLine2Visible = true
    end

    for _, i in pairs({'healthBar', 'healthBar.bg', 'iconP1', 'iconP2', 'scoreTxt'}) do
	setProperty(i..'.visible', not showOnlyStrums)
    end

    for i = 0, 3 do
	setProperty('strumLineNotes.members['..i..'].visible', strumLine1Visible)
	setProperty('strumLineNotes.members['..i..'].alpha', strumLine1Visible and 1 or 0.001)
	setProperty('playerStrums.members['..i..'].visible', strumLine2Visible)
	setProperty('playerStrums.members['..i..'].alpha', strumLine2Visible and 1 or 0.001)
    end

    if curBeat >= 96 and curBeat < 224 or curBeat >= 344 and curBeat < 348 or curBeat >= 352 and curBeat < 448 then
	setProperty('camZooming', false)
    elseif curBeat >= 224 and curBeat < 344 or curBeat >= 348 and curBeat < 352 or curBeat >= 448 then
	setProperty('camZooming', true)
    end
end

function onBeatHit()
    if curStep >= 256 and curStep < 350 or curStep >= 640 and curStep < 886 or curStep >= 1280 and curStep < 1374 or curStep >= 1792 and curStep < 1886 or curStep >= 1408 and curStep < 1772 then
	setCamZoom(0.51)
	setHudZoom(1.01)
    end

    if curStep >= 384 and curStep < 622 or curStep >= 1024 and curStep < 1150 then
	setCamZoom(0.525)
	setHudZoom(1.025)
    end

    if curBeat == 96 then
	showOnlyStrums = true
	for _, i in pairs({'dad', 'gf', 'boyfriend'}) do
	    callMethod(i..'.setColorTransform', {0, 0, 0, 1, 255, 255, 255})
	end
	setProperty('church.color', 0x0)

	setProperty('purpleOverlay.visible', false)
	setProperty('camZooming', false)
	startTween('zoomin', 'camGame', {zoom = getProperty('camGame.zoom') + 0.2}, 7, {onComplete = 'zoomAgain'})
	function zoomAgain()
	    startTween('zoomout', 'camGame', {zoom = getProperty('camGame.zoom') - 0.2}, 3.5, {})
	end
    end

    if curBeat == 124 or curBeat == 126 or curBeat == 128 or curBeat == 156 or curBeat == 158 then
	for _, i in pairs({'dad', 'boyfriend', 'gf'}) do
	    callMethodFromClass('flixel.tweens.FlxTween', 'cancelTweensOf', {instanceArg(i)})
	    setProperty(i..'.alpha', 1)
	    if curBeat ~= 128 then
		startTween('bye'..i, i, {alpha = 0}, crochet / 1000, {}) end

	    callMethod(i..'.setColorTransform', {0,0,0,1,0,0,0})
	    setProperty(i..'.color', 0x0)
	end

	if curBeat == 128 then
	    setProperty('gf.visible', false)
	    startTween('daddy', 'dad', {x = getProperty('dad.x') + 100}, 0.15, {ease = 'smoothStepInOut'})
	    startTween('boyfi', 'boyfriend', {x = getProperty('boyfriend.x') - 100}, 0.15, {ease = 'smoothStepInOut'})

	    setProperty('isCameraOnForcedPos', true)
	    setProperty('camFollow.x', getVar('gfCamX') - 55) setProperty('camFollow.y', getVar('gfCamY') - 15)
	end

	runHaxeCode("game.getLuaObject('church').setColorTransform(0,0,0,1,255,255,255);")
    end

    if curBeat == 125 or curBeat == 127 or curBeat == 157 or curBeat == 159 then
	setProperty('church.color', 0x0)
	runHaxeCode("game.getLuaObject('church').setColorTransform(0,0,0,1,0,0,0);")

	for _, i in pairs({'dad', 'boyfriend', 'gf'}) do
	    callMethodFromClass('flixel.tweens.FlxTween', 'cancelTweensOf', {instanceArg(i)})
	    setProperty(i..'.alpha', 1)
	    if curBeat ~= 128 then
		startTween('bye'..i, i, {alpha = 0}, crochet / 1000, {}) end

	    callMethod(i..'.setColorTransform', {0,0,0,1,255,255,255})
	end
    end

    if curBeat == 160 then
	cancelTween('byedad') setProperty('dad.alpha', 1)
	setProperty('gf.visible', false)
	callMethod('camFollow.setPosition', {getVar('dadCamX') - 240, getVar('dadCamY') - 50})
	startTween('zoomagain', 'camGame', {zoom = getProperty('camGame.zoom') + 0.2}, 6, {})
    end

    if curBeat == 175 then
	runHaxeCode("game.getLuaObject('church').setColorTransform(0,0,0,1,255,255,255);")

	for _, i in pairs({'dad', 'gf', 'boyfriend'}) do
	    callMethod(i..'.setColorTransform', {0,0,0,1,0,0,0})
	    setProperty(i..'.color', 0x0)
	end
	setProperty('boyfriend.visible', true)
	setProperty('gf.visible', true)
	setProperty('dad.visible', false)
	setProperty('defaultCamZoom', 0.85)
	setProperty('gf.y', getProperty('gf.y') + 130)
	callMethod('camFollow.setPosition', {getVar('gfCamX') + 100, getVar('gfCamY') + 245})
    end

    if curBeat == 190 then
	setProperty('camZooming', false)
	callMethod('camFollow.setPosition', {getVar('gfCamX') - 50, getVar('gfCamY') + 245})
	startTween('oooh', 'camGame', {zoom = 6.3}, 0.465, {})
    end

    if curBeat == 192 then
	setProperty('defaultCamZoom', 0.85)

	setProperty('dad.visible', true)
	setProperty('gf.visible', false)
	setProperty('camZooming', false)

	setProperty('boyfriend.visible', false)
	setProperty('dad.x', getProperty('dad.x') + 850)
	setProperty('boyfriend.x', getProperty('boyfriend.x') - 1060)

	focusCamera(getVar('dadCamX') + 540, getVar('dadCamY') - 200)
	startTween('coolpart', 'camGame', {zoom = 0.8}, 1.15, {})
    end

    if curBeat == 207 then
	setProperty('gf.x', 948)
	setProperty('gf.y', 722)
	setProperty('boyfriend.visible', true)
	startTween('zoomOut', 'camGame', {zoom = 0.55}, 7, {})
    end

    if curBeat == 222 then
	doTweenAlpha('churchTween', 'church', 0, crochet / 1000)
    end

    if curBeat == 224 or curBeat == 448 then
	setProperty('isCameraOnForcedPos', false)
	resetPos()

	if curBeat == 224 then
	    addLuaSprite('darken', true)
	    scaleObject('darken', 6, 6, false)
	else
	    setProperty('dad.alpha', 1)
	    setProperty('boyfriend.alpha', 1)
	end

	setProperty('purpleOverlay.visible', true)
	setProperty('purpleOverlay.alpha', 0.33)
	setProperty('defaultCamZoom', 0.5) setProperty('camGame.zoom', 0.5)
	setProperty('gf.visible', true)
	setProperty('dad.visible', true)
	setProperty('boyfriend.visible', true)

	runHaxeCode("FlxG.camera.focusOn(new FlxBasePoint(getVar('gfCamX') - 55, getVar('gfCamY') - 130));")

	for _, i in pairs({'dad', 'gf', 'boyfriend'}) do
	    callMethod(i..'.setColorTransform', {0,0,0,1,0,0,0})
	    setProperty(i..'.color', 0xFFFFFF)
	end
	runHaxeCode("game.getLuaObject('church').setColorTransform(0,0,0,0,0,0,0);")
	setProperty('church.color', 0xFFFFFF)
	doTweenAlpha('churchTween', 'church', 1, crochet / 1000)
    end

    if curBeat == 289 then
	startTween('darkie', 'darken', {alpha = 1}, 9, {onComplete = 'focusthecam'})
	function focusthecam()
	    setProperty('camGame.alpha', 0.001)
	    focusCamera(getVar('dadCamX') + 40, getVar('dadCamY') - 50)
	end
	doTweenAlpha('coiso', 'purpleOverlay', 0, 8)
    end

    if curBeat == 320 then
	removeLuaSprite('darken')
	doTweenAlpha('getBackCam', 'camGame', 1, 0.09)
	cameraShake('camGame', 0.0115, 0.9)
	if getHealth() > 1.1 then
	    startTween('healthie', 'game', {health = 1}, 0.9, {}) end
	setProperty('camGame.zoom', 0.7)

	setProperty('church.color', 0x0)
	for _, i in pairs({'dad', 'gf', 'boyfriend'}) do
	    callMethod(i..'.setColorTransform', {0,0,0,1,255,255,255})
	end
    end

    if curBeat == 344 then
	startTween('zoomagain', 'camGame', {zoom = getProperty('camGame.zoom') + 0.1}, 2, {})
    end

    if curBeat == 348 then
	setVar('translate', true)

	for _, i in pairs({'dad', 'gf', 'boyfriend'}) do
	    callMethod(i..'.setColorTransform', {0,0,0,1,0,0,0})
	    setProperty(i..'.color', 0x0)
	    setProperty(i..'.visible', false)
	end
	runHaxeCode("game.getLuaObject('church').setColorTransform(0,0,0,1,255,255,255);")

	if getHealth() > 1 then
	    setProperty('health', 1) end
    end

    if curBeat == 352 then
	runHaxeCode("addBehindDad(getVar('trail'));")
	setProperty('dad.visible', true)
	setProperty('dad.x', getProperty('dad.x') + 500)
	focusCamera(getProperty('dad.x') + 120, getProperty('dad.y') + 90)

	setProperty('isCameraOnForcedPos', true)
	setProperty('camGame.zoom', 1)
	startTween('cooleffect', 'camFollow', {x = getProperty('dad.x') + 120 + getProperty('dad.width'), y = getProperty('dad.y') + 90 + (getProperty('dad.height') / 4)}, 9.5, {})
    end

    if curBeat == 368 then
	cancelTween('cooleffect')
	runHaxeCode("getVar('trail').destroy();")
	setProperty('dad.x', getProperty('dad.x') - 500)
	setProperty('dad.visible', false)
	setProperty('boyfriend.visible', true)
	setProperty('boyfriend.x', getProperty('boyfriend.x') + 500)
	focusCamera(getProperty('boyfriend.x') + 120, getProperty('boyfriend.y') + 150)
	startTween('cooleffect', 'camFollow',
	    {x = getProperty('boyfriend.x') + getProperty('boyfriend.width') - 220, y = getProperty('boyfriend.y') + 90 + (getProperty('boyfriend.height') / 4)}, 9.5, {})
    end

    if curBeat == 384 then
	cancelTween('cooleffect')
	setProperty('camGame.zoom', 1.1)
	focusCamera(getProperty('dad.x') + 350, getProperty('dad.y') + 120)
	setProperty('dad.visible', true)
	setProperty('boyfriend.visible', false)
	setProperty('boyfriend.x', getProperty('boyfriend.x') - 500)

	makeLuaSprite('m1') makeGraphic('m1', screenWidth, 145, '000000')
	setScrollFactor('m1', 0, 0)
	addLuaSprite('m1')

	makeLuaSprite('m2') makeGraphic('m2', screenWidth, 145, '000000')
	setProperty('m2.y', screenHeight)
	setScrollFactor('m2', 0, 0)
	addLuaSprite('m2')

	setProperty('m1.y', getProperty('m1.y') - 145)
	--setProperty('m2.y', getProperty('m2.y') + 145)
	doTweenY('movie1', 'm1', getProperty('m1.y') + 145, 0.35)
	doTweenY('movi2', 'm2', getProperty('m2.y') - 145, 0.35)

	callMethod('dad.setPosition', {491.5, 60})
	startTween('movedad', 'dad', {x = getProperty('dad.x') - 200}, 7, {})
    end

    if curBeat == 400 then
	runHaxeCode("FlxTween.cancelTweensOf(game.dad);")
	setProperty('dad.visible', false)
	setProperty('dad.x', getProperty('dad.x') - 140)
	setProperty('boyfriend.visible', true)

	focusCamera(getProperty('boyfriend.x') + 350, getProperty('boyfriend.y') + 120)
	startTween('boyx', 'boyfriend', {x = getProperty('boyfriend.x') - 135}, 7.5, {})
    end

    if curBeat == 416 then
	setProperty('dad.alpha', 0.45)
	setProperty('dad.visible', true)
	callMethod('dad.setPosition', {2104.61, 898})
    end

    if curBeat == 432 then
	setProperty('dad.visible', false)
    end

    if curBeat == 446 then
	doTweenAlpha('bzl', 'church', 0, 0.4)
	startTween('boytwn', 'boyfriend', {alpha = 0}, 0.4, {onComplete = 'resetScore'})
	function resetScore()
	    setVar('translate', false)
	end
	removeLuaSprite('m1') removeLuaSprite('m2')
    end
end

function onStepHit()
    if curStep >= 352 and curStep < 367 or curStep >= 1376 and curStep < 1391 or curStep >= 1888 and curStep < 1903 then
	setCamZoom(0.51)
	setHudZoom(1.01)
    end
end

function resetPos()
    callMethod('dad.setPosition', {ogTaki[1], ogTaki[2]})
    callMethod('boyfriend.setPosition', {ogBF[1], ogBF[2]})
    callMethod('gf.setPosition', {ogGF[1], ogGF[2]})
    setProperty('church.x', ogBG[1]) setProperty('church.y', ogBG[2])
end

function focusCamera(x, y)
    callMethod('camFollow.setPosition', {x, y})
    runHaxeCode("FlxG.camera.focusOn(new FlxBasePoint(camFollow.x, camFollow.y));")
end

function setCamZoom(zoomAmount)
    if getProperty('camZooming') then
	setProperty('camGame.zoom', zoomAmount) else return
    end
end

function setHudZoom(zoomAmount)
    setProperty('camHUD.zoom', zoomAmount)
end