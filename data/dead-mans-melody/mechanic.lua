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