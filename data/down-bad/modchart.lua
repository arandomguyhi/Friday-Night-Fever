local strumLine1Visible = true
local strumLine2Visible = true
local showOnlyStrums = false

setProperty('camZoomingMult', 0)

function onSongStart(song)
    setCamZoom(1.2)
    --setHudZoom(2)
    showOnlyStrums = true
    strumLine1Visible = false
    strumLine2Visible = false
end

function onUpdate(elapsed) songPos = getSongPosition()
    if curStep >= 0 and curStep < 64 then
        setCamZoom(1.2)
        setHudZoom(1)
    end

    if curStep == 64 then
        setCamZoom(1)
    end

    if curStep >= 128 and curStep < 192 then
        setCamZoom(1.1)
    end

    if curStep == 192 then
        setCamZoom(1)
    end

    if curStep >= 256 and curStep < 512 then
        strumLine1Visible = true
        strumLine2Visible = true
        showOnlyStrums = false
        local currentBeat = (songPos / 1000)*(curBpm/30)
        for i=0,3 do
	    setProperty('opponentStrums.members['..i..'].x', _G['defaultOpponentStrumX'..i] + 5 * math.sin((currentBeat + i*50) * math.pi))
	    setProperty('opponentStrums.members['..i..'].y', _G['defaultOpponentStrumY'..i] + 10 * math.cos((currentBeat + i*0.25) * math.pi))
	end
    end

    if curStep >= 512 and curStep < 704 then
        local currentBeat = (songPos / 1000)*(curBpm/30)
        for i=0,3 do
	    setProperty('opponentStrums.members['..i..'].x', _G['defaultOpponentStrumX'..i] + 2 * math.sin((currentBeat + i*50) * math.pi))
	    setProperty('opponentStrums.members['..i..'].y', _G['defaultOpponentStrumY'..i] + 2 * math.cos((currentBeat + i*0.25) * math.pi))
	end
    end

    if curStep >= 768 and curStep < 1024 then
        local currentBeat = (songPos / 1000)*(curBpm/30)
	for i=0,3 do
	    setProperty('opponentStrums.members['..i..'].x', _G['defaultOpponentStrumX'..i] + 5 * math.sin((currentBeat + i*50) * math.pi))
	    setProperty('opponentStrums.members['..i..'].y', _G['defaultOpponentStrumY'..i] + 10 * math.cos((currentBeat + i*0.25) * math.pi))
	end
    end

    if curStep >= 1024 and curStep < 1248 then
        local currentBeat = (songPos / 1000)*(curBpm/30)
        for i=0,3 do
	    setProperty('opponentStrums.members['..i..'].x', _G['defaultOpponentStrumX'..i] + 2 * math.sin((currentBeat + i*50) * math.pi))
	    setProperty('opponentStrums.members['..i..'].y', _G['defaultOpponentStrumY'..i] + 2 * math.cos((currentBeat + i*0.25) * math.pi))
	end
    end

    if curStep >= 1280 and curStep < 1792 then
	local currentBeat = (songPos / 1000)*(curBpm/30)
	for i=0,3 do
	    setProperty('opponentStrums.members['..i..'].x', _G['defaultOpponentStrumX'..i] + 5 * math.sin((currentBeat + i*50) * math.pi))
	    setProperty('opponentStrums.members['..i..'].y', _G['defaultOpponentStrumY'..i] + 10 * math.cos((currentBeat + i*0.25) * math.pi))
	end
    end


    if curStep >= 1792 then
        setCamZoom(1)
        showOnlyStrums = true
        strumLine1Visible = false
        strumLine2Visible = false
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
    if curStep >= 256 and curStep < 512 or curStep >= 768 and curStep < 1024 or curStep >= 1280 and curStep < 1792 then
        setCamZoom(0.95)
    end
end

function setCamZoom(targetZoom)
    setProperty('camGame.zoom', targetZoom)
end

function setHudZoom(targetZoom)
    setProperty('camHUD.zoom', targetZoom)
end