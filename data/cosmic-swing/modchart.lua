luaDebugMode = true

setProperty('camZoomingMult', 0)

function onStepHit()
    if curStep == 246 then
        playAnim('arm', 'phone')
        playAnim('dad', 'phone', true) setProperty('dad.specialAnim', true)
    end

    if curStep == 248 then
        callOnLuas('showBubble', {'yukichi'})
    end

    if curStep == 800 then
        callMethod('iconP2.changeIcon', {'rolldog'})
        setProperty('healthBar.leftBar.color', getColorFromHex('AEA28E'))
        startTween('eita', 'camGame.scroll', {x = getProperty('camGame.scroll.x') - 125}, 1, {})
    elseif curStep == 834 then
        startTween('deseita', 'camGame.scroll', {x = getProperty('camGame.scroll.x') + 125}, 0.4, {})
        setProperty('defaultCamZoom', 0.9)
    elseif curStep == 848 then
        callMethod('iconP2.changeIcon', {'yukichi'})
        setProperty('healthBar.leftBar.color', getColorFromHex('FF97F0'))
    end
end

function opponentNoteHit(id,noteData)
    if curStep >= 800 and curStep < 834 then
        playAnim('dad', getProperty('singAnimations')[noteData+1]..'-craze', true)
        setProperty('dad.holdTimer', 0)
        setProperty('defaultCamZoom', getProperty('defaultCamZoom') + 0.01)
    end
end

function onBeatHit()
    if curBeat % 2 == 0 then
        setProperty('camZooming', true)
        setProperty('camHUD.zoom', getProperty('camHUD.zoom') + ((curBeat % 4 == 0) and 0.02 or 0.01))
    end
end

function onUpdate()
    if getProperty('arm.animation.curAnim.name') == 'phone' and getProperty('arm.animation.curAnim.finished') then
        setProperty('wheel.visible', true)
        callMethod('iconP2.changeIcon', {'yukichi'})
        setProperty('healthBar.leftBar.color', getColorFromHex('FF97F0'))
        setProperty('health', 1)
    end
end