addHaxeLibrary('FlxMath', 'flixel.math')

local strumLine1Visible = true
local strumLine2Visible = true
local showOnlyStrums = false

local hudAngle = 0

luaDebugMode = true
function onCreate()
    setProperty('camZoomingMult', 0)
end

function onUpdate(elapsed)
    setProperty('camHUD.angle', callMethodFromClass('flixel.math.FlxMath', 'lerp', {hudAngle, getProperty('camHUD.angle'), callMethodFromClass('flixel.math.FlxMath', 'bound', {1 - (elapsed * 25.125), 0, 1})}))

    if curStep == 1 or curStep == 256 or curStep == 318 or curStep == 416 or curStep == 480 or curStep == 832 or curStep == 1024 or curStep == 1152 or curStep == 1312 or curStep == 1376 or curStep == 1408 then
	setProperty('camHUD.angle', getProperty('camHUD.angle') + 0.1)
	local currentBeat = (getSongPosition() / 1000)*(curBpm/30)
	for i=0,7 do
	    local note = i > 3 and 'defaultPlayerStrum' or 'defaultOpponentStrum'
	    setProperty((i > 3 and 'playerStrums' or 'opponentStrums')..'.members['..(i%4)..'].x', _G[note..'X'..(i%4)] + 10 * math.sin((currentBeat + i*50)* math.pi))
	end
    end

    if curStep == 256 or curStep == 384 or curStep == 448 or curStep == 512 or curStep == 896 or curStep == 1144 or curStep == 1280 or curStep == 1344 or curStep == 1400 or curStep == 1520 then
	setProperty('camHUD.angle', 0)
	local currentBeat = (getSongPosition() / 1000)*(curBpm/120)
	for i=0, 7 do
	    local note = i > 3 and 'defaultPlayerStrum' or 'defaultOpponentStrum'
	    startTween('culol'..i, (i > 3 and 'playerStrums' or 'opponentStrums')..'.members['..(i%4)..']', {x = _G[note..'X'..(i%4)], y = _G[note..'Y'..(i%4)], angle = 0}, 0.6, {})
	end
    end

    if curStep == 4 or curStep == 12 or curStep == 20 or curStep == 28 or curStep == 36 or curStep == 44 or curStep == 52 or curStep == 60 or curStep == 68 or curStep == 76 or curStep == 84 or curStep == 92 or curStep == 100 or curStep == 108 or curStep == 116 or curStep == 124 then
	setProperty('camHUD.angle', getProperty('camHUD.angle') + -0.2)
	local currentBeat = (getSongPosition() / 1000)*(curBpm/30)
	for i=0,7 do
	    local note = i > 3 and 'defaultPlayerStrum' or 'defaultOpponentStrum'
	    setProperty((i > 3 and 'playerStrums' or 'opponentStrums')..'.members['..(i%4)..'].x', _G[note..'X'..(i%4)] + -10 * math.sin((currentBeat + i*50)* math.pi))
	end
    end

    if curStep == 8 or curStep == 16 or curStep == 24 or curStep == 32 or curStep == 40 or curStep == 48 or curStep == 56 or curStep == 64 or curStep == 72 or curStep == 80 or curStep == 88 or curStep == 96 or curStep == 104 or curStep == 112 or curStep == 120 then
	setProperty('camHUD.angle', getProperty('camHUD.angle') + 0.2)
	local currentBeat = (getSongPosition() / 1000)*(curBpm/30)
	for i=0,7 do
	    local note = i > 3 and 'defaultPlayerStrum' or 'defaultOpponentStrum'
	    setProperty((i > 3 and 'playerStrums' or 'opponentStrums')..'.members['..(i%4)..'].x', _G[note..'X'..(i%4)] + 10 * math.sin((currentBeat + i*50)* math.pi))
	end
    end

    if curStep == 128 or curStep == 136 or curStep == 144 or curStep == 152 or curStep == 160 or curStep == 168 or curStep == 176 or curStep == 184 or curStep == 192 or curStep == 200 or curStep == 208 or curStep == 216 or curStep == 224 or curStep == 232 or curStep == 240 or curStep == 248 then
	setProperty('camHUD.angle', getProperty('camHUD.angle') + 0.2)
	local currentBeat = (getSongPosition() / 1000)*(curBpm/30)
	for i=0,7 do
	    local note = i > 3 and 'defaultPlayerStrum' or 'defaultOpponentStrum'
	    setProperty((i > 3 and 'playerStrums' or 'opponentStrums')..'.members['..(i%4)..'].x', _G[note..'X'..(i%4)] + 10 * math.sin((currentBeat + i*50)* math.pi))
	end
    end

    if curStep == 132 or curStep == 140 or curStep == 148 or curStep == 156 or curStep == 164 or curStep == 172 or curStep == 180 or curStep == 188 or curStep == 196 or curStep == 204 or curStep == 212 or curStep == 220 or curStep == 228 or curStep == 236 or curStep == 244 or curStep == 252 then
	setProperty('camHUD.angle', getProperty('camHUD.angle') + -0.2)
	local currentBeat = (getSongPosition() / 1000)*(curBpm/30)
	for i=0,7 do
	    local note = i > 3 and 'defaultPlayerStrum' or 'defaultOpponentStrum'
	    setProperty((i > 3 and 'playerStrums' or 'opponentStrums')..'.members['..(i%4)..'].x', _G[note..'X'..(i%4)] + -10 * math.sin((currentBeat + i*50)* math.pi))
	end
    end

    if curStep == 328 or curStep == 336 or curStep == 344 or curStep == 352 or curStep == 360 or curStep == 368 or curStep == 376 or curStep == 384 then
	setProperty('camHUD.angle', getProperty('camHUD.angle') + 0.2)
	local currentBeat = (getSongPosition() / 1000)*(curBpm/30)
	for i=0,7 do
	    local note = i > 3 and 'defaultPlayerStrum' or 'defaultOpponentStrum'
	    setProperty((i > 3 and 'playerStrums' or 'opponentStrums')..'.members['..(i%4)..'].x', _G[note..'X'..(i%4)] + 10 * math.sin((currentBeat + i*50)* math.pi))
	end
    end

    if curStep == 324 or curStep == 332 or curStep == 340 or curStep == 348 or curStep == 356 or curStep == 364 or curStep == 372 then
	setProperty('camHUD.angle', getProperty('camHUD.angle') + -0.2)
	local currentBeat = (getSongPosition() / 1000)*(curBpm/30)
	for i=0,7 do
	    local note = i > 3 and 'defaultPlayerStrum' or 'defaultOpponentStrum'
	    setProperty((i > 3 and 'playerStrums' or 'opponentStrums')..'.members['..(i%4)..'].x', _G[note..'X'..(i%4)] + -10 * math.sin((currentBeat + i*50)* math.pi))
	end
    end

    if curStep == 420 or curStep == 428 or curStep == 436 or curStep == 484 or curStep == 492 or curStep == 500 or curStep == 508 then
	setProperty('camHUD.angle', getProperty('camHUD.angle') + -0.2)
	local currentBeat = (getSongPosition() / 1000)*(curBpm/30)
	for i=0,7 do
	    local note = i > 3 and 'defaultPlayerStrum' or 'defaultOpponentStrum'
	    setProperty((i > 3 and 'playerStrums' or 'opponentStrums')..'.members['..(i%4)..'].x', _G[note..'X'..(i%4)] + -10 * math.sin((currentBeat + i*50)* math.pi))
	end
    end

    if curStep == 424 or curStep == 432 or curStep == 440 or curStep == 488 or curStep == 496 or curStep == 504 or curStep == 512 then
	setProperty('camHUD.angle', getProperty('camHUD.angle') + 0.2)
	local currentBeat = (getSongPosition() / 1000)*(curBpm/30)
	for i=0,7 do
	    local note = i > 3 and 'defaultPlayerStrum' or 'defaultOpponentStrum'
	    setProperty((i > 3 and 'playerStrums' or 'opponentStrums')..'.members['..(i%4)..'].x', _G[note..'X'..(i%4)] + 10 * math.sin((currentBeat + i*50)* math.pi))
	end
    end

    if curStep == 836 or curStep == 844 or curStep == 852 or curStep == 860 or curStep == 868 or curStep == 876 or curStep == 884 then
	setProperty('camHUD.angle', getProperty('camHUD.angle') + -0.2)
	local currentBeat = (getSongPosition() / 1000)*(curBpm/30)
	for i=0,7 do
	    local note = i > 3 and 'defaultPlayerStrum' or 'defaultOpponentStrum'
	    setProperty((i > 3 and 'playerStrums' or 'opponentStrums')..'.members['..(i%4)..'].x', _G[note..'X'..(i%4)] + -10 * math.sin((currentBeat + i*50)* math.pi))
	end
    end

    if curStep == 840 or curStep == 848 or curStep == 856 or curStep == 864 or curStep == 872 or curStep == 880 or curStep == 888 then
	setProperty('camHUD.angle', getProperty('camHUD.angle') + 0.2)
	local currentBeat = (getSongPosition() / 1000)*(curBpm/30)
	for i=0,7 do
	    local note = i > 3 and 'defaultPlayerStrum' or 'defaultOpponentStrum'
	    setProperty((i > 3 and 'playerStrums' or 'opponentStrums')..'.members['..(i%4)..'].x', _G[note..'X'..(i%4)] + 10 * math.sin((currentBeat + i*50)* math.pi))
	end
    end

    if curStep == 1028 or curStep == 1036 or curStep == 1044 or curStep == 1052 or curStep == 1060 or curStep == 1068 or curStep == 1076 or curStep == 1084 or curStep == 1092 or curStep == 1100 or curStep == 1108 or curStep == 1116 or curStep == 1124 or curStep == 1132 or curStep == 1140 then
	setProperty('camHUD.angle', getProperty('camHUD.angle') + -0.2)
	local currentBeat = (getSongPosition() / 1000)*(curBpm/30)
	for i=0,7 do
	    local note = i > 3 and 'defaultPlayerStrum' or 'defaultOpponentStrum'
	    setProperty((i > 3 and 'playerStrums' or 'opponentStrums')..'.members['..(i%4)..'].x', _G[note..'X'..(i%4)] + -10 * math.sin((currentBeat + i*50)* math.pi))
	end
    end

    if curStep == 1032 or curStep == 1040 or curStep == 1048 or curStep == 1056 or curStep == 1064 or curStep == 1072 or curStep == 1080 or curStep == 1088 or curStep == 1096 or curStep == 1104 or curStep == 1112 or curStep == 1120 or curStep == 1128 or curStep == 1136 then
	setProperty('camHUD.angle', getProperty('camHUD.angle') + 0.2)
	local currentBeat = (getSongPosition() / 1000)*(curBpm/30)
	for i=0,7 do
	    local note = i > 3 and 'defaultPlayerStrum' or 'defaultOpponentStrum'
	    setProperty((i > 3 and 'playerStrums' or 'opponentStrums')..'.members['..(i%4)..'].x', _G[note..'X'..(i%4)] + 10 * math.sin((currentBeat + i*50)* math.pi))
	end
    end

    if curStep == 1156 or curStep == 1164 or curStep == 1172 or curStep == 1180 or curStep == 1188 or curStep == 1196 or curStep == 1204 or curStep == 1220 or curStep == 1228 or curStep == 1236 or curStep == 1244 or curStep == 1252 or curStep == 1260 or curStep == 1268 or curStep == 1276 then
	setProperty('camHUD.angle', getProperty('camHUD.angle') + -0.2)
	local currentBeat = (getSongPosition() / 1000)*(curBpm/30)
	for i=0,7 do
	    local note = i > 3 and 'defaultPlayerStrum' or 'defaultOpponentStrum'
	    setProperty((i > 3 and 'playerStrums' or 'opponentStrums')..'.members['..(i%4)..'].x', _G[note..'X'..(i%4)] + -10 * math.sin((currentBeat + i*50)* math.pi))
	end
    end

    if curStep == 1160 or curStep == 1168 or curStep == 1176 or curStep == 1184 or curStep == 1192 or curStep == 1200 or curStep == 1208 or curStep == 1224 or curStep == 1232 or curStep == 1240 or curStep == 1248 or curStep == 1256 or curStep == 1264 or curStep == 1272 then
	setProperty('camHUD.angle', getProperty('camHUD.angle') + 0.2)
	local currentBeat = (getSongPosition() / 1000)*(curBpm/30)
	for i=0,7 do
	    local note = i > 3 and 'defaultPlayerStrum' or 'defaultOpponentStrum'
	    setProperty((i > 3 and 'playerStrums' or 'opponentStrums')..'.members['..(i%4)..'].x', _G[note..'X'..(i%4)] + 10 * math.sin((currentBeat + i*50)* math.pi))
	end
    end

    if curStep == 1316 or curStep == 1324 or curStep == 1332 or curStep == 1340 or curStep == 1380 or curStep == 1388 or curStep == 1396 then
	setProperty('camHUD.angle', getProperty('camHUD.angle') + -0.2)
	local currentBeat = (getSongPosition() / 1000)*(curBpm/30)
	for i=0,7 do
	    local note = i > 3 and 'defaultPlayerStrum' or 'defaultOpponentStrum'
	    setProperty((i > 3 and 'playerStrums' or 'opponentStrums')..'.members['..(i%4)..'].x', _G[note..'X'..(i%4)] + -10 * math.sin((currentBeat + i*50)* math.pi))
	end
    end

    if curStep == 1320 or curStep == 1328 or curStep == 1336 or curStep == 1342 or curStep == 1384 or curStep == 1392 then
	setProperty('camHUD.angle', getProperty('camHUD.angle') + 0.2)
	local currentBeat = (getSongPosition() / 1000)*(curBpm/30)
	for i=0,7 do
	    local note = i > 3 and 'defaultPlayerStrum' or 'defaultOpponentStrum'
	    setProperty((i > 3 and 'playerStrums' or 'opponentStrums')..'.members['..(i%4)..'].x', _G[note..'X'..(i%4)] + 10 * math.sin((currentBeat + i*50)* math.pi))
	end
    end

    if curStep == 1412 or curStep == 1420 or curStep == 1428 or curStep == 1436 or curStep == 1444 or curStep == 1452 or curStep == 1460 or curStep == 1468 or curStep == 1476 or curStep == 1484 or curStep == 1492 or curStep == 1500 or curStep == 1508 or curStep == 1516 then
	setProperty('camHUD.angle', getProperty('camHUD.angle') + -0.2)
	local currentBeat = (getSongPosition() / 1000)*(curBpm/30)
	for i=0,7 do
	    local note = i > 3 and 'defaultPlayerStrum' or 'defaultOpponentStrum'
	    setProperty((i > 3 and 'playerStrums' or 'opponentStrums')..'.members['..(i%4)..'].x', _G[note..'X'..(i%4)] + -10 * math.sin((currentBeat + i*50)* math.pi))
	end
    end

    if curStep == 1416 or curStep == 1424 or curStep == 1432 or curStep == 1440 or curStep == 1448 or curStep == 1456 or curStep == 1464 or curStep == 1472 or curStep == 1480 or curStep == 1488 or curStep == 1496 or curStep == 1504 or curStep == 1512 then
	setProperty('camHUD.angle', getProperty('camHUD.angle') + 0.2)
	local currentBeat = (getSongPosition() / 1000)*(curBpm/30)
	for i=0,7 do
	    local note = i > 3 and 'defaultPlayerStrum' or 'defaultOpponentStrum'
	    setProperty((i > 3 and 'playerStrums' or 'opponentStrums')..'.members['..(i%4)..'].x', _G[note..'X'..(i%4)] + 10 * math.sin((currentBeat + i*50)* math.pi))
	end
    end


    if curStep == 512 or curStep == 518 or curStep == 528 or curStep == 538 or curStep == 544 or curStep == 550 or curStep == 560 or curStep == 566 or curStep == 570 then
	setCamZoom(0.7025)
	setHudZoom(1.01)
    end

    if curStep == 576 or curStep == 582 or curStep == 592 or curStep == 602 or curStep == 608 or curStep == 614 or curStep == 624 or curStep == 630 or curStep == 634 then
	setCamZoom(0.7025)
	setHudZoom(1.01)
    end

    if curStep >= 1524 and curStep < 1532 or curStep >= 1212 and curStep < 1214 or curStep >= 1468 and curStep < 1470 then
	setCamZoom(0.6)
    end

    if curStep >= 1532 and curStep < 1536 or curStep >= 1214 and curStep < 1216 or curStep >= 1470 and curStep < 1472 then
	setCamZoom(0.65)
    end

    if curStep >= 1536 then
	strumLine1Visible = false
	strumLine2Visible = false
    end

    if curStep >= 1568 then
	showOnlyStrums = true
	setProperty('vocals.volume', 0) -- it's weird the vocals restarting at the end
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
    if curStep >= 0 and curStep < 136 or curStep >= 254 and curStep < 318 or curStep >= 382 and curStep < 414 or curStep >= 446 and curStep < 478 or curStep >= 766 and curStep < 830 or curStep >= 894 and curStep < 1022 or curStep >= 1278 and curStep < 1310 or curStep >= 1342 and curStep < 1374 or curStep >= 1406 and curStep < 1464 or curStep >= 1470 and curStep < 1518 then
	setCamZoom(0.7025)
	setHudZoom(1.01)
    end

    if curStep >= 126 and curStep < 254 or curStep >= 318 and curStep < 382 or curStep >= 414 and curStep < 446 or curStep >= 478 and curStep < 510 or curStep >= 638 and curStep < 766 or curStep >= 830 and curStep < 894 or curStep >= 1022 and curStep < 1214 or curStep >= 1218 and curStep < 1278 or curStep >= 1310 and curStep < 1342 or curStep >= 1374 and curStep < 1400 then
	setCamZoom(0.71)
	setHudZoom(1.01)
    end

    if curBeat % 4 == 0 then
	if curStep < 128 then
	    setProperty('camHUD.zoom', getProperty('camHUD.zoom') + 0.01)
	else
	    setProperty('camHUD.zoom', getProperty('camHUD.zoom') + 0.02)
	end
    end
end

local bopTiming = {
    --{curStep >=, curStep <, angle}
    {0, 128, 0.45},
    {128, 256, 1.35},
    {320, 384, 1.35},
    {384, 417, 0.45},
    {417, 449, 1.35},
    {480, 512, 0.45},
    {641, 768, 0.45},
    {832, 897, 1.35},
    {1024, 1152, 0.45},
    {1152, 1212, 1.35},
    {1221, 1281, 1.35},
    {1313, 1344, 1.35},
    {1376, 1408, 1.35},
    {1408, 1468, 0.45},
    {1473, 1500, 0.45},
    {1505, 1522, 0.45}
}

function onStepHit()
    if curStep == 112 then
	setProperty('defaultCamZoom', getProperty('defaultCamZoom') + 0.0565)
    elseif curStep == 117 then
	setProperty('defaultCamZoom', getProperty('defaultCamZoom') + 0.03)
    elseif curStep == 121 then
	setProperty('defaultCamZoom', getProperty('defaultCamZoom') + 0.03)
    elseif curStep == 125 then
	setProperty('defaultCamZoom', getProperty('defaultCamZoom') + 0.1)
    elseif curStep == 1212 then
	createText('ha', 0.67)
    elseif curStep == 1214 then
	createText('ha!', 0.75)
    elseif curStep == 1536 then
	for i = 0,7 do setProperty('strumLineNotes.members['..i..'].visible', false)end
    elseif curStep == 1568 then
	for _, i in pairs({'healthBar', 'healthBar.bg', 'scoreTxt', 'iconP1', 'iconP2'}) do
	    setProperty(i..'.visible', false)end
    end

    if curStep >= 1524 and curStep < 1532 or curStep >= 1212 and curStep < 1214 or curStep >= 1468 and curStep < 1470 then
	setProperty('camZooming', false)
	setProperty('camGame.zoom', 0.6)
    end

    if curStep >= 1532 and curStep < 1536 or curStep >= 1214 and curStep < 1216 or curStep >= 1470 and curStep < 1472 then
	setProperty('camZooming', true)
	setProperty('camGame.zoom', 0.65)
    end

    if curStep % 4 == 0 then
	while bopTiming[1] ~= nil and curStep >= bopTiming[1][2] do
	    table.remove(bopTiming, 1)

	    if bopTiming[1] ~= nil then
		if bopTiming[1][2] + 1 > curStep then
		    hudAngle = 0
		end

		if bopTiming[1][3] < 1 or hudAngle == 0 then
		    for i = 0, 7 do
			local note = i > 3 and 'defaultPlayerStrum' or 'defaultOpponentStrum'
			startTween('cuzinho'..i, 'strumLineNotes.members['..i..']', {x = _G[note..'X'..(i%4)]}, 0.3, {})
		    end
		end
	    end
	end

	if bopTiming[1] ~= nil then
	    local timing = bopTiming[1]
	    if curStep > timing[1] and curStep < timing[2] then
		hudAngle = curStep % 8 == 0 and timing[3] or timing[3] * -1
		if timing[3] > 1 then
		    for i = 0,7 do
			local note = i > 3 and 'defaultPlayerStrum' or 'defaultOpponentStrum'
			setProperty('strumLineNotes.members['..i..'].x', _G[note..'X'..(i%4)] + (curStep % 8 == 0 and 7 or -7))
		    end
		end
	    end
	end
    end
end

local cuzin = 1
function createText(text, size)
    createInstance('ha'..cuzin, 'objects.Alphabet', {getProperty('dad.x') + 320, getProperty('dad.y'), tostring(text), true})
    scaleObject('ha'..cuzin, size, size, false)
    setProperty('ha'..cuzin..'.velocity.y', getProperty('ha'..cuzin..'.velocity.y') - getRandomInt(140, 160))
    setProperty('ha'..cuzin..'.velocity.x', getRandomFloat(-5, 5))
    addInstance('ha'..cuzin)

    startTween('haTween'..cuzin, 'ha'..cuzin, {alpha = 0}, 0.5, {onComplete = 'killha'})
    function killha()
	callMethod('ha'..cuzin..'.kill', {''})
    end

    cuzin = cuzin + 1
end

function setCamZoom(zoomAmount)
    setPropertyFromClass('flixel.FlxG', 'zoom', zoomAmount)
end

function setHudZoom(zoomAmount)
    setProperty('camHUD.zoom', zoomAmount)
end