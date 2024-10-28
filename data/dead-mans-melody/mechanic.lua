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

    --[[createInstance('tea', 'objects.Character', {0, 0, 'gf-fight'})
    setProperty('tea.visible', false)
    addLuaSprite('tea')

    createInstance('pasta', 'objects.Character', {getProperty('dad.x') - 550, getProperty('dad.y') - 580, 'toothpaste-mad'})
    addInstance('pasta')
    setProperty('pasta.visible', false)

    makeAnimatedLuaSprite('pasteSlam', 'characters/paste/paste_anims', getProperty('pasta.x') - 200, getProperty('pasta.y') - 165)
    setProperty('pasteSlam.antialiasing', true)
    addAnimationByPrefix('pasteSlam', 'smash', 'toothpaste smash', 24, false)
    addAnimationByPrefix('pasteSlam', 'parry', 'toothpaste parry', 24, false)
    playAnim('pasteSlam', 'smash')
    addLuaSprite('pasteSlam')
    setProperty('pasteSlam.alpha', 0.0000000000000000000009)]]
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

function onStepHit()
    if curStep == 556 then
	playAnim('dad', 'transition', true)
	setProperty('dad.specialAnim', true)
	cameraShake('camGame', 0.045, 1.3)

	runHaxeCode([[
	    dad.animation.finishCallback = (a) -> {
		game.defaultCamZoom = 0.39;
		game.camZooming = true;
	    }
	]])
    end
end