luaDebugMode = true

-- only doing title state here cuz yes

local initialized = false
local curWacky = {}
local skippedIntro = false

-- color shader shit
local hue = 0
local saturation = 0

setProperty('skipCountdown', true) setProperty('camZooming', true)

function onCreatePost()
    setProperty('camGame.visible', false)
    --setProperty('camHUD.visible', false)
    setProperty('uiGroup.visible', false)

    if shadersEnabled then
        initLuaShader('ColorShader') end
        makeLuaSprite('logoBl', 'title/logo', 55, 40)
        setProperty('logoBl.antialiasing', true)
        setObjectCamera('logoBl', 'hud')
        if shadersEnabled then
            setSpriteShader('logoBl', 'ColorShader')
        end
end

function onSongStart()
    openCustomSubstate('Title State')
end

function onCustomSubstateCreate(name)
    if name == 'Title State' then
        curWacky = getIntroTextShit()[getRandomInt(1, #getIntroTextShit())]

        makeLuaSprite('bg', 'title/bg', -20, -1)
        setProperty('bg.antialiasing', true)
        setObjectCamera('bg', 'hud')
        addLuaSprite('bg')

        addLuaSprite('logoBl')

        local cool = getRandomBool(50)
        makeAnimatedLuaSprite('tea', 'title/tea', cool and 698 or 963, cool and 355 or 290)
        addAnimationByPrefix('tea', 'bump', 'tea', 24)
        playAnim('tea', 'bump')
        setProperty('tea.origin.x', 0) setProperty('tea.origin.y', 0)
        scaleObject('tea', 0.66, 0.66, false)
        setProperty('tea.antialiasing', true)
        setObjectCamera('tea', 'hud')
        addLuaSprite('tea')

        makeAnimatedLuaSprite('feva', 'title/fever', cool and 945 or 755, cool and 247 or 282)
        addAnimationByPrefix('feva', 'bump', 'fever', 24)
        playAnim('feva', 'bump')
        setProperty('feva.origin.x', 0) setProperty('feva.origin.y', 0)
        scaleObject('feva', 0.66, 0.66, false)
        setProperty('feva.antialiasing', true)
        setObjectCamera('feva', 'hud')
        addLuaSprite('feva')

        makeLuaSprite('front', 'title/front', 544, 616)
        setProperty('front.antialiasing', true)
        setObjectCamera('front', 'hud')
        addLuaSprite('front')

        runTimer('start', 0.1)
        onTimerCompleted = function(tag) if tag == 'start' then startIntro()end end
    end
end

function startIntro()
    runHaxeCode([[
        import flixel.group.FlxGroup.FlxTypedGroup;

        var credGroup = new FlxTypedGroup();
        add(credGroup);
        var textGroup = new FlxTypedGroup();
        setVar('credGroup', credGroup); setVar('textGroup', textGroup);
    ]])

    makeLuaSprite('blackScreen') makeGraphic('blackScreen', screenWidth, screenHeight, '000000')
    setObjectCamera('blackScreen', 'hud')
    addToGrp('credGroup', 'blackScreen')

    makeLuaSprite('ngSpr', 'teamfever', 0, screenHeight * 0.52)
    setObjectCamera('ngSpr', 'hud')
    addLuaSprite('ngSpr', true)
    setProperty('ngSpr.visible', false)
    scaleObject('ngSpr', 0.9, 0.9)
    screenCenter('ngSpr', 'X')
    setProperty('ngSpr.antialiasing', true)

    if initialized then
        skipIntro()
    end
end

function getIntroTextShit()
    local fullText = getTextFromFile('data/introText.txt')

    local firstArray = stringSplit(fullText, '\n')
    local swagGoodArray = {}

    for z, i in pairs(firstArray) do
        table.insert(swagGoodArray, stringSplit(i, '--'))
    end

    return swagGoodArray
end

local transitioning = false

function onCustomSubstateUpdate(name, elapsed)
    if name == 'Title State' then
        if not transitioning then
            setProperty('camhud.zoom', callMethodFromClass('flixel.math.FlxMath', 'lerp', {1, getProperty('camhud.zoom'), 0.95}))
        end

        if not transitioning and skippedIntro then
            if keyJustPressed('left') then
                setShaderFloat('logoBl', '_hue', getShaderFloat('logoBl', '_hue') - 0.35 * elapsed)
            elseif keyJustPressed('right') then
                setShaderFloat('logoBl', '_hue', getShaderFloat('logoBl', '_hue') + 0.35 * elapsed)
            end
        end

        if getProperty('controls.ACCEPT') then
            if not transitioning and skippedIntro then
                initialized = true
                transitioning = true

                cameraFlash('camhud', 'ffffff', 1)
                playSound('select', 0.7)

                runTimer('trans', 0.4)
                onTimerCompleted = function(tag)
                    if tag == 'trans' then
                        cameraFade('camHUD', '000000', 1)
                    end
                end
            elseif not skippedIntro then
                skipIntro()
            end
        end
    end
end

function createCoolText(textArray)
    for i = 1, #textArray do
        createInstance('money'..i, 'objects.Alphabet', {0, 0, textArray[i], true})
        screenCenter('money'..i, 'X')
        setProperty('money'..i..'.y', getProperty('money'..i..'.y') + (i*60)+200)
        setObjectCamera('money'..i, 'hud')
        addToGrp('credGroup', 'money'..i, true) addToGrp('textGroup', 'money'..i, true)
    end
    txtArray = #textArray
end

local coolLen = 0
function addMoreText(text)
    createInstance('coolText'..coolLen, 'objects.Alphabet', {0, 0, text, true})
    screenCenter('coolText'..coolLen, 'X')
    setProperty('coolText'..coolLen..'.y', getProperty('coolText'..coolLen..'.y') + ((getProperty('textGroup.length')+1) * 60) + 200)
    setObjectCamera('coolText'..coolLen, 'hud')
    addToGrp('credGroup', 'coolText'..coolLen, true) addToGrp('textGroup', 'coolText'..coolLen, true)
    coolLen = coolLen + 1
end

function deleteCoolText()
    runHaxeCode([[
        while getVar('textGroup').members.length > 0 {
            getVar('credGroup').remove(getVar('textGroup').members[0], true);
            getVar('textGroup').remove(getVar('textGroup').members[0], true);
        }
    ]])

    for i = 0, coolLen do removeLuaSprite('coolText'..i) end
    for i = 1, txtArray do removeLuaSprite('money'..i) end
    coolLen = 0
    txtArray = 0
end

function onBeatHit()
    scaleObject('logoBl', 1.075, 1.075, false)
    startTween('logoBump', 'logoBl.scale', {x = 1, y = 1}, (crochet/1000) / 1.5, {})

    if not initialized and not skippedIntro then
        setProperty('camHUD.zoom', getProperty('camHUD.zoom') + 0.015)
        if curBeat == 1 then
            createCoolText({'Friday Night', 'Fever Dev Team'})
        elseif curBeat == 3 then
            addMoreText('present')
        elseif curBeat == 4 then
            deleteCoolText()
        elseif curBeat == 5 then
            createCoolText({'In Collaboration', 'with'})
        elseif curBeat == 6 then
            setProperty('ngSpr.visible', true)
        elseif curBeat == 7 then
            deleteCoolText()
            setProperty('ngSpr.visible', false)
        elseif curBeat == 8 or curBeat == 12 or curBeat == 15 or curBeat == 18 or curBeat == 21 or curBeat == 24 then
            createCoolText({curWacky[1]})
        elseif curBeat == 10 or curBeat == 13 or curBeat == 16 or curBeat == 19 or curBeat == 22 or curBeat == 25 then
            addMoreText(curWacky[2])
        elseif curBeat == 11 or curBeat == 14 or curBeat == 17 or curBeat == 20 or curBeat == 23 or curBeat == 26 then
            deleteCoolText()
            curWacky = getIntroTextShit()[getRandomInt(1, #getIntroTextShit())]
        elseif curBeat == 28 then
            deleteCoolText()
            createCoolText({'Friday'})
        elseif curBeat == 29 then
            addMoreText('Night')
        elseif curBeat == 30 then
            addMoreText('Fever')
        elseif curBeat == 31 then
            addMoreText('Frenzy')
        elseif curBeat == 32 then
            skipIntro()
        end
    end
end

function skipIntro()
    if not skippedIntro then
        removeLuaSprite('ngSpr', true)
        if not initialized then
            cameraFlash('camhud', 'ffffff', 4)
        end

        callMethod('remove', {instanceArg('credGroup')})
        skippedIntro = true
    end
end

function onUpdate()
    if keyboardJustPressed('ONE') then
        restartSong()
    end

    if shadersEnabled then
        setShaderFloat('logoBl', '_hue', callMethodFromClass('flixel.math.FlxMath', 'bound', {hue, -1, 1}))
        setShaderFloat('logoBl', '_saturation', callMethodFromClass('flixel.math.FlxMath', 'bound', {saturation, -1, 1}))
    end
end

function addToGrp(grp, spr, ins)
    if ins == nil then ins = false end

    if not ins then
        runHaxeCode("getVar('"..grp.."').add(game.getLuaObject('"..spr.."'));")
    else
        runHaxeCode("getVar('"..grp.."').add(getVar('"..spr.."'));")
    end
end