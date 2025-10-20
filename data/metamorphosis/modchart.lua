local strumLine1Visible = true
local strumLine2Visible = true
local showOnlyStrums = false

function onSongStart(song)
    setCamZoom(1)
    setHudZoom(2)
    showOnlyStrums = true
    strumLine1Visible = false
    strumLine2Visible = false
end

function onUpdate(elapsed)
    if curStep == 0 then
        setHudZoom(1)
    end

    if curStep >= 124 and curStep < 128 then
        setCamZoom(2)
    end

    if curStep == 128 then
        showOnlyStrums = false
        strumLine1Visible = true
        strumLine2Visible = true
    end

    if curStep >= 1020 then
        setCamZoom(2)
    end

    for _, i in pairs({'healthBar', 'healthBar.bg', 'iconP1', 'iconP2', 'scoreTxt'}) do
	setProperty(i..'.visible', not showOnlyStrums)
    end

    for i = 0, 3 do
	setProperty('strumLineNotes.members['..i..'].alpha', strumLine1Visible and 1 or 0.001)
	setProperty('playerStrums.members['..i..'].alpha', strumLine2Visible and 1 or 0.001)
    end
end

function onStepHit()
    setVar('directionalCameraDist', 10)
    if curStep == 128 or curStep == 384 or curStep == 527 or curStep == 560 or curStep == 592 or curStep == 623 then
        setVar('useDirectionalCamera', true)
    elseif curStep == 255 or curStep == 511 or curStep == 543 or curStep == 575 or curStep == 607 then
        setVar('useDirectionalCamera', false)
    end
end

function onBeatHit()
    if curBeat == 160 then
        setProperty('gfSpeed', 1)
    elseif curBeat == 128 then
        setProperty('gfSpeed', 2)
    end
end

function setCamZoom(zoomAmount)
    setProperty('camGame.zoom', zoomAmount)
end

function setHudZoom(zoomAmount)
    setProperty('camHUD.zoom', zoomAmount)
end