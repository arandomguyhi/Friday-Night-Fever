luaDebugMode = true

setProperty('camZoomingMult', 0)

function setHUDVisible(visible)
    for _, i in pairs({'iconP1', 'iconP2', 'healthBar', 'scoreTxt'}) do
        setProperty(i..'.visible', visible)
    end

    for i = 0, 7 do
        setProperty('strumLineNotes.members['..i..'].visible', visible)
    end
end

local introBumps = {40, 50, 57, 59, 60, 61, 62, 63}

function onStepHit()
    if curStep == introBumps[1] then
        setProperty('camGame.zoom', getProperty('camGame.zoom') + 0.02)
        table.remove(introBumps, 1)
    end
end

function onBeatHit()
    handleNonEvents(curBeat)
end

function handleNonEvents(curBeat)
    if curBeat == 1 then
        setProperty('camGame.zoom', getProperty('camGame.zoom') + 0.02)
    elseif curBeat == 4 then
        setProperty('camGame.zoom', getProperty('camGame.zoom') + 0.02)
    elseif curBeat == 8 then
        setProperty('camGame.zoom', getProperty('camGame.zoom') + 0.02)
    elseif curBeat == 16 then
        setHUDVisible(true)
    end

    if curBeat >= 80 and curBeat < 432 and curBeat % 4 == 0 then
        setProperty('camGame.zoom', getProperty('camGame.zoom') + 0.005)
    end
end