if not checkFileExists('data/'..songPath..'/dialogue.xml') then return end
if seenCutscene then return end

-- tried to do something cool and useful lol, ig it didn't worked
-- that's a recreation of DialogueBox.hx from Fever btw

function onStartCountdown()
    if not allowCountdown then
        allowCountdown = true

        setProperty('inCutscene', true)
        if songName:lower() == 'shadow' then
            callMethod('camFollow.setPosition', {getMidpointX('boyfriend') - 90, getMidpointY('boyfriend') - 150})
            setProperty('isCameraOnForcedPos', true)
        else
            callMethod('camFollow.setPosition', {getMidpointX('gf'), getMidpointY('gf')})
        end

        return Function_Stop
    end
    return Function_Continue
end

-- DialoguePortrait shit
DialoguePortrait = {}
DialoguePortrait.__index = DialoguePortrait

function DialoguePortrait.new(char)
    local self = setmetatable({}, DialoguePortrait)

    local p = 'p_'..char
    makeAnimatedLuaSprite(p, 'dialogue/'..char:lower(), 0, -90)
    setProperty(p..'.antialiasing', true)
    self.character = char

    runHaxeFunction('addAnims', {p, char})

    setObjectCamera(p, 'hud')

    if callMethod(p..'.animation.exists', {'neutral'}) then
        playAnim(p, 'neutral')
    end

    if char == 'mega' then
        setProperty(p..'.origin.x', 0) setProperty(p..'.origin.y', 0)
        scaleObject(p, 2.4, 2.4)
        setProperty(p..'.width', getProperty(p..'.width') - 250)
        setProperty(p..'.antialiasing', false)
    else
        scaleObject(p, 0.9, 0.9)
    end

    self.spr = p
    self.ogScale = getProperty(p..'.scale.x')

    return self
end

function DialoguePortrait:jump()
    local spr, ogScale = self.spr, self.ogScale
    unjump = function()
        startTween(spr..'_unjump', spr, {['scale.y'] = ogScale, y = getProperty(spr..'.y') + 18}, 0.04, {ease = 'elasticInOut'})
    end
    startTween(spr..'_jump', spr, {['scale.y'] = ogScale + 0.025, y = getProperty(spr..'.y') - 18}, 0.05, {onComplete = 'unjump'})
end

-- now, into the actual shitttttttttttt
setVar('fadeOut', true)

local portraits = portraits or {}
local curLeft
local curRight
local curPortrait

local dialogueStarted = false
local skip = false

local showOnlyBG

function onCreate()
    makeLuaSprite('bgDia') makeGraphic('bgDia', screenWidth, screenHeight, '000000')
    setProperty('bgDia.antialiasing', true)
    setProperty('bgDia.alpha', 0.7)
    setObjectCamera('bgDia', 'hud')
    addLuaSprite('bgDia')

    runHaxeFunction('parseDialogue', {'data/'..songPath..'/dialogue.xml'})

    makeLuaSprite('box', 'dialogue/box', 0, 460)
    screenCenter('box', 'X')
    setProperty('box.antialiasing', true)
    setObjectCamera('box', 'hud')
    addLuaSprite('box')

    createInstance('text', 'flixel.addons.text.FlxTypeText', {getProperty('box.x') + 25, getProperty('box.y') + 25, screenWidth * 0.85, '', 40})
    setTextFont('text', 'Plunge.otf')
    setTextColor('text', 'ffffff') setProperty('text.borderSize', 1)
    setProperty('text.delay', 0.033)
    callMethod('text.setTypingVariation', {0.5, true})
    setObjectCamera('text', 'hud')
    addInstance('text')

    makeLuaText('skipDia', 'PRESS ESCAPE/BACKSPACE TO SKIP', screenWidth, 50, screenHeight - 40)
    setTextSize('skipDia', 32)
    setTextFont('skipDia', 'vcr.ttf')
    setTextAlignment('skipDia', 'LEFT')
    setObjectCamera('skipDia', 'hud')
    addLuaText('skipDia')
    startTween('warn', 'skipDia', {alpha = 0}, 3, {startDelay = 3})

    setProperty('box.y', screenHeight)
    if getVar('actions')[1].setBG ~= nil then
        setBG(getVar('actions')[1].setBG)
    elseif getVar('actions')[1].fillBG ~= nil then
        fillBG(getVar('actions')[1].fillBG)
    end

    startTween('boxie', 'box', {y = 460}, 0.5, {ease = 'elasticInOut', onComplete = 'letsstart'})
    letsstart = function()
        dialogueStarted = true
        startDialogue()
    end
end

function onUpdate(elapsed)
    if keyboardJustPressed('ONE') then
        restartSong()
    end

    if not dialogueStarted then return end

    if keyboardJustPressed('ESCAPE') or keyboardJustPressed('BACKSPACE') then
        return endDialogue()
    end

    setProperty('text.delay', keyboardPressed('SHIFT') and 0.02 or 0.033)

    if (keyboardJustPressed('SPACE') or keyboardJustPressed('ENTER')) or not getProperty('text._typing') and skip then
        if not getProperty('text._typing') then
            startDialogue()
        else
            callMethod('text.skip', {''})
        end
    end
end

function startDialogue()
    local actions = getVar('actions')

    if actions[1] == nil then
        return endDialogue()
    end

    local action = actions[1]
    callMethod('actions.shift', {''})

    if action.playSound ~= nil then
        playSound(action.playSound, 1)
    end

    if action.fadeInMus ~= nil then
        local split = stringSplit(action.fadeInMus, ':')
        if checkFileExists('songs/'..split[1]..'/Inst.ogg') then
            playMusic('../songs/'..split[1]..'/Inst', 0)
        else
            playMusic(split[1], 0)
        end
        soundFadeIn('', 1, 0, split[2] ~= nil and tonumber(split[2]) or 1)
    end

    if action.shake then
        for _, camera in pairs(getPropertyFromClass('flixel.FlxG', 'cameras.list')) do
            cameraShake(camera, 0.05, 0.5)
        end
    end

    if action.fadeOutMus ~= nil then
        soundFadeOut('', 1, 0)
    end

    if action.fillBG ~= nil then
        fillBG(action.fillBG)
    elseif action.setBG ~= nil then
        setBG(action.setBG)
    elseif action.fadeBG ~= nil then
        -- how this doesnt work, not wasting ma time :glasses:
    end

    if action.portrait ~= nil and portraits[action.portrait] ~= nil then
        setCorrectPortrait(action)

        if action.effect ~= nil and action.effect == 'jump' then
            callMethodFromClass('flixel.tweens.FlxTween', 'completeTweensOf', {instanceArg(portraits[action.portrait].spr)})
            portraits[action.portrait]:jump()
        end
    elseif action.portraits ~= nil then
        for _, i in ipairs(action.portraits) do
            setCorrectPortrait({portrait = i})

            if action.effect ~= nil and action.effect == 'jump' then
                callMethodFromClass('flixel.tweens.FlxTween', 'completeTweensOf', {instanceArg(portraits[i].spr)})
                portraits[i]:jump()
            end
        end

        local prev = portraits[action.portraits[1]]
        setProperty(prev.spr..'.color', getColorFromHex('ffffff'))
    end

    if action.narrate then
        runHaxeCode("getVar('text').sounds = [];")

        if curLeft ~= nil then
            setProperty(curLeft.spr..'.color', getColorFromHex('828282')) end
        if curRight ~= nil then
            setProperty(curRight.spr..'.color', getColorFromHex('828282')) end
    end

    if action.emotion ~= nil and curPortrait ~= nil then
        playAnim(curPortrait.spr, action.emotion)
    end

    if action.showOnlyBackground ~= nil then
        showOnlyBG = action.showOnlyBackground
    end

    if showOnlyBG ~= nil then
        if curLeft ~= nil then
            setProperty(curLeft.spr..'.visible', not showOnlyBG) end
        if curRight ~= nil then
            setProperty(curRight.spr..'.visible', not showOnlyBG) end
        setProperty('box.alpha', showOnlyBG and 0.65 or 1)
    end

    skip = action.proceedImmediately

    if action.msg ~= nil then
        callMethod('text.resetText', {stringTrim(action.msg)})
        callMethod('text.start', {0.04, true})

        runHaxeCode("getVar('text').sounds = [FlxG.sound.load(Paths.sound('dialogue/' + (StringTools.startsWith(getVar('soundThing'), 'fever') ? 'fever' : getVar('soundThing'))), 0.6)];")

        if getProperty('text.sounds') ~= nil and getProperty('text.sounds[0]') ~= nil then
            setProperty('text.sounds[0].volume', 0.35)
        end
    elseif actions[1] ~= nil then
        startDialogue()
    end
end

function fillBG(color)
    if color == 'WHITE' then color = 'ffffff' end
    makeGraphic('bgDia', screenWidth, screenHeight, color)
    setProperty('bgDia.alpha', 1)
end

function setBG(bgStr)
    if #bgStr > 0 then
        loadGraphic('bgDia', 'dialogue_backgrounds/'..bgStr)
        setProperty('bgDia.alpha', 1)
    else
        makeGraphic('bgDia', screenWidth, screenHeight, '000000')
        setProperty('bgDia.alpha', 0.7)
    end
end

function setCorrectPortrait(act)
    local portrait = portraits[act.portrait]
    if curLeft == portrait or curRight == portrait then
        act.side = curLeft == portrait and 'LEFT' or 'RIGHT'
    end

    if act.side == nil then
        act.side = startsWith(portrait.character, 'fever') and 'RIGHT' or 'LEFT'
    end

    if act.side == 'RIGHT' then
        if curRight ~= nil and curRight ~= portrait then
            setProperty(curRight.spr..'.visible', false)
        end

        if curRight ~= portrait then
            setProperty(portrait.spr..'.x', getProperty('box.x') + getProperty('box.width') - getProperty(portrait.spr..'.width') + 40)
            setProperty(portrait.spr..'.y', getProperty('box.y') - getProperty(portrait.spr..'.height') + 15)
            startTween(portrait.spr..'RTween', portrait.spr, {x = getProperty(portrait.spr..'.x') - 40}, 0.18, {})
            setProperty(portrait.spr..'.alpha', 0)
            startTween(portrait.spr..'RAlpha', portrait.spr, {alpha = 1}, 0.13, {})

            if songName:lower() == 'shadow' then
                setProperty(portrait.spr..'.y', getProperty(portrait.spr..'.y') + 20)
            end
        end

        setProperty(portrait.spr..'.flipX', not startsWith(portrait.character, 'fever'))

        curRight = portrait
        setProperty(curRight.spr..'.visible', true)
        curPortrait = curRight

        if curLeft ~= nil then
            setProperty(curLeft.spr..'.color', getColorFromHex('828282')) end
        if curRight ~= nil then
            setProperty(curRight.spr..'.color', getColorFromHex('ffffff')) end
    else
        if curLeft ~= nil and curLeft ~= portrait then
            setProperty(curLeft.spr..'.visible', false)
        end

        if curLeft ~= portrait then
            setProperty(portrait.spr..'.x', getProperty('box.x') - 40)
            setProperty(portrait.spr..'.y', getProperty('box.y') - getProperty(portrait.spr..'.height') + 15)
            startTween(portrait.spr..'LTween', portrait.spr, {x = getProperty(portrait.spr..'.x') + 40 + (portrait.character == 'mega' and -130 or 0)}, 0.18, {})
            setProperty(portrait.spr..'.alpha', 0)
            startTween(portrait.spr..'LAlpha', portrait.spr, {alpha = 1}, 0.13, {})
        end

        setProperty(portrait.spr..'.flipX', startsWith(portrait.character, 'fever'))

        curLeft = portrait
        setProperty(curLeft.spr..'.visible', true)
        setProperty(curLeft.spr..'.x', getProperty('box.x'))
        setProperty(curLeft.spr..'.y', getProperty('box.y') - getProperty(curLeft.spr..'.height') + 15)
        curPortrait = curLeft

        if curLeft.character == 'mega' then
            setProperty(curLeft.spr..'.x', getProperty(curLeft.spr..'.x') - 130)
        end

        if curRight ~= nil then
            setProperty(curRight.spr..'.color', getColorFromHex('828282')) end
        if curLeft ~= nil then
            setProperty(curLeft.spr..'.color', getColorFromHex('ffffff')) end
    end

    if act.removePortrait ~= nil then
        local port = (curLeft.character == act.removePortrait and curLeft or curRight)
        setProperty(port.spr..'.visible', false)

        if curLeft.character == act.removePortrait then
            curLeft = nil
        else
            curRight = nil
        end
    end

    setVar('soundThing', tostring(stringSplit(portrait.character, '-')[1]))
end

function endDialogue()
    dialogueStarted = false

    if getPropertyFromClass('flixel.FlxG', 'sound.music.volume') >= 0.1 then
        callMethodFromClass('flixel.FlxG', 'sound.music.stop', {''})
    end

    if not getVar('fadeOut') then
        finishCallback()
    end

    for _, i in pairs({curLeft.spr, curRight.spr, 'box', 'text', 'bgDia'}) do
        callMethodFromClass('flixel.tweens.FlxTween', 'cancelTweensOf', {instanceArg(i)})
        startTween('isTheEnd'.._, i, {alpha = 0}, 0.2, {onComplete = 'finish'})
        finish = function()
            removeLuaSprite(i)
            finishCallback()
        end
    end
end

function finishCallback()
    callOnLuas('onDialogueFinish', {''})
    startCountdown()
end

runHaxeCode([[
    import flixel.Xml;
    import Reflect;

    typedef DialogueAction =
    {
	msg:String,
	portrait:String,
	portraits:Array<String>,
	emotion:String,
	library:String,

	playSound:String,
	fadeInMus:String,
	fadeOutMus:String,
	side:String,
	fillBG:String,
	setBG:String,
	effect:String,
	narrate:Bool,
	proceedImmediately:Bool,
	showOnlyBackground:Null<Bool>,
	removePortrait:String,
	fadeBG:String,
	shake:Bool
    }

    var actions:Array<DialogueAction> = [];

    function addAnims(spr, chara) {
        // had to move this shit to a function cuz it broke with rhc grrrrrrrr
        for (i in game.getLuaObject(spr).frames.frames) {
            var cu = StringTools.replace(i.name, chara.toLowerCase() + ' ', '');
            if (!game.getLuaObject(spr).animation.exists(cu))
                game.getLuaObject(spr).animation.addByNames(cu, [i.name], 0);
        }
    }

    function parseDialogue(rawDialogue:String) {
        var data = Xml.parse(Paths.getTextFromFile(rawDialogue)).firstElement();
        for (a in data.elements())
        {
            var action:DialogueAction = {};

            action.shake = (a.exists('shake') && a.get('shake').charAt(0).toLowerCase() == "t");

            if (a.exists('showOnlyBG'))
                action.showOnlyBackground = a.get('showOnlyBG').charAt(0).toLowerCase() == 't' ? true : false;
            else
                action.showOnlyBackground = null;

            if (a.exists('removePortrait'))
                action.removePortrait = a.get('removePortrait');

            if (a.exists('portrait') || a.exists('portraits')) {
                if (a.exists('portraits')) {
                    var s = a.get('portraits').split(',');
                    for (i in s)
                        parentLua.call('addPortrait', [i]);
                    action.portraits = s;
                } else {
                    var portrait = a.get('portrait');
                    action.portrait = portrait;
                    parentLua.call('addPortrait', [portrait]);

                    if (a.exists('side'))
                        action.side = a.get('side').toLowerCase().charAt(0) == 'r' ? 'RIGHT' : 'LEFT';
                }
            }

            if (a.exists('emotion'))
                action.emotion = a.get('emotion').toLowerCase();

            if (a.exists('msg')) {
                if (a.get('msg').length < 1)
                    action.msg = '...'
                else
                    action.msg = StringTools.replace(StringTools.replace(a.get('msg'), '´', "'"), "&quot;", '"');
            } else if (a.exists('narrate')) {
                action.msg = a.get('narrate');
                action.narrate = true;
            }

            if (a.exists('fillBG'))
                action.fillBG = a.get('fillBG');
            else if (a.exists('setBG'))
                action.setBG = a.get('setBG');
            else if (a.exists('fadeBG'))
                action.fadeBG = a.get('fadeBG');

            if (a.exists('playSound'))
                action.playSound = a.get('playSound');
            if (a.exists('fadeInMus'))
                action.fadeInMus = a.get('fadeInMus');
            if (a.exists('fadeOutMus'))
                action.fadeOutMus = a.get('fadeOutMus');
            if (a.exists('effect'))
                action.effect = a.get('effect').toLowerCase();

            action.proceedImmediately = a.exists('proceedImmediately');

            if (Reflect.fields(action).length > 0)
                actions.push(action);
        }
        setVar('actions', actions);
    }
]])

function addPortrait(port)
    if not portraits[port] then
        local _portrait = DialoguePortrait.new(port)
        addLuaSprite(_portrait.spr)
        setProperty(_portrait.spr..'.visible', false)
        portraits[port] = _portrait
    end
end

function startsWith(str, start)
    return string.sub(str, 1, #start) == start
end