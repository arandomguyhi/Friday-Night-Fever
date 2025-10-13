luaDebugMode = true

addHaxeLibrary('FlxFlicker', 'flixel.effects')

local zombFlicker = false
local adsGrp = {}

-- STREETLIGHT / CAR STUFF
local cars = {}
local randomWait = 0
local elapsedTimer = 0
local streetlightTimer = 0
local streetlightMaxTime = 8

local function image(img)
    return 'roboStage/C354R/'..img
end
local function centerSpriteX(sprite1, sprite2)
    return getProperty(sprite1..'.x') + (getProperty(sprite1..'.width') / 2) - (getProperty(sprite2..'.width') / 2)
end
local function centerSpriteY(sprite1, sprite2)
    return getProperty(sprite1..'.y') + (getProperty(sprite1..'.height') / 2) - (getProperty(sprite2..'.height') / 2)
end

function onCreate()
    makeLuaSprite('sky', image('sky'), -1450, -900)
    setProperty('sky.antialiasing', true)
    addLuaSprite('sky')

    makeAnimatedLuaSprite('makolicious', image('mako'), 460, -640)
    addAnimationByIndices('makolicious', 'frozen', 'mako jump', '0', 0)
    addAnimationByPrefix('makolicious', 'MAKO', 'mako jump', 24, false)
    addAnimationByPrefix('makolicious', 'weewoo', 'mako REEROO', 24, true)
    playAnim('makolicious', 'frozen')
    setProperty('makolicious.antialiasing', true)

    makeAnimatedLuaSprite('tower', image('peakek'), -1350, -650)
    addAnimationByPrefix('tower', 'normal', 'building0', 24, true)
    playAnim('tower', 'normal')
    setProperty('tower.antialiasing', true)
    addLuaSprite('tower')
    addLuaSprite('makolicious')

    makeAnimatedLuaSprite('robos', image('robots'), -1350, -510)
    addAnimationByPrefix('robos', 'loop', 'robot', 24, true)
    playAnim('robos', 'loop')
    setProperty('robos.antialiasing', true)
    setProperty('robos.visible', false)
    addLuaSprite('robos')

    createAd("hallow_ad", 21, 120, 1.25, "hallow ad", false);
    createAd("milk_ad", 581, 120, 1.22, "straw ad", false);
    createAd("roll_ad", 1081, 120, 1.22, "roll ad", true);
    createAd("Shino_ad", 2534, 419, 1.22, "shino", false);
    createAd("RaeCody_ad", 2537, 106, 1.22, "soulsplit", false);
    -- tacky tacky tacky but dont make her unhappy
    createAd("taki_ad", 3518, 106, 1.22, "tacky tacky tacky sweet like laff", false);
    -- don't question it

    makeLuaSprite('mainBG', image('back_bg'), getProperty('sky.x'), getProperty('sky.y'))
    setProperty('mainBG.antialiasing', true)
    addLuaSprite('mainBG')

    makeLuaSprite('lights', image('building_lights'), getProperty('sky.x'), getProperty('sky.y'))
    setProperty('lights.antialiasing', true)
    addLuaSprite('lights')

    makeLuaSprite('debra', image('debris_bg'), getProperty('sky.x'), getProperty('sky.y'))
    setProperty('debra.antialiasing', true)
    addLuaSprite('debra')

    makeAnimatedLuaSprite('zombie', image('zog'))
    addAnimationByPrefix('zombie', 'zog', 'zogs0', 24, true)
    addAnimationByPrefix('zombie', 'EXPLODE', 'zogs explod0', 24, false)
    playAnim('zombie', 'zog')
    setProperty('zombie.antialiasing', true)
    addLuaSprite('zombie')

    setProperty('zombie.x', centerSpriteX('mainBG', 'zombie') - 850)
    setProperty('zombie.y', centerSpriteY('mainBG', 'zombie'))

    setProperty('tower.x', 525.5)
    setProperty('robos.x', getProperty('tower.x') - 250)

    makeAnimatedLuaSprite('truck', image('foodtruck'))
    addAnimationByPrefix('truck', 'bop', 'food truck', 24, false)
    playAnim('truck', 'bop')
    setProperty('truck.antialiasing', true)
    addLuaSprite('truck')

    setProperty('truck.x', centerSpriteX('mainBG', 'truck') + 1700)
    setProperty('truck.y', centerSpriteY('mainBG', 'truck') + 120)

    makeAnimatedLuaSprite('broken', 'roboStage/C354R/light', -920, 765)
    addAnimationByPrefix('broken', 'idle', 'light broken', 24, true)
    playAnim('broken', 'idle')
    setProperty('broken.antialiasing', true)

    makeAnimatedLuaSprite('streetlight', image('streetlight'), 1350, -760)
    addAnimationByPrefix('streetlight', 'stop', 'street light stop', 24, true)
    addAnimationByPrefix('streetlight', 'go', 'street light go', 24, true)
    playAnim('streetlight', 'stop')
    setProperty('streetlight.antialiasing', true)
    addLuaSprite('streetlight')

    makeLuaSprite('frontBG', image('front_stuff'), getProperty('sky.x'), getProperty('sky.y'))
    setProperty('frontBG.antialiasing', true)
    addLuaSprite('frontBG')
    addLuaSprite('broken')

    makeLuaSprite('glow1', image('glow'), getProperty('sky.x'), getProperty('sky.y'))
    setProperty('glow1.antialiasing', true)
    addLuaSprite('glow1')

    makeLuaSprite('glow2', image('top_glow'), getProperty('sky.x'), getProperty('sky.y'))
    setProperty('glow2.antialiasing', true)
    addLuaSprite('glow2')

    for _, i in pairs({'boyfriend', 'dad', 'gf', 'zombie', 'broken', 'truck'}) do
        setProperty(i..'.color', 0xc681c6)
    end
end

function onCreatePost()
    setProperty('gf.x', getProperty('gf.x') - 120)
    setScrollFactor('gf', 1, 1)

    setProperty('dad.y', getProperty('dad.y') - 365)
    setProperty('dad.x', getProperty('dad.x') + 200)
    setScrollFactor('dad', 1, 1)

    setObjectOrder('gfGroup', getObjectOrder('frontBG'))
    setObjectOrder('boyfriendGroup', getObjectOrder('frontBG'))
end

local cringeCars = {}
function onUpdate(elapsed)
    if not getProperty('robos.visible') and getProperty('makolicious.animation.curAnim.name') == 'weewoo' then
        setProperty('robos.visible', true)
        playAnim('robos', 'loop', true)
    end

    if not zombFlicker and getProperty('zombie.animation.curAnim.name') == 'EXPLODE' and getProperty('zombie.animation.curAnim.curFrame') > 22 then
        zombFlicker = true
        runHaxeCode("FlxFlicker.flicker(game.getLuaObject('zombie'), 0.5, 0.06, false, false);")
    end

    if getProperty('streetlight.animation.curAnim.name') == 'go' then
        streetlightTimer = streetlightTimer + elapsed

        if streetlightTimer >= streetlightMaxTime and #cars < 1 then
            streetlightTimer = 0

            playAnim('streetlight', 'stop')
            runHaxeCode("game.getLuaObject('streetlight').centerOffsets();")
            setProperty('streetlight.offset.x', 0)
        end

        if streetlightTimer ~= 0 and streetlightTimer < streetlightMaxTime and curBeat < 281 then
            if elapsedTimer >= randomWait then
                elapsedTimer = 0
                randomWait = getRandomFloat(0.4, 0.95)
                spawnCar()
            else
                elapsedTimer = elapsedTimer + elapsed
            end
        end
    end

    for _, car in pairs(cars) do
        if getProperty(car..'.x') > getProperty('gf.x') - 150 and getProperty(car..'.ID') == 0 then
            setProperty(car..'.ID', 1)
            playAnim('gf', 'hairBlow', true)
        end

        if getProperty(car..'.ID') == 1 and getProperty(car..'.x') + getProperty(car..'.width') > getProperty('mainBG.x') + getProperty('mainBG.width') then
            removeLuaSprite(car, true)
            table.insert(cringeCars, car)
        end
    end

    for _, i in pairs(cringeCars) do
        table.remove(cars,_)
    end

    if getProperty('gf.animation.curAnim.name') == 'hairBlow' and getProperty('gf.animation.curAnim.finished') then
        playAnim('gf', 'hairFall', true)
    end
end

local car = 0
function spawnCar()
    local carNum = getRandomInt(1,3)
    makeLuaSprite('car'..car, image('car_'..carNum), -8550, getProperty('boyfriend.y') - 125 + (carNum == 3 and -85 or 0))
    setProperty('car'..car..'.velocity.x', (getRandomInt(170, 220) / getPropertyFromClass('flixel.FlxG', 'elapsed')) * 3)
    scaleObject('car'..car, 1.3, 1.3, false)
    setProperty('car'..car..'.ID', 0)
    addLuaSprite('car'..car) setObjectOrder('car'..car, getObjectOrder('truck')+1)
    table.insert(cars, 'car'..car)

    playSound('carPass'..getRandomInt(0,1), 0.4)
    car = car + 1 
end

function onBeatHit()
    playAnim('truck', 'bop', true)

    for _,i in pairs(adsGrp) do
        if getProperty(i..'.ID') == 1 then
            playAnim(i, 'animation')
        end
    end

    if getProperty('streetlight.animation.curAnim.name') == 'stop' then
        if curBeat % 12 == 0 and getRandomBool(20) then
            playAnim('streetlight', 'go')
            runHaxeCode("game.getLuaObject('streetlight').centerOffsets();")
            setProperty('streetlight.offset.x', getProperty('streetlight.offset.x') + 90)
            streetlightMaxTime = getRandomInt(6, 9)
        end
    end

    if curBeat == 281 then
        playAnim('makolicious', 'MAKO')
        setProperty('makolicious.offset.x', 606) setProperty('makolicious.offset.y', 163)
        setProperty('isCameraOnForcedPos', true)
        setProperty('camZooming', true)
        callMethod('camFollow.setPosition', {getProperty('tower.x') + (getProperty('tower.width') / 2), getProperty('tower.y') + (getProperty('tower.height') / 2) - 50})
        setProperty('defaultCamZoom', 0.65)
    elseif curBeat == 287 then
        doTweenAlpha('wowMako', 'camHUD', 0.2, 0.7)
    elseif curBeat == 302 then
        setProperty('defaultCamZoom', 0.41)
        setProperty('isCameraOnForcedPos', false)
        cameraSetTarget('dad')
        doTweenAlpha('wowMako1', 'camHUD', 1, 0.3)
    end

    if getProperty('makolicious.animation.curAnim.name') == 'MAKO' and getProperty('makolicious.animation.finished') or getProperty('makolicious.animation.curAnim.name') == 'weewoo' then
        if curBeat % 2 == 0 then
            playAnim('makolicious', 'weewoo')
            runHaxeCode("game.getLuaObject('makolicious').centerOffsets();")
            setProperty('makolicious.offset.x', getProperty('makolicious.offset.x') + 58)
        end
    end
end

function onStepHit()
    if curStep == 1851 then
        for _, char in pairs({'dad', 'gf', 'boyfriend'}) do
            playAnim(char, char == 'gf' and 'cheer' or 'hey', true)
            setProperty(char..'.specialAnim', true)
        end
    end
end

local ads = 0
function createAd(img, x, y, scale, anim, bop)
    makeAnimatedLuaSprite('ad'..ads, image(img), getProperty('sky.x') + x, getProperty('sky.y') + y)
    addAnimationByPrefix('ad'..ads, 'animation', anim, 24, not bop)
    setProperty('ad'..ads..'.ID', bop and 1 or 0)
    playAnim('ad'..ads, 'animation')
    setProperty('ad'..ads..'.origin.x', 0) setProperty('ad'..ads..'.origin.y', 0)
    scaleObject('ad'..ads, scale, scale, false)
    setProperty('ad'..ads..'.antialiasing', true)
    addLuaSprite('ad'..ads)
    table.insert(adsGrp, 'ad'..ads)

    ads = ads + 1
end