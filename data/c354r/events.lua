luaDebugMode = true

local blackBars = {}

function onCreate()
    setVar('forceComboPos', {x = screenWidth * (downScroll and 0.78 or 0.05), y = 30})

    makeAnimatedLuaSprite('rback', 'roboStage/C354R/back', -625, 130)
    addAnimationByPrefix('rback', 'bop', 'bg', 24, false)
    playAnim('rback', 'bop')
    setProperty('rback.origin.x', 0) setProperty('rback.origin.y', 0)
    scaleObject('rback', 2.45, 2.45, false)
    setProperty('rback.antialiasing', true)
    addLuaSprite('rback') setObjectOrder('rback', getObjectOrder('mainBG') + 3)
    setProperty('rback.alpha', 0.00009)

    makeAnimatedLuaSprite('rfront', 'roboStage/C354R/front', -1125, 680)
    addAnimationByPrefix('rfront', 'bop', 'bg', 24, false)
    playAnim('rfront', 'bop')
    setProperty('rfront.origin.x', 0) setProperty('rfront.origin.y', 0)
    scaleObject('rfront', 2.1, 2.1, false)
    setProperty('rfront.antialiasing', true)
    addLuaSprite('rfront')
    setProperty('rfront.alpha', 0.00009)

    makeLuaSprite('splitBG1', 'roboStage/C354R/split1', -750, -120)
    setProperty('splitBG1.antialiasing', true)
    scaleObject('splitBG1', 1.62, 1.62, false)
    addLuaSprite('splitBG1', true)
    setProperty('splitBG1.visible', false)

    makeLuaSprite('splitBG2', 'roboStage/C354R/split2', -750, -120)
    setProperty('splitBG2.antialiasing', true)
    scaleObject('splitBG2', 1.62, 1.62, false)
    addLuaSprite('splitBG2', true)
    setProperty('splitBG2.visible', false)

    makeLuaSprite('bgF', 'roboStage/C354R/perspectiveF', -750, -120)
    setProperty('bgF.antialiasing', true)
    scaleObject('bgF', 1.25, 1.25, false)
    addLuaSprite('bgF', true)
    setProperty('bgF.visible', false)

    createInstance('charF', 'objects.Character', {0, 0, 'bf-perspective', true})
    addInstance('charF', true)
    setProperty('charF.visible', false)

    makeLuaSprite('bgR', 'roboStage/C354R/perspectiveR', -750, -150)
    setProperty('bgR.antialiasing', true)
    scaleObject('bgR', 1.62, 1.62, false)
    addLuaSprite('bgR', true)
    setProperty('bgR.visible', false)

    createInstance('charR', 'objects.Character', {-300, -250, 'robo-fever-perspective', false})
    addInstance('charR', true)
    setProperty('charR.visible', false)

    makeLuaSprite('bgRCar', 'roboStage/C354R/perspectiveRCar', -750, -150)
    setProperty('bgRCar.antialiasing', true)
    scaleObject('bgRCar', 1.62, 1.62, false)
    addLuaSprite('bgRCar', true)
    setProperty('bgRCar.visible', false)

    for i = 0, 1 do
        makeLuaSprite('b'..i, nil, 0, i == 1 and screenHeight - 150 or 0)
        makeGraphic('b'..i, screenWidth, 150, '000000')
        setProperty('b'..i..'.visible', false)
        setProperty('b'..'.ID', i)
        table.insert(blackBars, 'b'..i)
        addLuaSprite('b'..i) setObjectCamera('b'..i, 'camHUD')
    end

    for _,i in pairs({'charR', 'charF', 'bgR', 'bgF'}) do
        setProperty(i..'.color', 0xc681c6)
    end
end

function onBeatHit()
    playAnim('rfront', 'bop')
    playAnim('rback', 'bop')
    if curBeat >= 32 and curBeat < 64 and curBeat % 2 == 0 or curBeat >= 384 and curBeat < 448 then
        setProperty('camGame.zoom', getProperty('camGame.zoom') + 0.02)
        startTween('bopCamG', 'camGame', {zoom = 0.6}, 0.2, {})
    end

    if curBeat == 32 or curBeat == 48 then
        setProperty('isCameraOnForcedPos', true)
        setProperty('camFollow.x', getProperty('bgR.x') + (getProperty('bgR.width') / 2))
        setProperty('camFollow.y', getProperty('bgR.y') + (getProperty('bgR.height') / 2) - 100)
        callMethod('camGame.snapToTarget', {''})

        if curBeat == 32 then
            cameraFlash('camGame', 'ffffff', 0.45)
            setProperty('camGame.scroll.y', getProperty('camGame.scroll.y') + 80)
            startTween('yScroll', 'camGame.scroll', {y = getProperty('camGame.scroll.y') - 80}, 0.8, {ease = 'quartInOut'})
        end

        for _, i in pairs(blackBars) do
            setProperty(i..'.visible', true) end

        setProperty('defaultCamZoom', 0.6)
        setProperty('camGame.zoom', 0.6)
        setProperty('bgRCar.visible', true) setProperty('charR.visible', true) setProperty('bgR.visible', true)
    elseif curBeat == 40 or curBeat == 56 then
        setProperty('camFollow.x', getProperty('bgF.x') + (getProperty('bgF.width') / 2))
        setProperty('camFollow.y', getProperty('bgF.y') + (getProperty('bgF.height') / 2) - 100)
        callMethod('camGame.snapToTarget', {''})
        if curBeat == 40 then
            setProperty('camGame.scroll.x', getProperty('camGame.scroll.x') - 40)
            startTween('xScroll', 'camGame.scroll', {x = getProperty('camGame.scroll.x') + 40}, 0.8, {ease = 'quartInOut'})
        end

        setProperty('bgRCar.visible', false) setProperty('charR.visible', false) setProperty('bgR.visible', false)
        setProperty('bgF.visible', true) setProperty('charF.visible', true)
    elseif curBeat == 64 then
        for _, i in pairs(blackBars) do
            setProperty(i..'.visible', false) end

        setProperty('defaultCamZoom', 0.36)
        cameraFlash('camGame', 'ffffff', 0.45)
        setProperty('bgF.visible', false) setProperty('charF.visible', false)
        setProperty('isCameraOnForcedPos', false)
        cameraSetTarget('dad') callMethod('camGame.snapToTarget', {''})
    elseif curBeat == 384 then
        for _, i in pairs(blackBars) do
            setProperty(i..'.visible', true) end

        cameraFlash('camGame', 'ffffff', 0.45)
        setProperty('isCameraOnForcedPos', true)

        setProperty('camFollow.x', getProperty('bgR.x') + (getProperty('bgR.width') / 2))
        setProperty('camFollow.y', getProperty('bgR.y') + (getProperty('bgR.height') / 2) - 100)
        callMethod('camGame.snapToTarget', {''})

        setProperty('bgRCar.visible', true) setProperty('splitBG1.visible', true)
        setProperty('splitBG2.visible', true)
        setProperty('defaultCamZoom', 0.6)
        setProperty('camGame.zoom', 0.6)
        setProperty('charF.visible', true) setProperty('charR.visible', true)
        callMethod('charR.setPosition', {getProperty('splitBG1.x') + 125, getProperty('splitBG1.y') - 50})
        callMethod('charF.setPosition', {getProperty('splitBG1.x') + 991, getProperty('splitBG1.y') + 55})

        setProperty('camGame.scroll.y', getProperty('camGame.scroll.y') + 80)
        startTween('yScroll', 'camGame.scroll', {y = getProperty('camGame.scroll.y') - 80}, 0.8, {ease = 'quartInOut'})
        setObjectOrder('bgRCar', getObjectOrder('splitBG1') + 1)

        setObjectOrder('charR', getObjectOrder('splitBG1') + 1)
    elseif curBeat == 448 then
        for _, i in pairs(blackBars) do
            setProperty(i..'.visible', false) end

        cameraFlash('camGame', 'ffffff', 0.45)
        setProperty('isCameraOnForcedPos', false)
        setProperty('charF.visible', false) setProperty('charR.visible', false)
        setProperty('splitBG1.visible', false) setProperty('splitBG2.visible', false) setProperty('bgRCar.visible', false)
        cameraSetTarget('dad') callMethod('camGame.snapToTarget', {''})
        setProperty('rfront.alpha', 1)
        setProperty('rback.alpha', 1)
        setProperty('defaultCamZoom', 0.36)
    end
end

function goodNoteHit(id,noteData)
    playAnim('charF', getProperty('singAnimations')[noteData+1])
    setProperty('charF.holdTimer', 0)
end

function opponentNoteHit(id,noteData)
    playAnim('charR', getProperty('singAnimations')[noteData+1])
    setProperty('charR.holdTimer', 0)
end