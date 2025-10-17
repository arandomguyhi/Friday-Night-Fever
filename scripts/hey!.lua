setVar('canPressSpace', false);
setVar('canHey', true);

setVar('spaceDelay', 0);
setVar('spaceDelayTime', 1);

setVar('spacePressed', false);

luaDebugMode = true

function onUpdate(elapsed)
    if keyboardJustPressed('SPACE') and not botPlay and songName:lower() == 'dead-mans-melody' and getVar('spaceDelay') <= 0 then
	debugPrint('GAY');

	setVar('spaceDelay', getVar('spaceDelayTime'));

	if getVar('canPressSpace') then
	    setVar('spacePressed', true); end
    end

    if getVar('spaceDelay') > 0 then
	setVar('spaceDelay', getVar('spaceDelay') - elapsed);
    else
	setVar('spaceDelay', 0);
    end

    if keyboardJustPressed('E') then
	-- why this exists
	startTween('healthE', 'game', {health = getProperty('health') - 0.02}, 1, {})
    end

   -- HEY! thing
    if keyboardJustPressed('SPACE') and getVar('canHey') and not getProperty('inCutscene') then
	if stringStartsWith(getProperty('boyfriend.animation.curAnim.name'), 'idle') then
	    playAnim('boyfriend', 'hey', true) setProperty('boyfriend.specialAnim', true) end

	if stringStartsWith(getProperty('gf.animation.curAnim.name'), 'dance') then
	    playAnim('gf', 'cheer', true) setProperty('gf.specialAnim', true) end

	if callMethod('dad.animOffsets.exists', {'hey'}) then
	    playAnim('dad', 'hey', true) setProperty('dad.specialAnim', true) end
    end
end

local oldIcon = false
function onUpdatePost()
    -- not the smartest way to do it, but it works, so fuck it
    if keyboardJustPressed('NINE') then
	if oldIcon then
	    callMethod('iconP1.changeIcon', {getProperty('boyfriend.healthIcon')})
	    callScript('scripts/FeverHUD', 'loadIcons')
	    oldIcon = false
	else
	    callMethod('iconP1.changeIcon', {'bf-old'})
	    callScript('scripts/FeverHUD', 'loadIcons', {'bf-old'})
	    oldIcon = true
	end
	setProperty('iconP1.iconOffsets[0]', getProperty('iconP1.iconOffsets[0]') - 45)
    end
end