local strumLine1Visible = true
local strumLine2Visible = true
local showOnlyStrums = false

local floatY = 0

function onCreate()
    setProperty('camZoomingMult', 0) setHudZoom(2)
    showOnlyStrums = true
    strumLine1Visible = false
    strumLine2Visible = false
end

function onUpdate(elapsed)
    if curStep == 1 then
	setCamZoom(1)
	setHudZoom(1)
    end

    if curStep >= 0 and curStep < 1376 then
	local currentBeat = (getSongPosition() / 1000)*(curBpm/45)
	for i=0,3 do
	    setProperty('opponentStrums.members['..i..'].y', _G['defaultOpponentStrumY'..i] + 10 * math.cos((currentBeat + i*50) * math.pi))
	end
    end


    if curStep >= 129 and curStep < 255 then
	local currentBeat = (getSongPosition() / 1000)*(curBpm/120)
	for i=4,7 do
	    setProperty('strumLineNotes.members['..i..'].x', _G['defaultPlayerStrumX'..(i%4)] + 5 * math.sin((currentBeat + i*0.25) * math.pi))
	    setProperty('strumLineNotes.members['..i..'].y', _G['defaultPlayerStrumY'..(i%4)] + 5 * math.cos((currentBeat + i*0.25) * math.pi))
	end
    end

    if curStep >= 256 and curStep < 376 then
	local currentBeat = (getSongPosition() / 1000)*(curBpm/120)
	for i=4,7 do
	    setProperty('strumLineNotes.members['..i..'].x', _G['defaultPlayerStrumX'..(i%4)] + 10 * math.sin((currentBeat + i*0.25) * math.pi))
	    setProperty('strumLineNotes.members['..i..'].y', _G['defaultPlayerStrumY'..(i%4)] + 10 * math.cos((currentBeat + i*0.25) * math.pi))
	end
    end

    if curStep >= 384 and curStep < 616 then
	local currentBeat = (getSongPosition() / 1000)*(curBpm/60)
	for i=4,7 do
	    setProperty('strumLineNotes.members['..i..'].x', _G['defaultPlayerStrumX'..(i%4)] + 10 * math.sin((currentBeat + i*50) * math.pi))
	end
    end

    if curStep >= 640 and curStep < 752 or curStep >= 768 and curStep < 880 or curStep >= 896 and curStep < 1112 then
	local currentBeat = (getSongPosition() / 1000)*(curBpm/60)
	for i=4,7 do
	    setProperty('strumLineNotes.members['..i..'].x', _G['defaultPlayerStrumX'..(i%4)] + 15 * math.sin((currentBeat + i*0.25) * math.pi))
	end
    end

    if curStep >= 1152 and curStep < 1256 then
	local currentBeat = (getSongPosition() / 1000)*(curBpm/60)
	for i=4,7 do
	    setActorX(_G['defaultStrum'..i..'X'] + 5 * math.sin((currentBeat + i*0.25) * math.pi))
	    setActorY(_G['defaultStrum'..i..'Y'] + 25 * math.sin((currentBeat + i*0.25) * math.pi))
	end
    end


    if curStep == 376 or curStep == 616 or curStep == 752 or curStep == 880 or curStep == 1112 or curStep == 1256 then
	for i=4,7 do
	    startTween('twinX'..i, 'strumLineNotes.members['..i..']', {x = _G['defaultPlayerStrumX'..(i%4)], y = _G['defaultPlayerStrumY'..(i%4)], angle = 0}, 0.3, {})
	end
    end

    if curStep == 1376 then
	for i=0,3 do
	    startTween('twinao'..i, 'opponentStrums.members['..i..']', {x = _G['defaultOpponentStrumX'..i], y = _G['defaultOpponentStrumY'..i], angle = 0}, 0.3, {})
	end
    end


    if curStep >= 129 and curStep < 130 then
	setCamZoom(1.1)
	strumLine1Visible = true
	strumLine2Visible = true
    end

    if curStep >= 128 and curStep < 255 then
	showOnlyStrums = false
    end

    if curStep == 752 then
	strumLine1Visible = false
    end

    if curStep == 768 then
	strumLine1Visible = true
    end

    if curStep == 880 then
	strumLine1Visible = false
    end

    if curStep == 896 then
	strumLine1Visible = true
    end

    if curStep == 1104 then
	strumLine1Visible = false
    end

    if curStep == 1152 then
	strumLine1Visible = true
    end

    if curStep == 1260 then
	strumLine1Visible = false
    end

    if curStep == 1280 then
	strumLine1Visible = true
    end

    if curStep == 624 then
	showOnlyStrums = true
	setCamZoom(1.1)
	strumLine1Visible = false
	strumLine2Visible = false
    end

    if curStep == 640 then
	showOnlyStrums = false
	setCamZoom(1.1)
	strumLine1Visible = true
	strumLine2Visible = true
    end

    if curStep == 1376 then
	setCamZoom(1.1)
	strumLine1Visible = false
	strumLine2Visible = false
    end

    if curStep == 1408 then
	showOnlyStrums = true
    end

    for _, i in pairs({'healthBar', 'healthBar.bg', 'iconP1', 'iconP2', 'scoreTxt'}) do
	setProperty(i..'.visible', not showOnlyStrums)
    end

    for i = 0, 3 do
	setProperty('strumLineNotes.members['..i..'].alpha', strumLine1Visible and 1 or 0.001)
	setProperty('playerStrums.members['..i..'].alpha', strumLine2Visible and 1 or 0.001)
    end

    floatY = floatY + 0.1
    setProperty('dad.y', getProperty('dad.y') + math.sin(floatY))
end


function onBeatHit()
    if curStep >= 382 and curStep < 622 or curStep >= 1278 and curStep < 1406 then
	setCamZoom(0.92)
	setHudZoom(1.02)
    end

    if curStep >= 638 and curStep < 752 or curStep >= 766 and curStep < 882 or curStep >= 894 and curStep < 1118 or curStep >= 1150 and curStep < 1262 then
	setCamZoom(0.93)
	setHudZoom(1.03)
    end
end

function setCamZoom(zoomAmount)
    setProperty('camGame.zoom', zoomAmount)
end

function setHudZoom(zoomAmount)
    setProperty('camHUD.zoom', zoomAmount)
end