local strumLine1Visible = true
local strumLine2Visible = true
local showOnlyStrums = false

function onUpdate(elapsed)
    songPos = getSongPosition() bpm = curBpm
    if curStep >= 384 and curStep < 1936 or curStep >= 2080 and curStep < 2592 or curStep >= 2880 and curStep < 3392 then
	local currentBeat = (songPos / 1000)*(bpm/60)
	for i=0,7 do
	    local member = i > 3 and 'defaultPlayerStrum' or 'defaultOpponentStrum'
	    setProperty('strumLineNotes.members['..i..'].x', _G[member..'X'..i%4] + 12.5 * math.sin((currentBeat + i*50) * math.pi))
	    setProperty('strumLineNotes.members['..i..'].y', _G[member..'Y'..i%4] + 8 * math.cos((currentBeat + i*0.25) * math.pi))
	end
    end

    if curStep >= 112 and curStep < 128 then
	local currentBeat = (songPos / 1000)*(bpm/120)
	for i=0,7 do
	    local member = i > 3 and 'defaultPlayerStrum' or 'defaultOpponentStrum'
	    setProperty('strumLineNotes.members['..i..'].x', _G[member..'X'..i%4] + 180 * math.sin((currentBeat + i*15) * math.pi))
	    setProperty('strumLineNotes.members['..i..'].y', _G[member..'Y'..i%4] + 12 * math.cos((currentBeat + i*0.25) * math.pi))
	end
    end

    if curStep >= 2592 and curStep < 2620 then
	local currentBeat = (songPos / 1000)*(bpm/120)
	for i=0,7 do
	    local member = i > 3 and 'defaultPlayerStrum' or 'defaultOpponentStrum'
	    setProperty('strumLineNotes.members['..i..'].x', _G[member..'X'..i%4] + 20 * math.sin((currentBeat + i*15) * math.pi))
	    setProperty('strumLineNotes.members['..i..'].y', _G[member..'Y'..i%4] + 20 * math.cos((currentBeat + i*0.25) * math.pi))
	end
    end

    if curStep >= 64 and curStep < 112 then
	local currentBeat = (songPos / 1000)*(bpm/120)
	for i=0,7 do
	    local member = i > 3 and 'defaultPlayerStrum' or 'defaultOpponentStrum'
	    setProperty('strumLineNotes.members['..i..'].x', _G[member..'X'..i%4] + 12.5 * math.sin((currentBeat + i*50) * math.pi))
	end
    end

    if curStep >= 1 and curStep < 4 or curStep >= 16 and curStep < 20 or curStep >= 32 and curStep < 36 or curStep >= 48 and curStep < 52 then
	local currentBeat = (songPos / 1000)*(bpm/40.5)
	for i=0,7 do
	    local member = i > 3 and 'defaultPlayerStrum' or 'defaultOpponentStrum'
	    setProperty('strumLineNotes.members['..i..'].x', _G[member..'X'..i%4] + 12.5 * math.sin((currentBeat + i*50) * math.pi))
	end
    end

    if curStep >= 8 and curStep < 12 or curStep >= 24 and curStep < 28 or curStep >= 40 and curStep < 44 or curStep >= 56 and curStep < 60 then
	local currentBeat = (songPos / 1000)*(bpm/40.5)
	for i=0,7 do
	    local member = i > 3 and 'defaultPlayerStrum' or 'defaultOpponentStrum'
	    setProperty('strumLineNotes.members['..i..'].x', _G[member..'X'..i%4] + -12.5 * math.sin((currentBeat + i*50) * math.pi))
	end
    end

    if curStep == 1420 or curStep == 1936 then
	setCamZoom(0.69)
	setHudZoom(1.08)
    end

    if curStep >= 128 and curStep < 144 or curStep >= 1936 and curStep < 1952 or curStep >= 2624 and curStep < 2640 or curStep >= 3392 and curStep < 3408 then
	for i=0,7 do
	    local note = i > 3 and 'defaultPlayerStrum' or 'defaultOpponentStrum'
	    startTween('culol'..i, (i > 3 and 'playerStrums' or 'opponentStrums')..'.members['..(i%4)..']', {x = _G[note..'X'..(i%4)], y = _G[note..'Y'..(i%4)], angle = 0}, 0.6, {})
	end
    end

    if curStep == 1952 then
	showOnlyStrums = true
	strumLine1Visible = false
	strumLine2Visible = false
    end

    if curStep == 2624 or curStep == 3392 then
	strumLine1Visible = false
    end

    if curStep == 2744 or curStep == 3648 then
	strumLine1Visible = true
    end

    if curStep == 2080 then
	showOnlyStrums = false
	strumLine1Visible = true
	strumLine2Visible = true
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
    if curStep >= 384 and curStep < 1406 or curStep >= 1422 and curStep < 1548 or curStep >= 1554 and curStep < 1804 or curStep >= 1810 and curStep < 1932 or curStep >= 2078 and curStep < 2590 or curStep >= 2878 and curStep < 3004 or curStep >= 3010 and curStep < 3260 or curStep >= 3266 and curStep < 3394 then
	setCamZoom(0.62)
	setHudZoom(1.02)
    end
end

function setCamZoom(zoomAmount)
    setProperty('camGame.zoom', zoomAmount)
end

function setHudZoom(zoomAmount)
    setProperty('camHUD.zoom', zoomAmount)
end