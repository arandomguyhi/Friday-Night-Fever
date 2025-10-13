local strumLine1Visible = false
local strumLine2Visible = false
local showOnlyStrums = true

function onCreate()
    setProperty('camZoomingMult', 0)
    setHudZoom(2)
end

function onUpdate(elapsed)
    if curStep == 1 then
	setCamZoom(1)
	setHudZoom(1)
    end

    if curStep >= 129 and curStep < 255 then
	local currentBeat = (songPos / 1000)*(bpm/60)
	for i=0,7 do
	    setActorX(_G['defaultStrum'..i..'X'] + 16 * math.sin((currentBeat + i*0.25) * math.pi), i)
	    setActorY(_G['defaultStrum'..i..'Y'] + 16 * math.cos((currentBeat + i*0.25) * math.pi), i)
	end
    end

    if curStep >= 384 and curStep < 512 then
	local currentBeat = (songPos / 1000)*(bpm/60)
        for i=0,7 do
	    setActorX(_G['defaultStrum'..i..'X'] + 16 * math.sin((currentBeat + i*0.25) * math.pi), i)
	    setActorY(_G['defaultStrum'..i..'Y'] + 16 * math.cos((currentBeat + i*0.25) * math.pi), i)
	end
    end
	
    if curStep >= 642 and curStep < 768 then
	local currentBeat = (songPos / 1000)*(bpm/60)
        for i=0,7 do
	    setActorX(_G['defaultStrum'..i..'X'] + 16 * math.sin((currentBeat + i*0.25) * math.pi), i)
	    setActorY(_G['defaultStrum'..i..'Y'] + 16 * math.cos((currentBeat + i*0.25) * math.pi), i)
	end
    end

    if curStep >= 768 and curStep < 894 then
	local currentBeat = (songPos / 1000)*(bpm/60)
        for i=0,7 do
	    setActorX(_G['defaultStrum'..i..'X'] + 32 * math.sin((currentBeat + i*0.25) * math.pi), i)
	    setActorY(_G['defaultStrum'..i..'Y'] + 32 * math.cos((currentBeat + i*0.25) * math.pi), i)
	end
    end

    if curStep >= 0 and curStep < 129 then
	local currentBeat = (songPos / 1000)*(bpm/120)
	for i=0,7 do
	    setActorY(defaultStrum0Y + 10 * math.cos((currentBeat + i*0.25) * math.pi), i)
	end
    end

    if curStep >= 255 and curStep < 384 then
	local currentBeat = (songPos / 1000)*(bpm/120)
	for i=0,7 do
	    setActorY(defaultStrum0Y + 10 * math.cos((currentBeat + i*0.25) * math.pi), i)
	end
    end

    if curStep >= 520 and curStep < 544 then
	local currentBeat = (songPos / 1000)*(bpm/120)
	for i=0,7 do
	    setActorX(_G['defaultStrum'..i..'X'] + 32 * math.sin((currentBeat + i*0.25) * math.pi), i)
	    setActorY(defaultStrum0Y + 10 * math.cos((currentBeat + i*0.25) * math.pi), i)
	end
    end

    if curStep >= 552 and curStep < 578 then
	local currentBeat = (songPos / 1000)*(bpm/120)
	for i=0,7 do
	    setActorX(_G['defaultStrum'..i..'X'] + 32 * math.sin((currentBeat + i*0.25) * math.pi), i)
	    setActorY(defaultStrum0Y + 10 * math.cos((currentBeat + i*0.25) * math.pi), i)
	end
    end

    if curStep >= 584 and curStep < 608 then
	local currentBeat = (songPos / 1000)*(bpm/120)
	for i=0,7 do
	    setActorX(_G['defaultStrum'..i..'X'] + 32 * math.sin((currentBeat + i*0.25) * math.pi), i)
	    setActorY(defaultStrum0Y + 10 * math.cos((currentBeat + i*0.25) * math.pi), i)
	end
    end

    if curStep >= 616 and curStep < 642 then
	local currentBeat = (songPos / 1000)*(bpm/120)
	for i=0,7 do
	    setActorX(_G['defaultStrum'..i..'X'] + 32 * math.sin((currentBeat + i*0.25) * math.pi), i)
	    setActorY(defaultStrum0Y + 10 * math.cos((currentBeat + i*0.25) * math.pi), i)
	end
    end

    if curStep >= 898 and curStep < 1024 then
	local currentBeat = (songPos / 1000)*(bpm/120)
	for i=0,7 do
	    setActorY(defaultStrum0Y + 10 * math.cos((currentBeat + i*0.25) * math.pi), i)
	end
    end


    if curStep >= 64 and curStep < 96 then
	strumLine2Visible = true
    end

    if curStep >= 898 and curStep < 932 then
	showOnlyStrums = true
    end

    if curStep >= 928 and curStep < 960 then
	strumLine1Visible = false
    end
	
    if curStep >= 960 and curStep < 992 then
	strumLine2Visible = false
    end

    if curStep >= 512 and curStep < 520 then
	local currentBeat = (songPos / 1000)*(bpm/30)
	for i=0,7 do
	    setActorX(_G['defaultStrum'..i..'X'] + 32 * math.sin((currentBeat + i*1.5) * math.pi), i)
	    setActorY(_G['defaultStrum'..i..'Y'] + 32 * math.cos((currentBeat + i*1.5) * math.pi), i)
	end
    end

    if curStep >= 544 and curStep < 552 then
	local currentBeat = (songPos / 1000)*(bpm/30)
	for i=0,7 do
	    setActorX(_G['defaultStrum'..i..'X'] + 32 * math.sin((currentBeat + i*1.5) * math.pi), i)
	    setActorY(_G['defaultStrum'..i..'Y'] + 32 * math.cos((currentBeat + i*1.5) * math.pi), i)
	end
    end

    if curStep >= 578 and curStep < 584 then
	local currentBeat = (songPos / 1000)*(bpm/30)
	for i=0,7 do
	    setActorX(_G['defaultStrum'..i..'X'] + 32 * math.sin((currentBeat + i*1.5) * math.pi), i)
	    setActorY(_G['defaultStrum'..i..'Y'] + 32 * math.cos((currentBeat + i*1.5) * math.pi), i)
	end
    end

    if curStep >= 608 and curStep < 616 then
	local currentBeat = (songPos / 1000)*(bpm/30)
	for i=0,7 do
	    setActorX(_G['defaultStrum'..i..'X'] + 32 * math.sin((currentBeat + i*1.5) * math.pi), i)
	    setActorY(_G['defaultStrum'..i..'Y'] + 32 * math.cos((currentBeat + i*1.5) * math.pi), i)
	end
    end

    if curStep >= 96 and curStep < 128 then
	setCamZoom(1.35)
	strumLine1Visible = true
    end

    if curStep >= 128 and curStep < 255 then
	showOnlyStrums = false
    end

    for _, i in pairs({'healthBar', 'healthBar.bg', 'iconP1', 'iconP2', 'scoreTxt'}) do
	setProperty(i..'.visible', not showOnlyStrums)
    end

    for i = 0, 3 do
	setProperty('strumLineNotes.members['..i..'].alpha', strumLine1Visible and 1 or 0.001)
	setProperty('playerStrums.members['..i..'].alpha', strumLine2Visible and 1 or 0.001)
    end
end
	
function onBeatHit()
    if curStep >= 128 and curStep < 255 then
	setCamZoom(1.1)
	setHudZoom(1.05)
    end

    if curStep >= 384 and curStep < 511 then
	setCamZoom(1.1)
	setHudZoom(1.05)
    end

    if curStep >= 644 and curStep < 894 then
	setCamZoom(1.1)
	setHudZoom(1.05)
    end
end

function onStepHit()
    if curStep == 512 or curStep == 544 then
        for i = 0, 7 do
            tweenPosXAngle(i, _G['defaultStrum'..i..'X'],getActorAngle(i) + 360, 0.6, 'setDefault')
        end
    end
end

function setCamZoom(zoomAmount)
    setProperty('camGame.zoom', zoomAmount)
end

function setHudZoom(zoomAmount)
    setProperty('camHUD.zoom', zoomAmount)
end