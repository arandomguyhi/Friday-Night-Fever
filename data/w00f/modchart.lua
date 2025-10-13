luaDebugMode = true

local defaultStrumPos = {}
local hudAngle = 0

local curPlayer, curOpponent = 'boyfriend', 'dad'

setProperty('camZoomingMult', 0)
function onCreatePost()
    for i = 0, 7 do
        table.insert(defaultStrumPos, {
            x = getPropertyFromGroup('strumLineNotes', i, 'x'),
            y = getPropertyFromGroup('strumLineNotes', i, 'y')
        })
    end

    makeAnimatedLuaSprite('eat', 'characters/fever/fever_eat', 645, -110)
    addAnimationByPrefix('eat', 'eat', 'Fever eat', 24, false)
    setProperty('eat.antialiasing', true)
    addLuaSprite('eat') setObjectOrder('eat', getObjectOrder('boyfriendGroup'))
    setProperty('eat.visible', false)
end

function onBeatHit()
    if curBeat < 276 then
        if curBeat >= 8 and curBeat < 136 and curBeat % 2 == 0 then
            setProperty('camHUD.zoom', getProperty('camHUD.zoom') + ((curBeat % 4 == 0) and 0.015 or 0.005))
        end
    elseif curBeat >= 276 and curBeat < 340 then
        if curBeat % 2 == 0 then
            setProperty('camHUD.zoom', getProperty('camHUD.zoom') + ((curBeat % 4 == 0) and 0.018 or 0.009))
            hudAngle = ((curBeat % 4 == 0) and 0.65 or -0.65)
        end
    elseif curBeat >= 340 and curBeat < 404 then
        hudAngle = 0
        setProperty('camHUD.zoom', getProperty('camHUD.zoom') + 0.015)
    elseif curBeat >= 404 and curBeat < 468 then
        if curBeat % 3 == 0 then
            setProperty('camHUD.zoom', getProperty('camHUD.zoom') + 0.02)
        end
    end
end

function onStepHit()
    setProperty('camZooming', true)
    if curStep == 1 then
        callOnLuas('showBubble', {'robo-fever'})
    end

    if curStep == 1073 then
        callOnLuas('showBubble', {'scarlet'})
    end

    if curStep == 10 then
        playAnim('arm', 'phone')
        playAnim('dad', 'phone', true)
    end

    if curStep == 34 then
        callMethod('iconP2.changeIcon', {'robo-cesar'})
        setProperty('healthBar.leftBar.color', getColorFromHex('9236B4'))
    end

    if curStep == 546 or curStep == 548 or curStep == 605 or curStep == 607 or curStep == 610 or curStep == 612 or curStep == 669 or curStep == 671
    or curStep == 674 or curStep == 676 or curStep == 733 or curStep == 735 or curStep == 738 or curStep == 740 then
        setProperty('camGame.zoom', getProperty('camGame.zoom') + 0.02)
        setProperty('camHUD.zoom', getProperty('camHUD.zoom') + 0.016)

        for i = 0, 7 do
            local nextX = defaultStrumPos[i+1].x
            if curStep == 546 or curStep == 548 then
                nextX = nextX + ((i < 2 or (i < 6 and i > 3)) and ((i == 0 or i == 4) and -35 or -15) or ((i == 3 or i == 7) and 35 or 15))
            else
                nextX = nextX + ((i < 2 or (i < 6 and i > 3)) and ((i == 0 or i == 4) and -10 or -5) or ((i == 3 or i == 7) and 10 or 5))
            end
            startTween('woo'..i, 'strumLineNotes.members['..i..']', {x = nextX}, 0.1, {})
        end
    end

    if curStep == 1064 then
        setProperty('health', 1)
        callMethod('iconP2.changeIcon', {'rolldog'})
        setProperty('healthBar.leftBar.color', getColorFromHex('AEA28E'))
        playAnim('boyfriend', 'phone', true, true)
        playAnim('arm', 'phone', true, true)
        setProperty('wheel.visible', false)
    end

    if curStep == 1080 then
        playAnim('arm', 'phone', true)
        playAnim('boyfriend', 'phone', true) setProperty('boyfriend.specialAnim', true)
    end

    if curStep == 1106 then
        callMethod('iconP2.changeIcon', {'scarlet'})
        setProperty('healthBar.leftBar.color', getColorFromHex('E059B1'))
    end

    if curStep == 481 or curStep == 1425 then
        curPlayer = 'dad'
        callMethod('boyfriend.dance', {''})
        if curStep == 1425 then curOpponent = 'arm' end
    end

    if curStep == 545 or curStep == 1616 or curStep == 1881 then
        curOpponent = 'dad' curPlayer = 'boyfriend'

        if curStep == 1881 then
            setProperty('health', 1)
            callMethod('iconP2.changeIcon', {'rolldog'})
            setProperty('healthBar.leftBar.color', getColorFromHex('AEA28E'))

            playAnim('boyfriend', 'phone', true, true)
            playAnim('arm', 'phone', true, true)
            setProperty('wheel.visible', false)
        end
    end

    if curStep == 1619 or curStep == 1807 then
        curOpponent = 'arm'
        if curStep == 1807 then
            curPlayer = 'boyfriend'
        end
    end

    if curStep == 1743 then
        callMethod('boyfriend.dance', {''})
        curPlayer = 'dad'
    end

    if curStep == 2152 then
        setProperty('eat.visible', true)
        setProperty('boyfriend.visible', false)
        playAnim('eat', 'eat', true)
    end
end

function onUpdate(elapsed)
    if curStep >= 1064 and curStep < 1079 or curStep >= 1881 then
        if getProperty('arm.animation.name') == 'phone' and getProperty('arm.animation.curAnim.curFrame') == 0 then
            setProperty('wheel.visible', false)
            playAnim('arm', 'wheel', true)
        end
    end

    for i = 0, 7 do
        setNoteX(defaultStrumPos[i+1].x + (1 - (elapsed * 3.125)) * (getProperty('strumLineNotes.members['..i..'].x') - defaultStrumPos[i+1].x), i)
    end

    setProperty('camHUD.angle', callMethodFromClass('flixel.math.FlxMath', 'lerp', {hudAngle, getProperty('camHUD.angle'), callMethodFromClass('flixel.math.FlxMath', 'bound', {1 - (elapsed * 25.125), 0, 1})}))

    if getProperty('arm.animation.curAnim.name') == 'phone' and getProperty('arm.animation.curAnim.finished') then
        setProperty('wheel.visible', true)
    end
end

function onUpdatePost()
    for i = 0, getProperty('notes.length')-1 do
        if not getPropertyFromGroup('notes', i, 'mustPress') then
            setPropertyFromGroup('notes', i, 'noAnimation', curOpponent ~= 'dad')
        else
            setPropertyFromGroup('notes', i, 'noAnimation', curPlayer ~= 'boyfriend')
        end
    end
end

function goodNoteHit(id, noteData, noteType, isSustainNote)
    if curStep >= 416 and curStep <= 420 then
        setProperty('camGame.zoom', getProperty('camGame.zoom') + 0.02)
    end

    if curPlayer ~= 'boyfriend' then
        playAnim(curPlayer, getProperty('singAnimations')[noteData+1], true)
        setProperty(curPlayer..'.holdTimer', 0)
    end
end

function opponentNoteHit(id, noteData, noteType, isSustainNote)
    if curOpponent ~= 'dad' then
        playAnim(curOpponent, getProperty('singAnimations')[noteData+1], true)
        setProperty(curOpponent..'.holdTimer', 0)
    end
end

function setNoteX(x, num)
    setProperty('strumLineNotes.members['..num..'].x', x)
end