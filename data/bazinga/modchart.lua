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
	
function onUpdate(elapsed)
    if curStep >= 0 and curStep < 94 then
	snapCamera(getVar('bfCamX'), getVar('bfCamY') + 120, curStep < 93 and true or false)
	setProperty('camGame.zoom', 0.97)
    end

    if curStep >= 129 and curStep < 375 then
	strumLine1Visible = true
	strumLine2Visible = true
	showOnlyStrums = false
	local currentBeat = (getSongPosition() / 1000)*(curBpm/120)
	for i=0,3 do
	    setProperty('opponentStrums.members['..i..'].x', _G['defaultOpponentStrumX'..i] + 25 * math.sin((currentBeat + i*50) * math.pi))
	    setProperty('opponentStrums.members['..i..'].y', _G['defaultOpponentStrumY'..i] + 5 * math.cos((currentBeat + i*0.25) * math.pi))
	end
    end
			
    if curStep >= 384 and curStep < 448 then
	strumLine2Visible = false
	local currentBeat = (getSongPosition() / 1000)*(curBpm/120)
	for i=0,3 do
	    setProperty('opponentStrums.members['..i..'].x', _G['defaultOpponentStrumX'..i] + 5 * math.sin((currentBeat + i*50) * math.pi))
	    setProperty('opponentStrums.members['..i..'].y', _G['defaultOpponentStrumY'..i] + 25 * math.cos((currentBeat + i*0.25) * math.pi))
	    for i=0, 7 do
		local note = i > 3 and 'defaultPlayerStrum' or 'defaultOpponentStrum'
		startTween('culol'..i, (i > 3 and 'playerStrums' or 'opponentStrums')..'.members['..(i%4)..']', {x = _G[note..'X'..(i%4)], y = _G[note..'Y'..(i%4)], angle = 0}, 0.6, {})
	    end
	end
    end
	
    if curStep >= 448 and curStep < 456 then
	strumLine1Visible = true
	strumLine2Visible = true
    end
	
    if curStep >= 456 and curStep < 504 then
	strumLine1Visible = false
	local currentBeat = (getSongPosition() / 1000)*(curBpm/120)
	for i=0,7 do
	    local member = i > 3 and 'defaultPlayerStrum' or 'defaultOpponentStrum'
	    setProperty('strumLineNotes.members['..i..'].x', _G[member..'X'..(i%4)] + 5 * math.sin((currentBeat + i*50) * math.pi))
	    setProperty('strumLineNotes.members['..i..'].y', _G[member..'Y'..(i%4)] + 25 * math.cos((currentBeat + i*0.25) * math.pi))
	end
    end
	
    if curStep >= 504 and curStep < 512 then
	setCamZoom(1)
	for i=0, 7 do
	    local note = i > 3 and 'defaultPlayerStrum' or 'defaultOpponentStrum'
	    startTween('culol'..i, (i > 3 and 'playerStrums' or 'opponentStrums')..'.members['..(i%4)..']', {x = _G[note..'X'..(i%4)], y = _G[note..'Y'..(i%4)], angle = 0}, 0.6, {})
	end
    end
	
    if curStep >= 512 and curStep < 768 then
	strumLine1Visible = true
	showOnlyStrums = true
	local currentBeat = (getSongPosition() / 1000)*(curBpm/240)
	for i=0,7 do
	    local member = i > 3 and 'defaultPlayerStrum' or 'defaultOpponentStrum'
	    setProperty('strumLineNotes.members['..i..'].x', _G[member..'X'..(i%4)] + 25 * math.sin((currentBeat + i*50) * math.pi))
	    setProperty('strumLineNotes.members['..i..'].y', _G[member..'Y'..(i%4)] + 2 * math.cos((currentBeat + i*0.25) * math.pi))
	end
    end
	
    if curStep >= 768 and curStep < 1024 then
	showOnlyStrums = false
	local currentBeat = (getSongPosition() / 1000)*(curBpm/120)
	for i=0,3 do
	    setProperty('opponentStrums.members['..i..'].x', _G['defaultOpponentStrumX'..i] + 25 * math.sin((currentBeat + i*50) * math.pi))
	    setProperty('opponentStrums.members['..i..'].y', _G['defaultOpponentStrumY'..i] + 5 * math.cos((currentBeat + i*0.25) * math.pi))
	end
    end
	
    if curStep >= 1024 and curStep < 1088 then
	strumLine1Visible = true
	local currentBeat = (getSongPosition() / 1000)*(curBpm/120)
	for i=0,7 do
	    local member = i > 3 and 'defaultPlayerStrum' or 'defaultOpponentStrum'
	    setProperty('strumLineNotes.members['..i..'].x', _G[member..'X'..(i%4)] + 25 * math.sin((currentBeat + i*50) * math.pi))
	    setProperty('strumLineNotes.members['..i..'].y', _G[member..'Y'..(i%4)] + 2 * math.cos((currentBeat + i*0.25) * math.pi))
	end
    end
	
    if curStep >= 1088 and curStep < 1120 then
	strumLine1Visible = true
	local currentBeat = (getSongPosition() / 1000)*(curBpm/60)
	for i=0,7 do
	    local member = i > 3 and 'defaultPlayerStrum' or 'defaultOpponentStrum'
	    setProperty('strumLineNotes.members['..i..'].x', _G[member..'X'..(i%4)] + 25 * math.sin((currentBeat + i*50) * math.pi))
	    setProperty('strumLineNotes.members['..i..'].y', _G[member..'Y'..(i%4)] + 2 * math.cos((currentBeat + i*0.25) * math.pi))
	end
    end
	
    if curStep >= 1088 and curStep < 1120 then
	for i=0, 7 do
	    local note = i > 3 and 'defaultPlayerStrum' or 'defaultOpponentStrum'
	    startTween('culol'..i, (i > 3 and 'playerStrums' or 'opponentStrums')..'.members['..(i%4)..']', {x = _G[note..'X'..(i%4)], y = _G[note..'Y'..(i%4)], angle = 0}, 0.6, {})
	end
    end
	
    if curStep >= 1152 and curStep < 1408 then
	showOnlyStrums = true
	local currentBeat = (getSongPosition() / 1000)*(curBpm/240)
	for i=0,7 do
	    local member = i > 3 and 'defaultPlayerStrum' or 'defaultOpponentStrum'
	    setProperty('strumLineNotes.members['..i..'].x', _G[member..'X'..(i%4)] + 25 * math.sin((currentBeat + i*50) * math.pi))
	end
    end
	
    if curStep == 1408 then
	showOnlyStrums = false
	setCamZoom(0.47 + 0.05)
    end
	
    if curStep == 1472 then
	strumLine1Visible = false
	showOnlyStrums = true
	setCamZoom(0.47 + 0.05)
    end
	
    if curStep >= 1536 and curStep < 1598 then
	showOnlyStrums = false
	strumLine1Visible = true	
	local currentBeat = (getSongPosition() / 1000)*(curBpm/120)
	for i=0,7 do
	    local member = i > 3 and 'defaultPlayerStrum' or 'defaultOpponentStrum'
	    setProperty('strumLineNotes.members['..i..'].x', _G[member..'X'..(i%4)] + 25 * math.sin((currentBeat + i*50) * math.pi))
	end
    end
	
    if curStep >= 1598 and curStep < 1632 then
	local currentBeat = (getSongPosition() / 1000)*(curBpm/60)
	for i=0,7 do
	    local member = i > 3 and 'defaultPlayerStrum' or 'defaultOpponentStrum'
	    setProperty('strumLineNotes.members['..i..'].x', _G[member..'X'..(i%4)] + 25 * math.sin((currentBeat + i*50) * math.pi))
	end
    end
	
    if curStep >= 1664 and curStep < 1920 then
	showOnlyStrums = true
	local currentBeat = (getSongPosition() / 1000)*(curBpm/240)
	for i=0,7 do
	    local member = i > 3 and 'defaultPlayerStrum' or 'defaultOpponentStrum'
	    setProperty('strumLineNotes.members['..i..'].x', _G[member..'X'..(i%4)] + 25 * math.sin((currentBeat + i*50) * math.pi))
	end
    end
	
    if curStep == 1921 then
	setCamZoom(0.47 + 0.05)
    end
	
    if curStep >= 2014 and curStep < 2044 then
	setCamZoom(1)
    end
	
    if curStep >= 1920 then
	strumLine1Visible = false
	strumLine2Visible = false
	showOnlyStrums = false
    end
	
    if curStep >= 1984 then
	showOnlyStrums = true
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
    if curStep >= 512 and curStep < 756 or curStep >= 1152 and curStep < 1408 or curStep >= 1664 and curStep < 1920 then
	setCamZoom(0.47 + 0.02)
    end
end

function onStepHit()
    if curStep == 121 then
	setProperty('health', getProperty('health') + 0.32)
    elseif curStep == 1476 or curStep == 1508 then
	setProperty('defaultCamZoom', 0.95)
    elseif curStep == 1500 or curStep == 1522 then
	setProperty('defaultCamZoom', 0.6)
    elseif curStep == 1524 then
	setProperty('health', getProperty('health') + 0.40)
    end
end

function setCamZoom(zoomAmount)
    setProperty('camGame.zoom', zoomAmount)
end

function setHudZoom(zoomAmount)
    setProperty('camHUD.zoom', zoomAmount)
end