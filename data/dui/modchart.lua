luaDebugMode = true

local defaultStrumPos = {}

setProperty('camZoomingMult', 0)
function onCreatePost()
    playAnim('arm', 'idle')
    setProperty('wheel.visible', true)

    setProperty('camZooming', true)
    callOnLuas('showBubble', {'peakek'})

    for i = 0, 7 do
        table.insert(defaultStrumPos, {
            x = getPropertyFromGroup('strumLineNotes', i, 'x'),
            y = getPropertyFromGroup('strumLineNotes', i, 'y')
        })
    end
end

function onUpdate(elapsed)
    for i = 0, 7 do
        setNoteX(defaultStrumPos[i+1].x + (1 - (elapsed * 3.125)) * (getProperty('strumLineNotes.members['..i..'].x') - defaultStrumPos[i+1].x), i)
    end
end

function opponentNoteHit(id, noteData, noteType, isSustainNote)
    if noteType == 'No Animation' then
        playAnim('arm', getProperty('singAnimations')[noteData+1], true)
        setProperty('arm.holdTimer', 0)
    end
end

function goodNoteHit(id, noteData, noteType, isSustainNote)
    if noteType == 'No Animation' then
        playAnim('dad', getProperty('singAnimations')[noteData+1], true)
        setProperty('dad.holdTimer', 0)
    end
end

local weeBeats = {66, 70, 74, 78, 82, 86, 90, 94, 98, 102, 106, 110, 114, 118, 122}
local w = 1
function onBeatHit()
    if curBeat % 4 == 0 or curBeat >= 128 and curBeat < 192 and curBeat % 2 == 0 then
        setProperty('camHUD.zoom', getProperty('camHUD.zoom') + 0.02)
    end

    if curBeat == weeBeats[1] then
        for i = 0, 7 do
            local nextX = defaultStrumPos[i+1].x
            nextX = nextX + ((i < 2 or (i < 6 and i > 3)) and ((i == 0 or i == 4) and -10 or -5) or ((i == 3 or i == 7) and 10 or 5))
            startTween('weee'..i, 'strumLineNotes.members['..i..']', {x = nextX}, 0.1, {})
        end
        table.remove(weeBeats, 1)
    end

    if curBeat >= 256 and curBeat < 316 and curBeat % 2 == 0 then
        for i = 0, 7 do
            local nextX = defaultStrumPos[i+1].x
            nextX = nextX + ((curBeat % 4 == 0) and -30 or 30)
            startTween('yoo'..i, 'strumLineNotes.members['..i..']', {x = nextX}, 0.1, {})
        end
    end
end

function onStepHit()
    if curStep == 249 then
        callOnLuas('showBubble', {'wee'})
    elseif curStep == 256 then
        swapIcon('spooky', '565656')
        setProperty('gfSpeed', 2)
    elseif curStep == 499 then
        callOnLuas('showBubble', {'taki'})
    elseif curStep == 512 then
        swapIcon('taki', 'D34470')
        setProperty('gfSpeed', 1)
    elseif curStep == 752 then
        callOnLuas('showBubble', {'mako'})
    elseif curStep == 768 then
        swapIcon('mako', '60FF61')
        setProperty('gfSpeed', 2)
    elseif curStep == 1014 then
        callOnLuas('showBubble', {'hunni'})
    elseif curStep == 1024 then
        swapIcon('hunni', 'FF728A')
        setProperty('gfSpeed', 1)
    elseif curStep == 1266 then
        callOnLuas('showBubble', {'pepper'})
    elseif curStep == 1280 then
        swapIcon('pepper', '7F64DA')
        setProperty('gfSpeed', 2)
    elseif curStep == 1522 then
        callOnLuas('showBubble', {'mega'})
    elseif curStep == 1538 then
        swapIcon('mega-real', 'C90011')
        setProperty('gfSpeed', 1)
    elseif curStep == 1768 then
        callOnLuas('showBubble', {'flippy'})
    elseif curStep == 1794 then
        swapIcon('flippy-real', 'F2E416')
    elseif curStep == 2045 then
        callOnLuas('showBubble', {'food'})
    elseif curStep == 2052 then
        swapIcon('food', 'FF9EBF')
    elseif curStep == 2290 then
        callOnLuas('showBubble', {'blluu'})
    elseif curStep == 2316 then
        swapIcon('blluu', '84CCC6')
    end
end

function swapIcon(char, color)
    if char ~= 'peakek' then
        playAnim('dad', 'phone', true)
        setProperty('dad.specialAnim', true)
    end

    setProperty('healthBar.leftBar.color', getColorFromHex(color))
    callMethod('iconP2.changeIcon', {char})
    setProperty('health', 1)
end

function setNoteX(x, num)
    setProperty('strumLineNotes.members['..num..'].x', x)
end

function setNoteY(y, num)
    setProperty('strumLineNotes.members['..num..'].y', y)
end