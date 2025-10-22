luaDebugMode = true

local inTunnel = false

function onCreate()
    makeLuaSprite('sky', 'roboStage/sky', 0, -1000)
    setProperty('sky.antialiasing', true)
    setScrollFactor('sky', 0.9, 0.9)
    scaleObject('sky', 1.75, 1.75)
    addLuaSprite('sky')

    createInstance('buildings1', 'flixel.addons.display.FlxBackdrop', {nil, 0x01})
    loadGraphic('buildings1', 'roboStage/gears/furthestBuildings')
    setProperty('buildings1.antialiasing', true)
    setScrollFactor('buildings1', 0.9, 0.9)
    setProperty('buildings1.origin.x', 0) setProperty('buildings1.origin.y', 0)
    scaleObject('buildings1', 1.75, 1.75)
    setProperty('buildings1.y', getProperty('buildings1.y') - 150)
    setProperty('buildings1.x', getProperty('buildings1.x') - 600)
    addInstance('buildings1')

    createInstance('buildings2', 'flixel.addons.display.FlxBackdrop', {nil, 0x01})
    loadGraphic('buildings2', 'roboStage/gears/middleBuildings')
    setProperty('buildings2.antialiasing', true)
    setScrollFactor('buildings2', 0.9, 0.9)
    setProperty('buildings2.origin.x', 0) setProperty('buildings2.origin.y', 0)
    scaleObject('buildings2', 1.75, 1.75)
    setProperty('buildings2.y', getProperty('buildings2.y') - 350)
    setProperty('buildings2.x', getProperty('buildings2.x') - 600)
    addInstance('buildings2')

    createInstance('buildings3', 'flixel.addons.display.FlxBackdrop', {nil, 0x01})
    loadGraphic('buildings3', 'roboStage/gears/frontBuildings')
    setProperty('buildings3.antialiasing', true)
    setScrollFactor('buildings3', 0.9, 0.9)
    setProperty('buildings3.origin.x', 0) setProperty('buildings3.origin.y', 0)
    scaleObject('buildings3', 1.75, 1.75)
    setProperty('buildings3.y', getProperty('buildings3.y') - 750)
    setProperty('buildings3.x', getProperty('buildings3.x') - 600)
    addInstance('buildings3')

    makeLuaSprite('fakeBuilding', nil, 0, getProperty('buildings3.y') + getProperty('buildings3.height') - 5)
    makeGraphic('fakeBuilding', 60, 60, '2E125D')
    setProperty('fakeBuilding.origin.x', 0) setProperty('fakeBuilding.origin.y', 0)
    scaleObject('fakeBuilding', 100, 100, false)
    addLuaSprite('fakeBuilding')

    createInstance('tunnelBG', 'flixel.addons.display.FlxBackdrop', {nil, 0x01})
    loadGraphic('tunnelBG', 'roboStage/gears/tunnel')
    setProperty('tunnelBG.antialiasing', true)
    setProperty('tunnelBG.y', getProperty('tunnelBG.y') - 950)
    scaleObject('tunnelBG', 1.15, 1.15, false)
    setProperty('tunnelBG.color', 0xA672B2)
    addInstance('tunnelBG')
    setProperty('tunnelBG.visible', false)

    createInstance('lights', 'flixel.addons.display.FlxBackdrop', {nil, 0x01})
    loadGraphic('lights', 'roboStage/gears/lights')
    setProperty('lights.antialiasing', true)
    setProperty('lights.y', getProperty('lights.y') - 700)
    scaleObject('lights', 1.6, 1.6, false)
    addInstance('lights')
    setProperty('lights.visible', false)

    makeAnimatedLuaSprite('train', 'roboStage/train', 0, 666)
    addAnimationByPrefix('train', 'drive', 'all train', 24, false)
    playAnim('train', 'drive')
    setProperty('train.antialiasing', true)
    setScrollFactor('train', 0.9, 0.9)
    scaleObject('train', 1.75, 1.75)
    addLuaSprite('train')

    makeAnimatedLuaSprite('trainDeath', 'roboStage/gears/death', -7, 453)
    addAnimationByPrefix('trainDeath', 'death', 'Train be like', 24, false)
    setProperty('trainDeath.antialiasing', true)
    setScrollFactor('trainDeath', 0.9, 0.9)
    scaleObject('trainDeath', 1.75, 1.75)
    setProperty('trainDeath.visible', false)
    addLuaSprite('trainDeath')

    makeLuaSprite('poles', 'roboStage/gears/poles', 2900, 600)
    setProperty('poles.antialiasing', true)
    setProperty('poles.velocity.x', (getRandomInt(120, 170) / getPropertyFromClass('flixel.FlxG', 'elapsed')) * -0.95)
    addLuaSprite('poles')

    makeAnimatedLuaSprite('trainGlow', 'roboStage/trainGlow', -60, 600)
    addAnimationByPrefix('trainGlow', 'drive', 'all train', 24, false)
    playAnim('trainGlow', 'drive')
    setProperty('trainGlow.antialiasing', true)
    setScrollFactor('trainGlow', 0.9, 0.9)
    scaleObject('trainGlow', 1.75, 1.75)
    setProperty('trainGlow.visible', false)
    addLuaSprite('trainGlow')

    makeAnimatedLuaSprite('bomb', 'roboStage/gears/regular_bomb', 2350, 103.442)
    setScrollFactor('bomb', 0.9, 0.9)
    addAnimationByPrefix('bomb', 'idle', 'Mako Bomb Normal', 24)
    playAnim('bomb', 'idle')
    setProperty('bomb.antialiasing', true)
    scaleObject('bomb', 1.5, 1.5, false)
    addLuaSprite('bomb')

    makeLuaSprite('fakeTunnelBG', 'roboStage/gears/tunnel', 0, -50)
    setProperty('fakeTunnelBG.antialiasing', true)
    setProperty('fakeTunnelBG.x', screenWidth)
    setProperty('fakeTunnelBG.color', 0x565656)
    addLuaSprite('fakeTunnelBG') setObjectCamera('fakeTunnelBG', 'camHUD')

    makeLuaSprite('tunnelEnterance', 'roboStage/gears/tunnelEnterance', 0, -50)
    setProperty('tunnelEnterance.antialiasing', true)
    setProperty('tunnelEnterance.x', screenWidth)
    addLuaSprite('tunnelEnterance') setObjectCamera('tunnelEnterance', 'camHUD')
end

function onCreatePost()
    makeLuaSprite('outerBuilding', 'roboStage/gears/randomBuilding', 32900, 1700)
    setProperty('outerBuilding.antialiasing', true)
    addLuaSprite('outerBuilding', true)
    setProperty('outerBuilding.visible', false)
end

local p_elapsedT = 0
local p_randT = getRandomFloat(2, 7)

function enterTunnel()
    startTween('entTween', 'tunnelEnterance', {x = 0}, 0.3, {})
    startTween('fentTween', 'fakeTunnelBG', {x = 0}, 0.3, {onComplete = 'tun'})
    tun = function()
        inTunnel = true
        setProperty('tunnelEnterance.visible', false)
        setProperty('fakeTunnelBG.visible', false)
        setProperty('tunnelBG.visible', true)
        setProperty('lights.visible', true)
        setProperty('poles.visible', false)
        setProperty('trainGlow.visible', true)
        cameraFlash('camGame', '000000', 1.3)
    end
end

function exitTunnel()
    setProperty('tunnelEnterance.visible', true)
    setProperty('trainGlow.visible', false)
    setProperty('train.visible', true)

    setProperty('fakeTunnelBG.visible', true)
    setProperty('tunnelBG.visible', false)
    setProperty('lights.visible', false)
    inTunnel = false
    setProperty('tunnelEnterance.x', screenWidth - getProperty('tunnelEnterance.width'))
    setProperty('fakeTunnelBG.x', (screenWidth - getProperty('tunnelEnterance.width')) - getProperty('fakeTunnelBG.width') + 3)

    startTween('outTunnel', 'tunnelEnterance', {x = -getProperty('tunnelEnterance.width')}, 0.5, {onUpdate = 'fakeX', onComplete = 'noTun'})
    fakeX = function()
        setProperty('fakeTunnelBG.x', getProperty('tunnelEnterance.x') - getProperty('fakeTunnelBG.width'))
    end
    noTun = function()
        setProperty('fakeTunnelBG.visible', false)
        setProperty('tunnelEnterance.visible', false)
        setProperty('poles.visible', true)
    end
end

function onUpdate(elapsed)
    local currentBeat = (getSongPosition()/1000) * (curBpm/60)
    setProperty('bomb.y', -50 + (5 * math.sin(currentBeat * math.pi)))

    if keyboardJustPressed('V') and not inTunnel then
        enterTunnel()
    elseif keyboardJustPressed('V') then
        exitTunnel()
    end

    if not inTunnel then
        setProperty('buildings3.x', getProperty('buildings3.x') - elapsed * 1950)
        setProperty('buildings2.x', getProperty('buildings2.x') - elapsed * 1020)
        setProperty('buildings1.x', getProperty('buildings1.x') - elapsed * 820)

        p_elapsedT = p_elapsedT + elapsed
        if getProperty('poles.x') < getProperty('sky.x') - 16000 and p_elapsedT >= p_randT then
            setProperty('poles.x', 2900 + getRandomInt(0, 1520))
            p_randT = getRandomFloat(2, 7)
            p_elapsedT = 0
        end
    else
        setProperty('tunnelBG.x', getProperty('tunnelBG.x') - elapsed * 2330)
        setProperty('lights.x', getProperty('lights.x') - elapsed * 2330)
    end
end

function onBeatHit()
    if inTunnel then
        playAnim('trainGlow', 'drive')
    else
        playAnim('train', 'drive')
    end

    if curBeat == 206 then
        setProperty('trainGlow.visible', true)
        setProperty('train.visible', false)
    end
end