-- essa taki ta toda amostradinha, lá ele

local showOnlyStrums = false

luaDebugMode = true
function onCreate()
    setProperty('camZoomingMult', 0)
end

function onUpdate(elapsed)
    if curStep >= 1 and curStep < 240 then
	local currentBeat = (getSongPosition() / 1000)*(curBpm/120)
	for i=0,7 do
	    local note = i > 3 and 'defaultPlayerStrum' or 'defaultOpponentStrum'
	    setProperty((i > 3 and 'playerStrums' or 'opponentStrums')..'.members['..(i%4)..'].x', _G[note..'X'..(i%4)] + 55 * math.sin((currentBeat + i*15) * math.pi))
	end
    end

    if curStep >= 240 and curStep < 254 or curStep >= 376 and curStep < 384 or curStep >= 632 and curStep < 640 or curStep >= 1032 and curStep < 1040 or curStep >= 1168 and curStep < 1174 or curStep >= 1296 and curStep < 1304 or curStep >= 1664 and curStep < 1672 or curStep >= 1936 and curStep < 1952 then
	local currentBeat = (getSongPosition() / 1000)*(curBpm/120)
	for i=0, 7 do
	    local note = i > 3 and 'defaultPlayerStrum' or 'defaultOpponentStrum'
	    startTween('culol'..i, (i > 3 and 'playerStrums' or 'opponentStrums')..'.members['..(i%4)..']', {x = _G[note..'X'..(i%4)], y = _G[note..'Y'..(i%4)], angle = 0}, 0.6, {})
	end
    end

    if curStep >= 384 and curStep < 480 then
	local currentBeat = (getSongPosition() / 1000)*(curBpm/120)
	for i=0,7 do
	    local note = i > 3 and 'defaultPlayerStrum' or 'defaultOpponentStrum'
	    setProperty((i > 3 and 'playerStrums' or 'opponentStrums')..'.members['..(i%4)..'].x', _G[note..'X'..(i%4)] + 15 * math.sin((currentBeat + i*15) * math.pi))	
	end
    end

    if curStep >= 512 and curStep < 632 then
	local currentBeat = (getSongPosition() / 1000)*(curBpm/120)
	for i=0,7 do
	    local note = i > 3 and 'defaultPlayerStrum' or 'defaultOpponentStrum'
	    setProperty((i > 3 and 'playerStrums' or 'opponentStrums')..'.members['..(i%4)..'].x', _G[note..'X'..(i%4)] + 15 * math.sin((currentBeat + i*0.25) * math.pi))
	    setProperty((i > 3 and 'playerStrums' or 'opponentStrums')..'.members['..(i%4)..'].y', _G[note..'Y'..(i%4)] + 3 * math.cos((currentBeat + i*0.25) * math.pi))	
	end
    end

    if curStep >= 256 and curStep < 376 or curStep >= 1424 and curStep < 1544 then
	local currentBeat = (getSongPosition() / 1000)*(curBpm/60)
	for i=0,7 do
	    local note = i > 3 and 'defaultPlayerStrum' or 'defaultOpponentStrum'
	    setProperty((i > 3 and 'playerStrums' or 'opponentStrums')..'.members['..(i%4)..'].y', _G[note..'Y'..(i%4)] + 20 * math.sin((currentBeat + i*50) * math.pi))
	    setProperty((i > 3 and 'playerStrums' or 'opponentStrums')..'.members['..(i%4)..'].x', _G[note..'X'..(i%4)] + 5 * math.sin((currentBeat + i*35) * math.pi))	
	end
    end

    if curStep >= 640 and curStep < 656 or curStep >= 672 and curStep < 688 or curStep >= 704 and curStep < 720 or curStep >= 736 and curStep < 752 then
	local currentBeat = (getSongPosition() / 1000)*(curBpm/30)
	for i=0,7 do
	    local note = i > 3 and 'defaultPlayerStrum' or 'defaultOpponentStrum'
	    setProperty((i > 3 and 'playerStrums' or 'opponentStrums')..'.members['..(i%4)..'].x', _G[note..'X'..(i%4)]  + 20 * math.sin((currentBeat + i*20) * math.pi))	
	end
    end

    if curStep >= 1552 and curStep < 1568 or curStep >= 1584 and curStep < 1600 or curStep >= 1616 and curStep < 1632 or curStep >= 1648 and curStep < 1664 then
	local currentBeat = (getSongPosition() / 1000)*(curBpm/30)
	for i=0,7 do
	    local note = i > 3 and 'defaultPlayerStrum' or 'defaultOpponentStrum'
	    setProperty((i > 3 and 'playerStrums' or 'opponentStrums')..'.members['..(i%4)..'].x', _G[note..'X'..(i%4)] + 20 * math.sin((currentBeat + i*20) * math.pi))	
	end
    end

    if curStep >= 768 and curStep < 784 then
	local currentBeat = (getSongPosition() / 1000)*(curBpm/5)
	for i=0,3 do
	    setProperty('opponentStrums.members['..i..'].x', _G['defaultOpponentStrumX'..i] + 5 * math.sin((currentBeat + i*0.25) * math.pi))
	    setProperty('opponentStrums.members['..i..'].y', _G['defaultOpponentStrumY'..i] + 5 * math.cos((currentBeat + i*0.25) * math.pi))
	end
    end

    if curStep >= 1108 and curStep < 1111 or curStep >= 1120 and curStep < 1128 or curStep >= 1134 and curStep < 1138 or curStep >= 1142 and curStep < 1168 or curStep >= 1237 and curStep < 1240 or curStep >= 1244 and curStep < 1269 then
	local currentBeat = (getSongPosition() / 1000)*(curBpm/10)
	for i=0,3 do
	    setProperty('opponentStrums.members['..i..'].x', _G['defaultOpponentStrumX'..i] + 5 * math.sin((currentBeat + i*0.25) * math.pi))
	    setProperty('opponentStrums.members['..i..'].y', _G['defaultOpponentStrumY'..i] + 5 * math.cos((currentBeat + i*0.25) * math.pi))	
	end
    end

    if curStep >= 1360 and curStep < 1416 then
	local currentBeat = (getSongPosition() / 1000)*(curBpm/5)
	for i=0,3 do
	    setProperty('opponentStrums.members['..i..'].x', _G['defaultOpponentStrumX'..i] + 10 * math.sin((currentBeat + i*0.25) * math.pi))
	    setProperty('opponentStrums.members['..i..'].y', _G['defaultOpponentStrumY'..i] + 10 * math.cos((currentBeat + i*0.25) * math.pi))	
	end
    end

    if curStep >= 1269 and curStep < 1272 then
	local currentBeat = (getSongPosition() / 1000)*(curBpm/8)
	for i=0,3 do
	    setProperty('opponentStrums.members['..i..'].x', _G['defaultOpponentStrumX'..i] + 5 * math.sin((currentBeat + i*0.25) * math.pi))
	    setProperty('opponentStrums.members['..i..'].y', _G['defaultOpponentStrumY'..i] + 5 * math.cos((currentBeat + i*0.25) * math.pi))
	end
    end

    if curStep >= 784 and curStep < 1032 then
	local currentBeat = (getSongPosition() / 1000)*(curBpm/60)
	for i=0,7 do
	    local note = i > 3 and 'defaultPlayerStrum' or 'defaultOpponentStrum'
	    setProperty((i > 3 and 'playerStrums' or 'opponentStrums')..'.members['..(i%4)..'].x', _G[note..'X'..(i%4)] + 10 * math.sin((currentBeat + i*0.25) * math.pi))
	    setProperty((i > 3 and 'playerStrums' or 'opponentStrums')..'.members['..(i%4)..'].y', _G[note..'Y'..(i%4)] + 5 * math.cos((currentBeat + i*0.25) * math.pi))	
	end
    end

    if curStep >= 1680 and curStep < 1936 then
	local currentBeat = (getSongPosition() / 1000)*(curBpm/240)
	for i=0,7 do
	    local note = i > 3 and 'defaultPlayerStrum' or 'defaultOpponentStrum'
	    setProperty((i > 3 and 'playerStrums' or 'opponentStrums')..'.members['..(i%4)..'].x', _G[note..'X'..(i%4)] + 25 * math.sin((currentBeat + i*0.25) * math.pi))
	end
    end

    if curStep == 642 or curStep == 646 or curStep == 650 or curStep == 654 then
	setCamZoom(0.52)
	setHudZoom(1.02)
    end

    if curStep == 674 or curStep == 678 or curStep == 682 or curStep == 686 then
	setCamZoom(0.52)
	setHudZoom(1.02)
    end

    if curStep == 706 or curStep == 710 or curStep == 714 or curStep == 718 then
	setCamZoom(0.52)
	setHudZoom(1.02)
    end

    if curStep == 738 or curStep == 742 or curStep == 746 or curStep == 750 then
	setCamZoom(0.52)
	setHudZoom(1.02)
    end

    if curStep == 1680 then
	setCamZoom(0.51)
	setHudZoom(1.01)
	showOnlyStrums = true
    end

    if curStep == 1936 then
	setCamZoom(0.51)
	setHudZoom(1.01)
	showOnlyStrums = false
    end

    for _, i in pairs({'healthBar', 'healthBar.bg', 'iconP1', 'iconP2', 'scoreTxt'}) do
	setProperty(i..'.visible', not showOnlyStrums)
    end
end

function onBeatHit()
    if curStep >= 256 and curStep < 478 or curStep >= 510 and curStep < 654 or curStep >= 670 and curStep < 686 or curStep >= 702 and curStep < 718 or curStep >= 734 and curStep < 750 or curStep >= 782 and curStep < 1038 or curStep >= 1422 and curStep < 1566 or curStep >= 1582 and curStep < 1598 or curStep >= 1614 and curStep < 1630 or curStep >= 1646 and curStep < 1662 then
	setCamZoom(0.52)
	setHudZoom(1.02)
    end
end

function onStepHit()
    if curStep >= 1215 and curStep < 1231 or curStep >= 1279 and curStep < 1291 or curStep >= 1295 and curStep < 1407 then
	setCamZoom(0.51)
	setHudZoom(1.01)
    end
end

function setCamZoom(zoomAmount)
    setProperty('camGame.zoom', zoomAmount)
end

function setHudZoom(zoomAmount)
    setProperty('camHUD.zoom', zoomAmount)
end