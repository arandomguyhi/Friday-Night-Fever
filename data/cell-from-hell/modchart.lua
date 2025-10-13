luaDebugMode = true

setProperty('camZoomingMult', 0)

function onStepHit()
    if curStep == 2 then
        playAnim('dad', 'phone', true) setProperty('dad.specialAnim', true)
        callOnLuas('showBubble', {'hallow'})
    elseif curStep == 12 then
        playAnim('arm', 'phone')
        playAnim('dad', 'phone', true) setProperty('dad.specialAnim', true)
    elseif curStep == 36 or curStep == 548 then
        callMethod('iconP2.changeIcon', {'hallow'})
        setProperty('healthBar.leftBar.color', getColorFromHex('E4E7FC'))
    elseif curStep == 288 then
        setProperty('health', 1)
        doTweenColor('hellopaste', 'sky', 'FF0000', 0.8)
        callMethod('iconP2.changeIcon', {'toothpaste'})
        setProperty('healthBar.leftBar.color', getColorFromHex('93F1EB'))
    elseif curStep == 350 then
        dadSing = true
     elseif curStep == 547 then
         dadSing = false armSing = true
     elseif curStep == 801 then
         callMethod('iconP2.changeIcon', {'rolldog'})
         armSing = false

         doTweenColor('norm', 'sky', 'FFFFFF', 0.8)
         setProperty('healthBar.leftBar.color', getColorFromHex('AEA28E'))
         playAnim('boyfriend', 'phone', true, true)
         playAnim('arm', 'phone', true, true)
         setProperty('wheel.visible', false)
    end
end

function goodNoteHit(id,noteData)
    if curStep >= 352 and curStep < 547 then
        playAnim('dad', getProperty('singAnimations')[noteData+1]..'-craze', true)
        setProperty('dad.holdTimer', 0)
    end
end

function onUpdate()
    if getProperty('arm.animation.curAnim.name') == 'phone' and getProperty('arm.animation.curAnim.finished') then
        setProperty('wheel.visible', true)
    end

    if curStep >= 801 then
        if getProperty('arm.animation.name') == 'phone' and getProperty('arm.animation.curAnim.curFrame') == 0 then
            setProperty('wheel.visible', false)
            playAnim('arm', 'wheel', true)
        end
    end

    if curStep >= 351 and curStep < 547 then
        for i = 0, getProperty('notes.length')-1 do
            if getPropertyFromGroup('notes', i, 'mustPress') then
                setPropertyFromGroup('notes', i, 'noAnimation', true)
            end
        end
    end
end

function opponentNoteHit()
    if (getProperty('health') - 0.025) > 0.02 then
        setProperty('health', getProperty('health') - 0.025)
    end
end