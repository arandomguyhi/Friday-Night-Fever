luaDebugMode = true

function onCreate()
    startVideo('soul', false, true, false, false)
    setObjectCamera('videoCutscene', 'camHUD')
end

function onCreatePost()
    setProperty('camZoomingMult', 0)
    addCharacterToList('hallow-dum', 'dad')
    callScript('stages/hallow', 'changeBG')
end

function onStepHit()
    if curStep == 1936 then
	cameraFade('camGame', '000000', 0.2)
    end

    if curStep == 1952 then
	triggerEvent('Change Character', 'dad', 'hallow-dum')

        callMethod('videoCutscene.play', {''})
        runHaxeCode("game.videoCutscene.finishCallback = parentLua.call('videoEnd', ['']);")
    end
end

function videoEnd()
    cameraFade('camGame', 0x0, 0.01, true, true)
    setProperty('isCameraOnForcedPos', true)
    setProperty('camZooming', false)
    setProperty('boyfriend.idleSuffix', '-frown')
    setProperty('camGame.zoom', getProperty('camGame.zoom') + 0.45)
    startTween('zoominOut', 'camGame', {zoom = getProperty('camGame.zoom') - 0.45}, 0.35, {onComplete = 'cameraFunc'})
    cameraFunc = function()
        setProperty('isCameraOnForcedPos', false)
        setProperty('camZooming', true)
    end
end

function onPause()
    if getProperty('videoCutscene') == nil then return end
    callMethod('videoCutscene.pause', {''})

    if callMethodFromClass('flixel.FlxG', 'signals.focusLost.has', {instanceArg('videoCutscene.videoSprite.pause')}) then
        callMethodFromClass('flixel.FlxG', 'signals.focusLost.remove', {instanceArg('videoCutscene.videoSprite.pause')})
    end
    if callMethodFromClass('flixel.FlxG', 'signals.focusGained.has', {instanceArg('videoCutscene.videoSprite.resume')}) then
        callMethodFromClass('flixel.FlxG', 'signals.focusGained.remove', {instanceArg('videoCutscene.videoSprite.resume')})
    end
end

function onResume()
    if getProperty('videoCutscene') == nil then return end
    callMethod('videoCutscene.resume', {''})

    if callMethodFromClass('flixel.FlxG', 'signals.focusLost.has', {instanceArg('videoCutscene.videoSprite.pause')}) then
        callMethodFromClass('flixel.FlxG', 'signals.focusLost.add', {instanceArg('videoCutscene.videoSprite.pause')})
    end
    if callMethodFromClass('flixel.FlxG', 'signals.focusGained.has', {instanceArg('videoCutscene.videoSprite.resume')}) then
        callMethodFromClass('flixel.FlxG', 'signals.focusGained.add', {instanceArg('videoCutscene.videoSprite.resume')})
    end
end