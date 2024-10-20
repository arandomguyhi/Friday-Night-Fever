function onCreate()
    setProperty('camZooming', true)
    setProperty('camZoomingMult', 0)
    setProperty('defaultCamZoom', 0.6)

    setProperty('bop.x', getProperty('bop.x') + 50)
    setProperty('bop.y', getProperty('bop.y') + 30)
    setProperty('camHUD.visible', false)

    makeLuaSprite('pixelDiner', 'stages/week5/yukichi-pixel', -950, -200)
    setProperty('pixelDiner.antialiasing', true)
    setScrollFactor('pixelDiner', 0.9, 0.9)
    setProperty('pixelDiner.antialiasing', false)
    addLuaSprite('pixelDiner')
    setProperty('pixelDiner.origin.x', 0) setProperty('pixelDiner.origin.y', 0)
    scaleObject('pixelDiner', 6, 6, false)
    setProperty('pixelDiner.visible', false)

    makeAnimatedLuaSprite('leoPixel', 'stages/week5/leo-pixel', getProperty('leo.x') + 170, getProperty('leo.y') + 150)
    addAnimationByPrefix('leoPixel', 'bop', 'borger', 24, false)
    setScrollFactor('leoPixel', 0.9, 0.9)
    scaleObject('leoPixel', 6, 6, false)
    setProperty('leoPixel.visible', false)
    addLuaSprite('leoPixel')

    createInstance('pepper', 'objects.Character', {getProperty('gf.x') - 90, getProperty('gf.y') - 25, 'pepper-worried'})
    setScrollFactor('pepper', 0.9, 0.9)
    setObjectOrder('pepper', getObjectOrder('dadGroup'))
    addLuaSprite('pepper')

    createInstance('yukichi_pixel', 'objects.Character', {0, 0, 'yukichi-pixel'})
    createInstance('tea_pixel', 'objects.Character', {0, 0, 'gf-pepper-pixel'})
    createInstance('fever_pixel', 'objects.Character', {0, 0, 'bf-pixeldemon', true})
    setScrollFactor('tea_pixel', 0.9, 0.9)
    setScrollFactor('fever_pixel', 0.9, 0.9)
    setScrollFactor('yukichi_pixel', 0.9, 0.9)
    callMethod('tea_pixel.setPosition', {getProperty('gf.x') + 300, getProperty('gf.y') + 220})
    callMethod('fever_pixel.setPosition', {getProperty('boyfriend.x') + 150, getProperty('boyfriend.y') + 37})
    callMethod('yukichi_pixel.setPosition', {getProperty('dad.x') + 190, getProperty('dad.y') + 190})
    setProperty('tea_pixel.visible', false)
    setProperty('fever_pixel.visible', false)
    setProperty('yukichi_pixel.visible', false)

    addInstance('tea_pixel')
    addInstance('yukichi_pixel')
    addInstance('fever_pixel')

    makeAnimatedLuaSprite('pixelCrowd', 'stages/week5/crowd-pixel', getProperty('bop.x') + 900, getProperty('bop.y') + 400)
    addAnimationByPrefix('pixelCrowd', 'bop', 'people', 24, false)
    scaleObject('pixelCrowd', 6, 6, false)
    setProperty('pixelCrowd.visible', false)
    addLuaSprite('pixelCrowd')

    scaleObject('bop', 1.2, 1.2, false)
end

function onCreatePost()
    initLuaShader('CRTBend')
    initLuaShader('Scanline')
    initLuaShader('ChromaticAberration')

    setProperty('dad.x', getProperty('dad.x')  - 70)
    setProperty('boyfriend.x', getProperty('boyfriend.x') + 70)
end

function onBeatHit()
    if curBeat == 32 then
	setProperty('camHUD.visible', true)
    elseif curBeat == 95 then
	cameraShake('camGame', 0.09, crochet / 1000)
	cameraShake('camHUD', 0.09, crochet / 1000)
    elseif curBeat == 96 then
	setPropertyFromClass('states.PlayState', 'stageUI', 'pixel')
	for i = 0,getProperty('unspawnNotes.length')-1 do
	    callMethod('unspawnNotes['..i..'].reloadNote', {''}) end
	for i = 0, 7 do
	    callMethod('strumLineNotes.members['..i..'].reloadNote', {''}) end

	setTextFont('scoreTxt', 'pixel.otf')

	setProperty('fever_pixel.visible', true)
	setProperty('tea_pixel.visible', true)
	setProperty('yukichi_pixel.visible', true)
	setProperty('pixelDiner.visible', true)
	setProperty('pixelCrowd.visible', true)
	setProperty('leoPixel.visible', true)

	for _, i in pairs({'dad', 'gf', 'boyfriend', 'pepper'}) do
	    setProperty(i..'.alpha', 0.001) end

	runHaxeCode([[
	    var sl = game.createRuntimeShader('Scanline');
	    var ch = game.createRuntimeShader('ChromaticAberration');

	    ch.setFloat('rOffset', FlxG.random.int(2, 2) / 1500);
	    ch.setFloat('gOffset', 0.0);
	    ch.setFloat('bOffset', FlxG.random.int(2, 2) / 1500 * -1);

	    camGame.filters = [new ShaderFilter(sl), new ShaderFilter(ch)];
	    camHUD.filters = [new ShaderFilter(sl), new ShaderFilter(ch)];
	]])

	callMethod('iconP1.changeIcon', {'bf-pixeldemon'})
	callMethod('iconP2.changeIcon', {'yukichi-pixel'})
	callScript('scripts/FeverHUD', 'loadIcons', {})

	setProperty('bop.visible', false)
    elseif curBeat == 159 then
	cameraShake('camGame', 0.09, crochet / 1000)
	cameraShake('camHUD', 0.09, crochet / 1000)
    elseif curBeat == 160 then
	setPropertyFromClass('states.PlayState', 'stageUI', '')
	for i = 0,getProperty('unspawnNotes.length')-1 do
	    callMethod('unspawnNotes['..i..'].reloadNote', {''}) end
	for i = 0, 7 do
	    callMethod('strumLineNotes.members['..i..'].reloadNote', {''}) end

	setTextFont('scoreTxt', 'vcr.ttf')

	setProperty('fever_pixel.visible', false)
	setProperty('tea_pixel.visible', false)
	setProperty('pixelDiner.visible', false)
	setProperty('yukichi_pixel.visible', false)
	setProperty('pixelCrowd.visible', false)
	setProperty('leoPixel.visible', false)

	for _, i in pairs({'dad', 'gf', 'boyfriend', 'pepper'}) do
	    setProperty(i..'.alpha', 1) end

	runHaxeCode([[
	    camGame.setFilters([]);
	    camHUD.setFilters([]);
	]])

	callMethod('iconP1.changeIcon', {'bf-demon'})
	callMethod('iconP2.changeIcon', {'yukichi'})
	callScript('scripts/FeverHUD', 'loadIcons', {})

	setProperty('bop.visible', true)
    end

    if curBeat % 2 == 0 and getProperty('camZooming') and not getProperty('fever_pixel.visible') then
	setProperty('camHUD.zoom', getProperty('camHUD.zoom') + 0.02)
    end

    callMethod('tea_pixel.dance', {''})
    callMethod('pepper.dance', {''})
    playAnim('pixelCrowd', 'bop')
    playAnim('leoPixel', 'bop')
    if getProperty('boyfriend.animation.curAnim.name') == 'idle' then callMethod('fever_pixel.dance', {''}) end
    if getProperty('yukichi_pixel.animation.curAnim.name') == 'idle' and curBeat % 2 == 0 then callMethod('yukichi_pixel.dance', {''}) end
end

function opponentNoteHit(id, noteData, noteType, isSustainNote)
    if getProperty('yukichi_pixel.visible') then
	setProperty('yukichi_pixel.holdTimer', 0)
	playAnim('yukichi_pixel', getProperty('singAnimations')[noteData+1], true)
    end
end

function goodNoteHit(id, noteData, noteType, isSustainNote)
    if getProperty('fever_pixel.visible') then
	setProperty('fever_pixel.holdTimer', 0)
	playAnim('fever_pixel', getProperty('singAnimations')[noteData+1], true)
    end
end