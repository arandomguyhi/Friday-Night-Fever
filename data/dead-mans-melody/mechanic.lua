-- MECHANIC SHIT
local isDad = false
local rowProperties = {}
local inMechanic = false
local parried = false

function onCreate()
    setProperty('camZooming', false)

    makeLuaSprite('platform', 'paste/platform')
    setProperty('platform.antialiasing', true)
    setProperty('platform.visible', false)
    addLuaSprite('platform')

    createInstance('tea', 'objects.Character', {0, 0, 'gf-fight'})
    setProperty('tea.visible', false)
    addLuaSprite('tea')

    createInstance('pasta', 'objects.Character', {getProperty('dad.x') - 550, getProperty('dad.y') - 580, 'toothpaste-mad'})
    addInstance('pasta')
    setProperty('pasta.visible', false)

    makeAnimatedLuaSprite('feverParry', 'characters/fever/Fever_paste_anims', 570, -10)
    setProperty('feverParry.antialiasing', true)
    addAnimationByPrefix('feverParry', 'parry', 'fever parry', 24, false)
    playAnim('feverParry', 'parry')
    addLuaSprite('feverParry')
    setProperty('feverParry.alpha', 0.0000000000000000000009)

    makeAnimatedLuaSprite('pasteSlam', 'characters/paste/paste_anims', getProperty('pasta.x') - 200, getProperty('pasta.y') - 165)
    setProperty('pasteSlam.antialiasing', true)
    addAnimationByPrefix('pasteSlam', 'smash', 'toothpaste smash', 24, false)
    addAnimationByPrefix('pasteSlam', 'parry', 'toothpaste parry', 24, false)
    playAnim('pasteSlam', 'smash')
    addLuaSprite('pasteSlam')
    setProperty('pasteSlam.alpha', 0.0000000000000000000009)

    setHUDVisibility(false)

    if getPropertyFromClass('states.PlayState', 'deathCounter') > 0 then
	setProperty('skipCountdown', true)

	setPropertyFromClass('flixel.FlxG', 'sound.music.time', 42950)
	setPropertyFromClass('backend.Conductor', 'songPosition', 42950)
	setProperty('gf.visible', false)
	setProperty('boyfriend.x', getProperty('boyfriend.x') - 50)

	setProperty('defaultCamZoom', 0.76)
	setProperty('blackScreen.visible', true)
    else
	for _, i in pairs({'bg', 'fire', 'boyfriend', 'gf'}) do
	    setProperty(i..'.color', 0x0)
	    doTweenColor('colortwn'.._, i, 'ffffff', 10)
	end

	setProperty('camGame.zoom', 1)
	startTween('startiezoom', 'camGame', {zoom = 0.76}, 15, {onComplete = 'forcezoom'})
	function forcezoom() setProperty('defaultCamZoom', 0.76) end
    end
end

function onUpdate(elapsed)
    local cB = (getSongPosition() / 1000) * (curBpm / 60)
    setProperty('pasta.y', (getProperty('dad.y') - 580) + (11 * math.cos((cB / 2) * math.pi))

    for _, i in pairs(ghosts) do
	-- die devs :angyface:
	if getProperty(i..'.animation.curAnim.name') == 'idle'
	    and getProperty(i..'.x') > getProperty('tea.x') - 160 - getProperty(i..'.health')
	    or getProperty(i..'.animation.curAnim.name') == 'idle-flip'
	    and getProperty(i..'.x') <= getProperty('tea.x') + getProperty('tea.width') + getProperty(i..'.health') then
		teaPunch(_)
	    end
	end
    end

    if inMechanic then
	if botPlay then
	    parried = getRandomBool(10)
	    setVar('spacePressed', true)
	end

	if getVar('spacePressed') and not botPlay then
	    setVar('canPressSpace', false)
	    if getProperty('pasteSlam.animation.curAnim.curFrame') <= 11 then
		debugPrint('dodge')
		playAnim('boyfriend', 'dodge') setProperty('boyfriend.specialAnim', true)

		runTimer('getBackToIdle', 0.2)
		function onTimerCompleted(tag) if tag == 'getBackToIdle' then playAnim('boyfriend', 'idle', true) end end

		inMechanic = false
		addHealth(0.05)
		runHaxeCode([[
		    game.getLuaObject('pasteSlam').animation.finishCallback = (anim) -> {
			setVar('spacePressed', false);
			getVar('pasta').alpha = 1;
			game.getLuaObject('pasteSlam').alpha = 0.0000000000000000000009;
			setVar('canHey', true);
		    };
		]])
	    elseif getProperty('pasteSlam.animation.curAnim.curFrame') >= 12 and getProperty('pasteSlam.animation.curAnim.curFrame') <= 15 then
		debugPrint('parry')
		parried = true
		playAnim('boyfriend', 'idle')
	    end

	    if getProperty('pasteSlam.animation.curAnim.curFrame') >= 15 and not getVar('spacePressed') then
		debugPrint('dead')
		inMechanic = false
		setVar('gotSmushed', true)
		setVar('canHey', true)
		setHealth(-1)
		return
	    end
	end
    end

    if getProperty('pasteSlam.animation.curAnim.curFrame') >= 14 and parried = true then
	setVar('spacePressed', true)
	parried = true
	setVar('spaceDelay', 0)

	if getProperty('boyfriend.curCharacter') == 'bf-demon' then
	    setProperty('boyfriend.alpha', 0.0000000000000000000009)
	    setProperty('feverParry.alpha', 1)
	    playAnim('feverParry', 'parry', true)
	else
	    playAnim('boyfriend', 'hey') setProperty('boyfriend.specialAnim', true)
	end

	playAnim('pasteSlam', 'parry', true)
	playSound('parry', 1)
	addHealth(0.1)
	inMechanic = false
	parried = false
	runHaxeCode([[
	    game.getLuaObject('pasteSlam').animation.finishCallback = (anim) -> {
		boyfriend.alpha = 1;
		getVar('pasta').alpha = 1;
		setVar('canHey', true);

		game.getLuaObject('feverParry').alpha = 0.0000000000000000000009;
		game.getLuaObject('pasteSlam').alpha = 0.0000000000000000000009;
	    };
	]])
    end

    if getProperty('pasteSlam.animation.curAnim.name') == 'parry' then
	setProperty('pasteSlam.offset.x', -511)
	setProperty('pasteSlam.offset.y', -200)
    else
	setProperty('pasteSlam.offset.x', -50)
	setProperty('pasteSlam.offset.y', -25)
    end
end

function onMoveCamera(target)
    isTarget = target == 'dad' and true or false
end

function onBeatHit()
    if curBeat == 363 or curBeat == 716 then
	startTween('healthTween', 'game', {health = 0.1}, 1, {})
	cameraShake('camGame', 0.005, 1)
	cameraShake('camHUD', 0.007, 1)
	playAnim('pasta', 'scream', true)
    end

    if getProperty('pasta.animation.curAnim.name') ~= 'scream' then
	if curBeat >= 146 and curBeat % 5 == 0 and getRandomBool(10) then
	    debugPrint('WORK')
	    smashMechanic()
	elseif curStep >= 1472 and curBeat % 5 == 0 and getRandomBool(25) then
	    debugPrint('WORK')
	    smashMechanic()
	end
    end

    if getProperty('pasta.animation.curAnim.name') == 'idle' then
	callMethod('pasta.dance', {''}) end
end

function onStepHit()
    if curStep == 556 then
	playAnim('dad', 'transition', true)
	setProperty('dad.specialAnim', true)
	cameraShake('camGame', 0.045, 1.3)

	runHaxeCode([[
	    dad.animation.finishCallback = (a) -> {
		game.defaultCamZoom = 0.39;
		game.camZooming = true;

		camGame.flash(0xFFFFFFFF, 0.85);
		gf.visible = false;
		dad.visible = false;
		getVar('pasta').visible = true;

		getVar('tea').visible = true;
		game.getLuaObject('platform').visible = true;

		boyfriend.setPosition(770, 225);
		getVar('tea').setPosition(boyfriend.x + 690, boyfriend.y - 500);
		game.getLuaObject('platform').setPosition(tea.x - 28, tea.y + tea.height - 125);
	    }
	]])
    end
end

function opponentNoteHit(id, noteData, noteType, isSustainNote)
    if getProperty('pasta.visible') or getProperty('pasta.alpha') >= 1 then
	playAnim('pasta', getProperty('singAnimations')[noteData+1], true)
	setProperty('pasta.holdTimer', 0)
    end
end

function setHUDVisibility(theBool)
    for i = 0, 7 do
	setProperty('strumLineNotes.members['..i..'].alpha', theBool and 1 or 0.001) end

    for _, i in pairs({'iconP1', 'iconP2', 'healthBar', 'healthBar.bg', 'scoreTxt'}) do
	setProperty(i..'.visible', theBool) end
end

function smashMechanic()
    local swagCounter = 0
    runTimer('warning', crochet / 1000, 3)

    function onTimerCompleted(tag)
	if tag == 'warning' then
	    makeLuaSprite('warning', 'mechanicShit/warning', 768, 164.5)
	    setObjectCamera('warning', 'camHUD')
	    addLuaSprite('warning')

	    playSound('alert', 1)
	    startTween('warninAlpha', 'warning', {alpha = 0}, crochet / 1000, {onComplete = 'destroyWarn'})
	    function destroyWarn() removeLuaSprite('warning') end

	    swagCounter = swagCounter + 1
	    debugPrint(swagCounter)

	    if swagCounter == 2 then
		setVar('canHey', false)
		playSound('smash', 1)

		setProperty('pasta.alpha', 0.00000000000000000009)
		setProperty('pasteSlam.alpha', 1)
		playAnim('pasteSlam', 'smash', true)

		setVar('spacePressed', false)
		setVar('canPressSpace', true)
		inMechanic = true
	    end
	end
    end
end