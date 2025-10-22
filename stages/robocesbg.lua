luaDebugMode = true

local stages = {}
local curStage = 'c354r-default'

local curPlayer, curOpponent = 'boyfriend', 'dad'

function onCreate()
    createInstance('roboBackground', 'flixel.group.FlxTypedGroup', {})
    createInstance('roboForeground', 'flixel.group.FlxTypedGroup', {})

    makeLuaSprite('bg', 'roboStage/ROBO_BG', -450, -355)
    setProperty('bg.antialiasing', true)
    scaleObject('bg', 1.85, 1.85, false)
    setScrollFactor('bg', 0.9, 0.85)

    makeLuaSprite('rail', 'roboStage/rail', -450 + 660, -355 + 413)
    setProperty('rail.antialiasing', true)
    setProperty('rail.origin.x', 0) setProperty('rail.origin.y', 0)
    scaleObject('rail', 1.85, 1.85, false)
    setScrollFactor('rail', 0.9, 0.85)

    makeLuaSprite('city', 'roboStage/ROBO_BG_CITY', -450, -355)
    setProperty('city.antialiasing', true)
    scaleObject('city', 1.85, 1.85, false)
    setScrollFactor('city', 0.85, 0.95)

    makeLuaSprite('sky', 'roboStage/ROBO_BG_SKY', -450, -355)
    setProperty('sky.antialiasing', true)
    scaleObject('sky', 1.85, 1.85, false)
    setScrollFactor('sky', 0.65, 0.95)

    makeLuaSprite('overlay', 'roboStage/ROBO_BG_OVERLAY', -450, -355)
    setProperty('overlay.antialiasing', true)
    scaleObject('overlay', 1.85, 1.85, false)
    setScrollFactor('overlay', 0.85, 0.85)

    makeLuaSprite('wires', 'roboStage/ROBO_BG_WIRES', -450, -355)
    setProperty('wires.antialiasing', true)
    scaleObject('wires', 1.85, 1.85, false)
    setScrollFactor('wires', 0.85, 0.85)

    stages['c354r-default'] = RoboStage.new({'sky', 'city', 'rail', 'bg', 'wires'}, {'overlay'},
    {boyfriend = {880, 482.3}, gf = {335, 149}, dad = {160, 315.3}}, {}, 0.4)

    if songName == 'Loaded' then
        createInstance('taki', 'objects.Character', {0, 0, 'gf-taki'})
        createInstance('robofever', 'objects.Character', {0, 0, 'robo-cesar-pixel'})
        createInstance('tea_pixel', 'objects.Character', {0, 0, 'tea-pixel'})
        createInstance('fever_pixel', 'objects.Character', {0, 0, 'bf-pixel', true})
        createInstance('cherry', 'objects.Character', {360, 70, 'gf-cherry', false})
        setScrollFactor('tea_pixel', 0.9, 0.9)
        setScrollFactor('fever_pixel', 0.9, 0.9)
        setScrollFactor('robofever', 0.9, 0.9)
        setScrollFactor('cherry', 0.95, 0.95)
        -- ZARDY STAGE
        local dumboffset = 95

        dumboffset = 365
        local offsetY = 200
        makeLuaSprite('zardybg', 'roboStage/zardy_bg', 164.4 - dumboffset, 0 - offsetY)
        setProperty('zardybg.antialiasing', true)
        setScrollFactor('zardybg', 0.75, 0.3)

        makeLuaSprite('zardytown', 'roboStage/zardy_fevertown', 140.65 - dumboffset, 1.1 - offsetY)
        setProperty('zardytown.antialiasing', true)
        setScrollFactor('zardytown', 0.6, 1)

        makeLuaSprite('zardyforeground', 'roboStage/zardy_foreground', 161.65 - dumboffset, 6.15 - offsetY)
        setProperty('zardyforeground.antialiasing', true)

        stages['zardy'] = RoboStage.new({'zardybg', 'zardytown', 'zardyforeground'}, {}, {
            boyfriend = {1366.3 - (dumboffset), 525.8 - offsetY},
            gf = {810.9 - (dumboffset * 1.275), 244.4 - offsetY},
            dad = {492.5 - (dumboffset * 1.765) + (150), 410.8 - offsetY - (50)}},
        {}, 0.715)
        
        -- WHITTY STAGE
        makeLuaSprite('whittyBG', 'roboStage/alleyway', -728, -230)
        setProperty('whittyBG.antialiasing', true)
        setScrollFactor('whittyBG', 0.9, 0.9)
        scaleObject('whittyBG', 1.25, 1.25, false)
        stages['whitty'] = RoboStage.new({'whittyBG'}, {}, {}, {}, 0.55)

        -- TRICKY
        makeLuaSprite('trickyBG', 'roboStage/rockymountains', -728, -230)
        setProperty('trickyBG.antialiasing', true)
        setScrollFactor('trickyBG', 0.9, 0.9)
        scaleObject('trickyBG', 1.25, 1.25, false)

        makeLuaSprite('trickySky', 'roboStage/rockysky', -728, -230)
        setProperty('trickySky.antialiasing', true)
        setScrollFactor('trickySky', 0.7, 0.7)
        scaleObject('trickySky', 1.25, 1.25, false)

        stages['tricky'] = RoboStage.new({'trickySky', 'trickyBG'}, {}, {boyfriend = {775, 482.3}, gf = {115, 149}, dad = {-160, 315.3}}, {}, 0.55)

        -- matt shit
        makeLuaSprite('mattbg', 'roboStage/matt_bg', -200, -230)
        setProperty('mattbg.antialiasing', true)
        setScrollFactor('mattbg', 0.4, 0.4)
        scaleObject('mattbg', 1.05, 1.05, false)

        makeLuaSprite('mattfg', 'roboStage/matt_foreground', getProperty('mattbg.x'), getProperty('mattbg.y'))
        setProperty('mattfg.antialiasing', true)
        setScrollFactor('mattfg', 0.9, 0.9)
        scaleObject('mattfg', 1.05, 1.05, false)

        makeAnimatedLuaSprite('mattcrowd', 'roboStage/matt_crowd', getProperty('mattbg.x')-55, getProperty('mattbg.y')-15)
        addAnimationByPrefix('mattcrowd', 'bop', 'robo crowd hehe', 24, false)
        setProperty('mattcrowd.antialiasing', true)
        setScrollFactor('mattcrowd', 0.85, 0.85)

        makeLuaSprite('spotlight', 'roboStage/matt_spotlight', getProperty('mattbg.x'), getProperty('mattbg.y'))
        setProperty('spotlight.antialiasing', true)
        setScrollFactor('spotlight', 0.73, 0.73)

        local dumboffset = 95
        stages['matt'] = RoboStage.new({'mattbg', 'mattcrowd', 'mattfg'}, {'spotlight'}, {
            boyfriend = {1280.2 - dumboffset, 482.3 - 150},
            gf = {585 - dumboffset, 149 - 70},
            dad = {130.7 - dumboffset + (100), 365.3 - 150 - (50)}},
        {}, 0.73)

        -- week 1
        makeLuaSprite('bg1', nil, -720, -450)
        loadGraphic('bg1', 'w1city', 2560, 1400, true)
        addAnimation('bg1', 'idle', {3}, 0)
        playAnim('bg1', 'idle')
        scaleObject('bg1', 0.3, 0.3, false)
        setProperty('bg1.antialiasing', true)
        setScrollFactor('bg1', 0.9, 0.9)

        makeLuaSprite('w1city', nil, getProperty('bg1.x'), getProperty('bg1.y'))
        loadGraphic('w1city', 'w1city', 2560, 1400, true)
        addAnimation('w1city', 'idle', {0, 1, 2}, 0)
        playAnim('w1city', 'idle')
        scaleObject('w1city', getProperty('bg1.scale.x'), getProperty('bg1.scale.y'), false)
        setProperty('w1city.antialiasing', true)
        setScrollFactor('w1city', 0.9, 0.9)
        setProperty('w1city.ID', 42069)

        makeLuaSprite('stageFront', 'stagefront', -730, 530)
        setGraphicSize('stageFront', getProperty('stageFront.width') * 1.1, getProperty('stageFront.height') * 1.1)
        setProperty('stageFront.antialiasing', true)
        setScrollFactor('stageFront', 0.9, 0.9)
        setProperty('stageFront.active', false)

        makeLuaSprite('stageCurtains', songName:lower() == 'down bad' and 'stagecurtainsDOWNBAD' or 'stagecurtains', -500, -300)
        setGraphicSize('stageCurtains', getProperty('stageCurtains.width') * 0.9, getProperty('stageCurtains.height') * 0.9)
        setProperty('stageCuratins.antialiasing', true)
        setScrollFactor('stageCurtains', 0.9, 0.9)
        setProperty('stageCurtains.active', false)

        stages['week1'] = RoboStage.new({'bg1', 'w1city', 'stageFront', 'stageCurtains'}, {}, {boyfriend = {1070, 360}, gf = {400, 85}, dad = {-50, 200}},
        {}, 0.757)

        -- WEEK 5
        makeLuaSprite('w5bg', 'stages/week5/yukichi', -820, -400)
        setProperty('w5bg.antialiasing', true)
        setScrollFactor('w5bg', 0.9, 0.9)

        stages['week5'] = RoboStage.new({'w5bg'}, {}, {}, {}, 0.55)

        -- WEEK 2.5
        makeLuaSprite('church', 'bg_taki', -948, -779)
        setProperty('church.antialiasing', true)

        stages['church'] = RoboStage.new({'church'}, {}, {}, {gf = 1, boyfriend = 1}, 0.55)

        -- SCHOOL
        local prefix = 'stages/week6/weeb/'
        makeLuaSprite('bgSky', prefix..'weebSky', 0, -200)
        setScrollFactor('bgSky', 0.9, 0.9)

        local repositionShit = -200

        makeLuaSprite('bgSchool', prefix..'weebSchool', repositionShit)
        setScrollFactor('bgSchool', 0.9, 0.9)

        makeLuaSprite('bgStreet', prefix..'weebStreet', repositionShit)
        setScrollFactor('bgStreet', 0.9, 0.9)

        local widShit, hgShit = tonumber(getProperty('bgSky.width') * 6), tonumber(getProperty('bgSky.height') * 6)

        setGraphicSize('bgSky', widShit, hgShit)
        setGraphicSize('bgSchool', widShit, hgShit)
        setGraphicSize('bgStreet', widShit, hgShit)

        makeLuaSprite('bgFront', prefix..'weebfront', repositionShit)
        setScrollFactor('bgFront', 0.9, 0.9)

        makeLuaSprite('bgOverlay', prefix..'weeboverlay', repositionShit)
        setScrollFactor('bgOverlay', 0.9, 0.9)

        setGraphicSize('bgFront', widShit, hgShit)
        setGraphicSize('bgOverlay', widShit, hgShit)

        stages['school'] = RoboStage.new({'bgSky', 'bgSchool', 'bgStreet', 'bgFront', 'bgOverlay'}, {}, {}, {gf = 1}, 0.98)

        -- Week 4
        local week4Assets = {}
        for _, i in pairs({'sky', 'city', 'water', 'boardwalk'}) do
            makeLuaSprite('spr_'..i, 'stages/week4/'..i, -300, -300)
            scaleObject('spr_'..i, 1.4, 1.4, false)
            setProperty('spr_'..i..'.antialiasing', true)
            table.insert(week4Assets, 'spr_'..i)
        end

        table.insert(week4Assets, 'cherry')
        stages['boardwalk'] = RoboStage.new(week4Assets, {}, {boyfriend = {850, 395}, dad = {180, 245}},
        {boyfriend = 1, dad = 1}, 0.9)

        addSprites(stages['boardwalk'].backgroundSprites, 'roboBackground')
        setProperty('gf.visible', false)
    end

    addInstance('roboBackground')
    addInstance('roboForeground', true)
end

function onCreatePost()
    if shadersEnabled then
        initLuaShader('ChromaticAberration')
    end

    for _, char in pairs({'dad', 'gf', 'boyfriend'}) do
        setScrollFactor(char, 0.9, 0.9)
    end

    switchStage(curStage)
end

function switchStage(stage)
    if stages[stage] == nil then
        debugPrint(stage..' does not exist')
        return
    end

    local _stage = stages[stage]

    addSprites(_stage.backgroundSprites, 'roboBackground')
    addSprites(_stage.foregroundSprites, 'roboForeground')

    for ch, pos in pairs(_stage.positioning) do
        if ch ~= nil then
            callMethod(ch..'.setPosition', {pos[1], pos[2]})
            setScrollFactor(ch, _stage.characterScrolling[ch], _stage.characterScrolling[ch])
        end
    end

    setProperty('defaultCamZoom', _stage.cameraZoom)

    if curStage == stage then
        return end

    if getProperty('health') > 1 then
        setProperty('health', 1)
    end

    setProperty('gf.color', setProperty('boyfriend.color', setProperty('dad.color', 0xffffff)))
    if stage == 'tricky' then
        setProperty('gf.color', setProperty('boyfriend.color', setProperty('dad.color', 0xffe6d8)))
    elseif stage == 'church' then
        replaceGf('taki')
    elseif stage == 'boardwalk' or stage == 'matt' then
        replaceGf('die')
    else
        replaceGf('gf')
    end

    local curGF = stage == 'church' and 'taki' or stage == 'boardwalk' and 'cherry' or stage == 'school' and 'tea_pixel' or 'gf'
    callMethod('camFollow.setPosition', {getMidpointX(curGF) - 460, getMidpointY(curGF) + 250})

    curStage = stage
    cameraFlash('camGame', (stage == 'default' or stage == 'c354r-default') and '000000' or 'ffffff', 0.45)

    if curStage == 'default' or curStage == 'c354r-default' then
        setProperty('camGame.zoom', _stage.cameraZoom)
    end

    setProperty('camZooming', true)
    setProperty('isCameraOnForcedPos', false)

    -- CAMERA POSITIOOONSSS
    if stage == 'default' or stage == 'whitty' then
        setProperty('boyfriendCameraOffset[1]', -330)
        setProperty('boyfriendCameraOffset[0]', -500)
        setProperty('opponentCameraOffset[1]', -190)
        setProperty('opponentCameraOffset[0]', 340)
    elseif stage == 'tricky' then
        setProperty('boyfriendCameraOffset[0]', -220)
        setProperty('boyfriendCameraOffset[1]', -200)
        setProperty('opponentCameraOffset[1]', 0)
        setProperty('opponentCameraOffset[0]', 80)
    elseif stage == 'c354r-default' then
        setProperty('boyfriendCameraOffset[0]', -110)
        setProperty('boyfriendCameraOffset[1]', -310)
        setProperty('opponentCameraOffset[0]', -40)
        setProperty('opponentCameraOffset[1]', -180)
    else
        setProperty('boyfriendCameraOffset[0]', -390)
        setProperty('boyfriendCameraOffset[1]', -180)
        setProperty('opponentCameraOffset[1]', -30)
        setProperty('opponentCameraOffset[0]', 325)
    end
end

function addSprites(sprites, typedGroup)
    for i = 0, getProperty(typedGroup..'.length')-1 do
        callMethod(typedGroup..'.remove', {instanceArg(spr), true})
        callMethod(typedGroup..'.members['..i..'].kill', {''})
    end

    for _, spr in pairs(sprites) do
        if not getProperty(spr..'.alive') then
            callMethod(spr..'.revive', {''})
        end

        callMethod(typedGroup..'.add', {instanceArg(spr)})
    end
end

function onBeatHit()
    if curBeat == 0 or curBeat == 1 then
        setProperty('camHUD.visible', false)
    elseif curBeat == 32 then
        setProperty('camHUD.visible', true)
        switchStage('zardy')
        setProperty('defaultCamZoom', getProperty('defaultCamZoom') + 0.22)
    elseif curBeat == 64 then
        setProperty('defaultCamZoom', getProperty('defaultCamZoom') - 0.22)
    elseif curBeat == 88 then
        setProperty('defaultCamZoom', getProperty('defaultCamZoom') + 0.3)
    elseif curBeat == 92 or curBeat == 104 or curBeat == 123 or curBeat == 464 or curBeat == 470 or curBeat == 472 or curBeat == 475 or curBeat == 488 or curBeat == 491 then
        setProperty('defaultCamZoom', getProperty('defaultCamZoom') + (curBeat > 480 and 0.05 or 0.085))
    elseif curBeat == 399 or curBeat == 528 then
        playAnim('gf', 'cheer', true)
        setProperty('gf.specialAnim', true)
    elseif curBeat == 96 or curBeat == 463 then
        switchStage('tricky')
    elseif curBeat == 128 then
        switchStage('whitty')
    elseif curBeat == 144 or curBeat == 288 then
        switchStage('boardwalk')
    elseif curBeat == 160 or curBeat == 592 then
        switchStage('c354r-default')
    elseif curBeat == 224 or curBeat == 560 then
        switchStage('week1')
    elseif curBeat == 256 or curBeat == 432 then
        switchStage('week5')
    elseif curBeat == 320 then
        switchStage('school')
        setPropertyFromClass('states.PlayState', 'stageUI', 'pixel')
        for i = 0,getProperty('notes.length')-1 do
	    callMethod('notes.members['..i..'].reloadNote', {''}) end
	for i = 0,getProperty('unspawnNotes.length')-1 do
	    callMethod('unspawnNotes['..i..'].reloadNote', {''}) end
	for i = 0, 7 do
	    callMethod('strumLineNotes.members['..i..'].reloadNote', {''}) end
        callMethod('iconP1.changeIcon', {'bf-pixel'})
        callMethod('iconP2.changeIcon', {'robofever-pixel'}) callScript('scripts/FeverHUD', 'loadIcons', {})
        callMethod('tea_pixel.setPosition', {getProperty('gf.x') + 460, getProperty('gf.y') + 265})
        callMethod('fever_pixel.setPosition', {getProperty('boyfriend.x') + 190, getProperty('boyfriend.y') + 50})
        callMethod('robofever.setPosition', {getProperty('dad.x') + 455, getProperty('dad.y') + 180})

        addInstance('tea_pixel')
        addInstance('robofever') curOpponent = 'robofever'
        addInstance('fever_pixel') curPlayer = 'fever_pixel'
        setProperty('dad.visible', false)
        setProperty('boyfriend.visible', false)
    elseif curBeat == 336 then
        switchStage('c354r-default')
        setPropertyFromClass('states.PlayState', 'stageUI', '')
        for i = 0,getProperty('notes.length')-1 do
	    callMethod('notes.members['..i..'].reloadNote', {''}) end
	for i = 0,getProperty('unspawnNotes.length')-1 do
	    callMethod('unspawnNotes['..i..'].reloadNote', {''}) end
	for i = 0, 7 do
	    callMethod('strumLineNotes.members['..i..'].reloadNote', {''}) end
        callMethod('iconP1.changeIcon', {boyfriendName})
        callMethod('iconP2.changeIcon', {dadName}) callScript('scripts/FeverHUD', 'loadIcons', {})
        callMethod('tea_pixel.kill', {''}) callMethod('fever_pixel.kill', {''}) callMethod('robofever.kill', {''})
        setProperty('dad.visible', true) setProperty('boyfriend.visible', true)
        curOpponent = 'dad' curPlayer = 'boyfriend'
    elseif curBeat == 400 then
        switchStage('church')
    elseif curBeat == 494 then
        cameraSetTarget('dad')
        playAnim('dad', 'hey', true)
    elseif curBeat == 496 then
        switchStage('matt')
    elseif (curBeat == 355 or curBeat == 359 or curBeat == 387 or curBeat == 391) and shadersEnabled then
        if curBeat == 355 then
            runHaxeCode([[
                var ch = game.createRuntimeShader('ChromaticAberration'); setVar('ch', ch);
	        camGame.setFilters([new ShaderFilter(ch)]);
            ]])
        end

        if curBeat == 355 or curBeat == 359 then
            runHaxeCode([[
                FlxTween.num(0, 0.0065, Conductor.crochet / 1300, null, (val:Float) -> {getVar('ch').setFloat('rOffset', val);});
                FlxTween.num(0, -0.0065, Conductor.crochet / 1300, null, (val:Float) -> {getVar('ch').setFloat('bOffset', val);});
            ]])
            callMethod('camFollow.setPosition', {getMidpointX('dad') + 250, getMidpointY('dad') - 190})
        else
            callMethod('camFollow.setPosition', {getMidpointX('boyfriend') - 300, getMidpointY('boyfriend') - 320})
        end
        setProperty('defaultCamZoom', getProperty('defaultCamZoom') + 0.245)
        setProperty('camGame.zoom', getProperty('defaultCamZoom'))
    elseif (curBeat == 356 or curBeat == 360 or curBeat == 388 or curBeat == 392) and shadersEnabled then
        runHaxeCode([[
            FlxTween.num(0.0065, 0, 0.25, null, (val:Float) -> {getVar('ch').setFloat('rOffset', val);});
            FlxTween.num(-0.0065, 0, 0.25, null, (val:Float) -> {getVar('ch').setFloat('bOffset', val);});
        ]])
        setProperty('defaultCamZoom', getProperty('defaultCamZoom') - 0.245)
        setProperty('camGame.zoom', getProperty('defaultCamZoom'))
    end

    callMethod('cherry.dance', {''})
    callMethod('taki.dance', {''})
    callMethod('tea_pixel.dance', {''})

    for i = 0, getProperty('roboBackground.length')-1 do
        if curStage == 'week1' then
            if getProperty('roboBackground.members['..i..'].ID') == 42069 and curBeat % 4 == 0 then
                if getProperty('roboBackground.members['..i..'].animation.curAnim.curFrame') > 2 then
                    setProperty('roboBackground.members['..i..'].animation.curAnim.curFrame', 0)
                else
                    setProperty('roboBackground.members['..i..'].animation.curAnim.curFrame', getProperty('roboBackground.members['..i..'].animation.curAnim.curFrame')+1)
                end
            end
        end
    end

    if curStage == 'matt' then
        playAnim('mattcrowd', 'bop')
    end
end

function replaceGf(gf)
    if gf == 'taki' then
        setProperty('gf.visible', false)
        addInstance('taki') takiExists = true
        callMethod('taki.setPosition', {245, 149 - 190})
    elseif gf == 'die' then
        setProperty('gf.visible', false)
    else
        setProperty('gf.visible', false)

        if takiExists then
            removeLuaSprite('taki')
            takiExists = false
        end
    end
end

function goodNoteHit(id, noteData)
    if curPlayer ~= 'boyfriend' then
        playAnim(curPlayer, getProperty('singAnimations')[noteData+1], true)
        setProperty(curPlayer..'.holdTimer', 0)
    end
end

function opponentNoteHit(id, noteData)
    if curOpponent ~= 'boyfriend' then
        playAnim(curOpponent, getProperty('singAnimations')[noteData+1], true)
        setProperty(curOpponent..'.holdTimer', 0)
    end

    if curBeat >= 400 and curBeat < 432 then
        setProperty('health', getProperty('health') - 0.01)
    end
end

RoboStage = {}
RoboStage.__index = RoboStage

RoboStage.defPositioning = {
    boyfriend = {1085.2, 482.3},
    gf = {245, 149},
    dad = {-254.7, 315.3}
}

function RoboStage.new(backgroundSprites, foregroundSprites, positioning, characterScrolling, cameraZoom)
    local self = setmetatable({}, RoboStage)

    for k, v in pairs(RoboStage.defPositioning) do
        if positioning[k] == nil then
            positioning[k] = v
        end

        if characterScrolling[k] == nil then
            characterScrolling[k] = 0.9
        end
    end

    if boyfriendName == 'bf' and cameraZoom ~= 0.98 then
        positioning.boyfriend[1] = positioning.boyfriend[1] - 50
    end

    self.positioning = positioning
    self.characterScrolling = characterScrolling
    self.cameraZoom = cameraZoom or 0.4

    self.backgroundSprites = backgroundSprites
    self.foregroundSprites = foregroundSprites == nil and {} or foregroundSprites

    return self
end