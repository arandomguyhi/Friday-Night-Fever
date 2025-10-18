setProperty('dad.idleSuffix', '-mad')

function onCreate()
    initLuaShader('ChromaticAberration')
    addCharacterToList('scarlet-final', 'dad')

    mustHitSection = true
end

function onCreatePost()
    setProperty('dad.idleSuffix', '-mad')
end

function onBeatHit()
    if curBeat > 202 and curBeat % 4 == 0 then
	setProperty('camZooming', true)
	setProperty('camHUD.zoom', getProperty('camHUD.zoom') + 0.025)
    end

    if curBeat == 202 then
	runHaxeCode([[
	    var chrabrr = game.createRuntimeShader('ChromaticAberration');
	    chrabrr.setFloat('rOffset', 0);
	    chrabrr.setFloat('bOffset', 0);
	    camGame.setFilters([new ShaderFilter(chrabrr)]);
	    setVar('chrabrr', chrabrr);
	]])

	playAnim('dad', 'transform', true) setProperty('dad.specialAnim', true)
	setProperty('isCameraOnForcedPos', true)
	setCameraTarget('dad')
	startTween('zoomin', 'camGame', {zoom = 0.9}, (crochet / 1000) * 5, {})
    end

    if curBeat == 205 then
	cameraShake('camGame', 0.009, (crochet / 1000) * 2.5)
	runHaxeCode([[
	    FlxTween.num(0, 0.0095, (Conductor.crochet / 1000) * 2.5, {onUpdate: (t) -> { getVar('chrabrr').setFloat('rOffset', t); }}, (v) -> {
		getVar('chrabrr').setFloat('rOffset', v);
	    });
	    FlxTween.num(0, -0.0095, (Conductor.crochet / 1000) * 2.5, {onUpdate: (t) -> { getVar('chrabrr').setFloat('bOffset', t); }}, (v) -> {
		getVar('chrabrr').setFloat('bOffset', v);
	    });
	]])
    end

    if curBeat == 207 then
	runHaxeCode("camGame.setFilters([]);")
	setProperty('isCameraOnForcedPos', false)

	triggerEvent('Change Character', 'dad', 'scarlet-final')
	setCameraTarget('dad')
    end

    if curBeat == 288 then
        setVar('useDirectionalCamera', true)
    end
end

function onStepHit()
    if curStep == 828 then
	cameraFlash('camGame', 'FFFFFF', 1.4)
    end
end

function onUpdate(elapsed)
    if curBeat <= 207 then
        local cB = (getSongPosition() / 1000) * (curBpm / 60)
        setProperty('scarlet.y', (getProperty('dad.y') + 475) + (11 + math.cos((cB / 5) * math.pi)))
    end
end