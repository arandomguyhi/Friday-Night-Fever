luaDebugMode = true

function onCreate()
    makeLuaSprite('sky', 'roboStage/sky', -660, -70)
    setProperty('sky.antialiasing', true)
    scaleObject('sky', 0.8, 0.8, false)
    addLuaSprite('sky')

    makeAnimatedLuaSprite('buildings', 'rolldog/roll_dog_buildings', -350, -57)
    addAnimationByPrefix('buildings', 'loop', 'buildings', 24, true)
    playAnim('buildings', 'loop')
    setProperty('buildings.antialiasing', true)
    addLuaSprite('buildings')

    makeLuaSprite('bg', 'rolldog/dog bg', -252, -117)
    setProperty('bg.antialiasing', true)
    addLuaSprite('bg')

    makeLuaSprite('seats', 'rolldog/bg chairs')
    setProperty('seats.antialiasing', true)
    addLuaSprite('seats')

    createInstance('arm', 'objects.Character', {590, 270, 'fevers-fucking-arm', false})
    addInstance('arm')

    makeAnimatedLuaSprite('wheel', 'rolldog/wheel crazy', 815, 335)
    addAnimationByPrefix('wheel', 'loop', 'wheel', 24, true)
    playAnim('wheel', 'loop')
    setProperty('wheel.antialiasing', true)
    setProperty('wheel.visible', false)
    addLuaSprite('wheel')

    setVar('forceComboPos', {x = screenWidth * 0.15, y = 140})
end

function onCreatePost()
    setProperty('dad.y', 320)
    callMethod('boyfriend.setPosition', {660, -85})
    setObjectOrder('gfGroup', getObjectOrder('seats'))
    setProperty('gf.x', 440)
    setProperty('gf.y', getProperty('gf.y') + 10)

    setProperty('isCameraOnForcedPos', true)
    callMethod('camFollow.setPosition', {getMidpointX('gf') + 25, getMidpointY('gf')})
    setObjectOrder('boyfriendGroup', getObjectOrder('arm'))
    playAnim('arm', 'wheel')

    makeAnimatedLuaSprite('bubble', 'rolldog/bubble', 350, -51)
    addAnimationByPrefix('bubble', 'appear', 'bubble pop up', 33, false)
    addAnimationByPrefix('bubble', 'idle', 'bubble0', 24, true)
    addAnimationByPrefix('bubble', 'disappear', 'bubble pop out', 24, false)
    playAnim('bubble', 'idle')
    setProperty('bubble.antialiasing', true)
    setProperty('bubble.visible', false)
    addLuaSprite('bubble', true)
end

function opponentNoteHit(id,noteData,noteType)
    if noteType == 'Arm' then
        playAnim('arm', getProperty('singAnimations')[noteData+1], true)
        setProperty('arm.holdTimer', 0)
    end
end

function onBeatHit()
    if getProperty('arm.animation.curAnim.name') ~= 'wheel' and getProperty('arm.animation.finished') then
        callMethod('arm.dance', {''})
    end
end

function onUpdate(elapsed)
    if getProperty('arm.animation.curAnim.name') == 'idle' and getProperty('boyfriend.animation.curAnim.name') == 'idle' then
        if getProperty('arm.animation.curAnim.curFrame') ~= getProperty('boyfriend.animation.curAnim.curFrame') then
            setProperty('arm.animation.curAnim.curFrame', getProperty('boyfriend.animation.curAnim.curFrame'))
        end
    end

    if getProperty('bubble.animation.curAnim.name') == 'appear' and getProperty('bubble.animation.curAnim.finished') then
        playAnim('bubble', 'idle')
        if luaSpriteExists('bubbleIcon') then
            setProperty('bubbleIcon.visible', true)
        end

        runTimer('noIcon', 1.1) onTimerCompleted = function(tag)
            if tag == 'noIcon' then
                playAnim('bubble', 'disappear')
                setProperty('bubbleIcon.visible', false)
                removeLuaSprite('bubbleIcon')
           end
       end
    end

    if getProperty('bubble.animation.curAnim.name') == 'disappear' and getProperty('bubble.animation.curAnim.finished') then
        setProperty('bubble.visible', false)
    end

    for i = 0, getProperty('notes.length')-1 do
        if getPropertyFromGroup('notes', i, 'noteType') == 'Arm' then
            setPropertyFromGroup('notes', i, 'noAnimation', true)
        end
    end
end

function showBubble(icon)
    setProperty('bubble.visible', true)
    playAnim('bubble', 'appear')

    makeAnimatedLuaSprite('bubbleIcon', 'rolldog/icons/'..icon, getProperty('bubble.x')+(getProperty('bubble.width')/2), getProperty('bubble.y')+((getProperty('bubble.height')-90)/2))
    addAnimationByPrefix('bubbleIcon', 'idle', icon, 24, true)
    playAnim('bubbleIcon', 'idle')
    setProperty('bubbleIcon.antialiasing', true)
    setProperty('bubbleIcon.visible', false)
    setProperty('bubbleIcon.x', getProperty('bubbleIcon.x') - (getProperty('bubbleIcon.width') / 2))
    setProperty('bubbleIcon.y', getProperty('bubbleIcon.y') - (getProperty('bubbleIcon.height') / 2))
    if icon == 'mega' or icon == 'flippy' then
        setProperty('bubbleIcon.antialiasing', false)
        scaleObject('bubbleIcon', 4.9, 4.9, false)
    end
    addLuaSprite('bubbleIcon', true)
end