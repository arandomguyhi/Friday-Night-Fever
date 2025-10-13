luaDebugMode = true

setProperty('camZoomingMult', 0)

local strumLine1Visible = true
local strumLine2Visible = true
local showOnlyStrums = false

function onSongStart(song)
    showOnlyStrums = true
    strumLine1Visible = false
    strumLine2Visible = false
end
	
function onUpdate(elapsed)
    if curStep == 0 then
        setHudZoom(1)
    end
	
    if curStep >= 1536 and curStep < 1792 then
        local currentBeat = (getSongPosition() / 1000)*(curBpm/60)
        for i=0,7 do
            local note = i > 3 and 'defaultPlayerStrum' or 'defaultOpponentStrum'
	    setProperty((i > 3 and 'playerStrums' or 'opponentStrums')..'.members['..(i%4)..'].x', _G[note..'X'..(i%4)] + 10 * math.sin((currentBeat + i*50) * math.pi))
            setProperty((i > 3 and 'playerStrums' or 'opponentStrums')..'.members['..(i%4)..'].y', _G[note..'Y'..(i%4)] + 10 * math.cos((currentBeat + i*0.25) * math.pi))
        end
    end

    if curStep == 128 then
        showOnlyStrums = false
        strumLine1Visible = true
        strumLine2Visible = true
    end

    if curStep >= 1216 and curStep < 1280 then
        local currentBeat = (getSongPosition() / 1000)*(curBpm/120)
        for i=0,7 do
            local note = i > 3 and 'defaultPlayerStrum' or 'defaultOpponentStrum'
	    setProperty((i > 3 and 'playerStrums' or 'opponentStrums')..'.members['..(i%4)..'].x', _G[note..'X'..(i%4)] + 25 * math.sin((currentBeat + i*50) * math.pi))
            setProperty((i > 3 and 'playerStrums' or 'opponentStrums')..'.members['..(i%4)..'].y', _G[note..'Y'..(i%4)] + 2 * math.cos((currentBeat + i*0.25) * math.pi))
        end
    end

    if curStep == 64 then
        setCamZoom(0.44) setProperty('defaultCamZoom', 0.44)
    end

    if curStep == 84 then
        setCamZoom(0.46) setProperty('defaultCamZoom', 0.46)
    end
	
    if curStep == 1792 then
        for i=0, 7 do
            local note = i > 3 and 'defaultPlayerStrum' or 'defaultOpponentStrum'
	    startTween('culol'..i, (i > 3 and 'playerStrums' or 'opponentStrums')..'.members['..(i%4)..']', {x = _G[note..'X'..(i%4)], y = _G[note..'Y'..(i%4)], angle = 0}, 0.6, {})
	end
    end
	
    if curStep == 96 then
        setCamZoom(0.48) setProperty('defaultCamZoom', 0.48)
    end

    if curStep == 116 then
        setCamZoom(0.50) setProperty('defaultCamZoom', 0.50)
    end

    if curStep == 1550 or curStep == 1582 or curStep == 1594 or curStep == 1614 or curStep == 1646 or curStep == 1662 or curStep == 1678 or curStep == 1710 or curStep == 1726 or curStep == 1742 or curStep == 1774 or curStep == 1790 then
        setCamZoom(0.41)
        setHudZoom(1.01)
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
    if curStep >= 638 and curStep < 766 or curStep >= 1278 and curStep < 1528 or curStep >= 670 and curStep < 686 or curStep >= 1854 and curStep < 2110 then
        setCamZoom(0.4025)
        setHudZoom(1.01)
    end

    if curStep >= 1534 and curStep < 1562 or curStep >= 1566 and curStep < 1624 or curStep >= 1630 and curStep < 1690 or curStep >= 1694 and curStep < 1754 or curStep >= 1758 and curStep < 1790 or curStep >= 608 and curStep < 609 or curStep >= 616 and curStep < 617 or curStep >= 624 and curStep < 625 or curStep >= 628 and curStep < 629 or curStep >= 632 and curStep < 633 or curStep >= 634 and curStep < 635 or curStep >= 636 and curStep < 637 or curStep >= 637 and curStep < 638 or curStep >= 638 and curStep < 639 or curStep >= 639 and curStep < 640 or curStep >= 640 and curStep < 641 then
        setCamZoom(0.41)
        setHudZoom(1.01)
    end
end

function setCamZoom(zoomAmount)
    --if getProperty('camZooming') then
	setProperty('camGame.zoom', zoomAmount) --else return
    --end
end

function setHudZoom(zoomAmount)
    setProperty('camHUD.zoom', zoomAmount)
end