luaDebugMode = true

local defaultStrumPos = {}

setProperty('camZoomingMult', 0)

function onCreatePost()
    for i = 0, 7 do
        table.insert(defaultStrumPos, {
            x = getPropertyFromGroup('strumLineNotes', i, 'x'),
            y = getPropertyFromGroup('strumLineNotes', i, 'y')
        })
    end
end

function onUpdatePost(elapsed)
    local currentBeat = (getSongPosition() / 1000) * (curBpm / 60)

    if curBeat > 0 then
        for i = 0, 7 do
            setNoteX(defaultStrumPos[i+1].x + (1 - (elapsed * 3.125)) * (getProperty('strumLineNotes.members['..i..'].x') - defaultStrumPos[i+1].x), i)

            if curBeat >= 64 and curBeat < 128 or curBeat > 159 and curBeat < 192 or curBeat > 287 and curBeat < 356 then
                setNoteY(defaultStrumPos[i+1].y + (4 * math.sin(currentBeat * math.pi)), i)
            else
                setNoteY(defaultStrumPos[i+1].y + 2 * math.sin(currentBeat * math.pi), i)
            end
        end
    end
end

local bfZoomSteps = {238, 242, 244, 245, 247, 250, 252}
local zoomSteps = {65, 71, 77, 81, 87, 93}
local zoomOutSteps = {96, 102, 108, 113, 118, 124}
local beat = 2.5

function onBeatHit()
    if getProperty('camZooming') and curBeat % 2 == 0 and (curBeat < 256 or curBeat > 287) then
        if curBeat >= 288 and curBeat < 351 then
            setProperty('camHUD.zoom', getProperty('camHUD.zoom') + 0.043)
        elseif curBeat > 63 and curBeat < 128 and curBeat > 159 and curBeat < 192 or curBeat > 351 and curBeat < 356 then
            setProperty('camHUD.zoom', getProperty('camHUD.zoom') + 0.036)
        else
            setProperty('camHUD.zoom', getProperty('camHUD.zoom') + 0.025)
        end
    end

    if curBeat == 64 then
        cameraFlash('camGame', 'ffffff', 0.45)
        setProperty('defaultCamZoom', 0.5)
        setProperty('camGame.zoom', getProperty('defaultCamZoom'))
    end

    if curBeat == 256 then
        setProperty('defaultCamZoom', 0.5)
    end

    if curBeat == 356 then
        startTween('coisazoom', 'game', {defaultCamZoom = 0.5}, 1.4, {})
        for i = 0,7 do
            startTween('noarrow'..i, 'strumLineNotes.members['..i..']', {alpha = 0}, 1.4, {})
        end
    end

    if curBeat >= 64 and curBeat < 128 or curBeat > 159 and curBeat < 192 or curBeat > 287 and curBeat < 356 then
        for i = 0,7 do
            local nextX = defaultStrumPos[i+1].x
            nextX = nextX + ((4 * beat) * (curBeat % 2 == 0 and -1 or 1))
            if curBeat == 288 then
                nextX = nextX + ((i < 2 or i < 6 and i > 3) and ((i == 0 or i == 4) and -45 or -25) or ((i == 3 or i == 7) and 45 or 25))
            end
            startTween('weee'..i, 'strumLineNotes.members['..i..']', {x = nextX, ['scale.y'] = 0.7}, 0.1, {})
        end
    end
end

local z,zO,zB = 1,1,1
function onStepHit()
    if zoomSteps[z] and curStep == zoomSteps[z] then
        setProperty('camGame.zoom', getProperty('camGame.zoom') + 0.015)
        z=z+1
    elseif zoomOutSteps[zO] and curStep == zoomOutSteps[zO] then
        setProperty('camGame.zoom', getProperty('camGame.zoom') - 0.015)

        if zO == #zoomOutSteps then
            setProperty('defaultCamZoom', getProperty('defaultCamZoom') + 0.15)
            setVar('useDirectionalCamera', true)
        end

        zO=zO+1
    elseif bfZoomSteps[zB] and curStep == bfZoomSteps[zB] then
        setProperty('defaultCamZoom', getProperty('defaultCamZoom') + 0.012)
    end

    if curStep >= 1144 and curStep < 1152 and curStep % 2 == 0 then
        setProperty('defaultCamZoom', getProperty('defaultCamZoom') + 0.04)
        if curStep < 1150 then
            setProperty('camGame.zoom', getProperty('defaultCamZoom'))
        end
    end

    if curStep >= 1552 then
        setVar('useDirectionalCamera', true)
    end

    if curStep == 515 then
        setProperty('defaultCamZoom', getProperty('defaultCamZoom') + 0.14)
    elseif curStep == 641 then
        setProperty('defaultCamZoom', getProperty('defaultCamZoom') + 0.05)
    elseif curStep == 770 then
        setProperty('defaultCamZoom', getProperty('defaultCamZoom') - 0.05)
    elseif curStep == 834 or curStep == 896 or curStep == 961 then
        setProperty('defaultCamZoom', 0.64)
    end
end

function opponentNoteHit()
    if curBeat >= 200 and curBeat < 207 or curBeat >= 228 and curBeat <= 239 then
        setProperty('defaultCamZoom', getProperty('defaultCamZoom') + 0.005)
    end
end

function goodNoteHit()
    if curBeat >= 212 and curBeat < 223 or curBeat >= 244 and curBeat <= 255 then
        setProperty('defaultCamZoom', getProperty('defaultCamZoom') + 0.005)
    end
end

function setNoteX(x, num)
    setProperty('strumLineNotes.members['..num..'].x', x)
end

function setNoteY(y, num)
    setProperty('strumLineNotes.members['..num..'].y', y)
end