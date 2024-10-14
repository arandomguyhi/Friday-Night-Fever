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
	setProperty('playerStrums.members['..i..'].visible', strumLine2Visible)
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
	startTween('zoomin', 'game', {defaultCamZoom = getProperty('defaultCamZoom') + 0.2}, 7, {onComplete = 'zoomAgain'})
	function zoomAgain()
	    startTween('zoomout', 'game', {defaultCamZoom = getProperty('defaultCamZoom') - 0.2}, 3.5, {})
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
	    setProperty('camFollow.x', getVar('gfCamX') - 55) setVar('camFollow.y', getVar('gfCamY') - 130)
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
	callMethod('camFollow.setPosition', {getVar('dadCamX') + 120, getVar('dadCamY') - 50})
	startTween('zoomagain', 'game', {defaultCamZoom = getProperty('defaultCamZoom') + 0.2}, 6, {})
    end

    if curBeat == 175 then
	runHaxeCode("game.getLuaObject('church').setColorTransform(0,0,0,1,255,255,255);")

	for _, i in pairs({'dad', 'gf', 'boyfriend'}) do
	    callMethod(i..'.setColorTransform', {0,0,0,1,0,0,0})
	    setProperty(i..'.color', 0x0)
	end
	setProperty('boyfriend.alpha', 1) setProperty('boyfriend.visible', true)
	setProperty('gf.alpha', 1) setProperty('gf.visible', true)
	setProperty('dad.visible', false)
	setProperty('defaultCamZoom', 0.85)
	setProperty('gf.y', getProperty('gf.y') + 130)
	setProperty('camFollow.x', getVar('gfCamX') + 100) setVar('camFollow.y', getVar('gfCamY') + 245)
    end

    if curBeat == 190 then
	setProperty('camZooming', false)
	setProperty('camFollow.x', getProperty('camFollow.x') - 50)
	startTween('oooh', 'game', {defaultCamZoom = 6.3}, 0.465, {})
    end

    if curBeat == 192 then
	setProperty('defaultCamZoom', 0.85)
	for _, i in pairs({'dad', 'gf', 'boyfriend'}) do
	    callMethod(i..'.setColorTransform', {0,0,0,1,255,255,255})
	end
	runHaxeCode("game.getLuaObject('church').setColorTransform(0,0,0,1,0,0,0);")
	setProperty('church.color', 0x0)

	setProperty('dad.visible', true)
	setProperty('gf.visible', false)
	setProperty('camZooming', false)

	setProperty('boyfriend.visible', false)
	setProperty('dad.x', getProperty('dad.x') + 850)
	setProperty('boyfriend.x', getProperty('boyfriend.x') - 1060)

	setProperty('camFollow.x', getVar('dadCamX') + 40) setProperty('camFollow.y', getVar('dadCamY') - 200)
	startTween('coolpart', 'game', {defaultCamZoom = 0.8}, 1.15, {})
    end
end

function onStepHit()
    if curStep >= 352 and curStep < 367 or curStep >= 1376 and curStep < 1391 or curStep >= 1888 and curStep < 1903 then
	setCamZoom(0.51)
	setHudZoom(1.01)
    end
end

function setCamZoom(zoomAmount)
    if getProperty('camZooming') then
	setProperty('camGame.zoom', zoomAmount) else return
    end
end

function setHudZoom(zoomAmount)
    setProperty('camHUD.zoom', zoomAmount)
end