luaDebugMode = true

setProperty('camZoomingMult', 0)

function opponentNoteHit()
    if curBeat >= 32 and curBeat < 63 or curBeat >= 224 and curBeat < 240 then
        setProperty('defaultCamZoom', getProperty('defaultCamZoom') + 0.01)
    end
end

function goodNoteHit(id,d,t)
    if t == 'No Animation' then
        playAnim('boyfriend', 'scared', true)
        setProperty('boyfriend.specialAnim', true)
    end
end

function onBeatHit()
    if curBeat >= 48 and curBeat < 48 or curBeat >= 240 and curBeat < 256 then
        setProperty('defaultCamZoom', getProperty('defaultCamZoom') + 0.01)
    end

    setProperty('camZooming', true)
    if curBeat % 4 == 0 then
        setProperty('camHUD.zoom', getProperty('camHUD.zoom') + 0.009)
    end

    if curBeat == 64 then
        setProperty('defaultCamZoom', 0.55)
        setVar('useDirectionalCamera', true)
    elseif curBeat == 32 then
        setProperty('boyfriendCameraOffset[0]', getProperty('boyfriendCameraOffset[0]')+100)
    elseif curBeat == 128 then
        setProperty('boyfriendCameraOffset[0]', getProperty('boyfriendCameraOffset[0]')-100)
        setProperty('defaultCamZoom', 0.4)
        setVar('useDirectionalCamera', false)
    elseif curBeat == 240 then
        setProperty('boyfriendCameraOffset[0]', getProperty('boyfriendCameraOffset[0]')+100)
    elseif curBeat == 256 then
        setProperty('boyfriendCameraOffset[0]', getProperty('boyfriendCameraOffset[0]')-100)
        setProperty('defaultCamZoom', 0.55)
        setVar('useDirectionalCamera', true)
    end
end