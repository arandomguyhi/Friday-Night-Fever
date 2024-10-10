local BLACK_BAR_HEIGHT = 115
local prevScore = ''
local prevHealth = 1
local prevTime = 0

luaDebugMode = true
function onCreate()
    initLuaShader('BWShader')
    initLuaShader('ScreenMultiply')

    makeAnimatedLuaSprite('clap', 'characters/scarlet/Scarlet_Final_Clap', getProperty('dad.x') - 270, getProperty('dad.y') - 50)
    addAnimationByPrefix('clap', 'clap', 'Final scarlet slap', 24, false)
    setProperty('clap.antialiasing', true)
    addLuaSprite('clap')
    setProperty('clap.alpha', 0.001)

    makeLuaSprite('spr')
    makeGraphic('spr', 1280, BLACK_BAR_HEIGHT, '000000')
    setObjectCamera('spr', 'hud')
    addLuaSprite('spr')
    setProperty('spr.visible', false)

    makeLuaSprite('spr2', nil, 0, screenHeight - BLACK_BAR_HEIGHT)
    makeGraphic('spr2', 1280, BLACK_BAR_HEIGHT, '000000')
    setObjectCamera('spr2', 'hud')
    addLuaSprite('spr2')
    setProperty('spr2.visible', false)

    for _, bgElements in pairs({'clocks', 'clockScar', 'clockFever'}) do
	setScrollFactor(bgElements, 0.9, 0.9)
    end

    setSpriteShader('whittyBG', 'BWShader')
    setShaderFloat('whittyBG', 'u_colorFactor', 0)

    runHaxeCode([[
	var screen = game.createRuntimeShader('ScreenMultiply');
	screen.setFloat('screens', 1);
	var sc = new ShaderFilter(screen);
	camGame.setFilters([sc]);
	camHUD.setFilters([sc]);
	setVar('screen', screen);
    ]])
end

function onCreatePost()
    setProperty('gf.visible', false)
    setScrollFactor('dad', 0.9, 0.9)
end

local prevDad = true

function onSectionHit()
    if curBeat >= 191 and curBeat < 256 then
	if not mustHitSection then
	    setProperty('dad.visible', true)
	    prevDad = true
	    setProperty('camFollow.x', getVar('dadCamX') - 70) setProperty('camGame.scroll.x', getVar('dadCamX') - 70 - (screenWidth/2))
	    setProperty('camFollow.y', getVar('dadCamY') - 70) setProperty('camGame.scroll.y', getVar('dadCamY') - 70 - (screenHeight/2))
	else
	    if prevDad then
		runHaxeCode("getVar('screen').setFloat('screens', getVar('screen').getFloat('screens') + 1);")

		prevDad = false
		setProperty('camFollow.x', getVar('bfCamX') + 70) setProperty('camGame.scroll.x', getVar('bfCamX') + 70 - (screenWidth/2))
		setProperty('camFollow.y', getVar('bfCamY') + 165) setProperty('camGame.scroll.y', getVar('bfCamY') + 165 - (screenHeight/2))
		setProperty('dad.visible', false)
	    end
	end
    end
end

local fireOnce = false
setVar('BWValue', 0)
function onUpdate()
    if curBeat == 191 then
	if curBeat >= 255 then return end
	for _, bgElements in pairs({'clocks', 'clockScar', 'clockFever'}) do
	    setShaderFloat(bgElements, 'u_colorFactor', getVar('BWValue'))
	end
    end
end

function onUpdatePost(elapsed)
    if curBeat >= 192 and curBeat <= 255 then
	scaleObject('iconP1', 1, 1)
	scaleObject('iconP2', 1, 1)
	scaleObject('scoreTxt', 1, 1)
	setTextString('scoreTxt', prevScore)
	setProperty('health', prevHealth)
	setProperty('scoreTxt.x', (screenWidth / 2) - (getProperty('scoreTxt.width') / 2))
    elseif curBeat == 256 and not fireOnce then
	fireOnce = true
    end
end

function onBeatHit()
    if curBeat < 192 and curBeat > 256 then
	if curBeat >= 64 and curBeat < 128 then
	    setProperty('camGame.zoom', getProperty('camGame.zoom') + 0.04)
	elseif curBeat % 4 == 0 then
	    setProperty('camGame.zoom', getProperty('camGame.zoom') + 0.012)
	end
    end

    if curBeat == 191 then
	for _, bgElements in pairs({'clocks', 'clockScar', 'clockFever'}) do
	    setSpriteShader(bgElements, 'BWShader')
	end

	runHaxeCode([[
	    FlxTween.num(getVar('BWValue'), 1, Conductor.crochet / 1000, {onUpdate: (t) -> { setVar('BWValue', t); }}, (v) -> {
		setVar('BWValue', v);
	    });
	]])
    end

    if curBeat == 192 then
	setProperty('defaultCamZoom', getProperty('defaultCamZoom') - 0.2)
	setProperty('clap.alpha', 0.001)
	setProperty('dad.visible', true)

	setProperty('spr.visible', true)
	setProperty('spr2.visible', true)
	setProperty('defaultCamZoom', getProperty('defaultCamZoom') + 0.35)
	setProperty('camGame.zoom', getProperty('defaultCamZoom'))

	for i = 0,3 do
	    setProperty('strumLineNotes.members['..i..'].alpha', 0.43)end

	prevScore = getProperty('scoreTxt.text')
	prevHealth = getProperty('health')
    elseif curBeat == 256 then
	runHaxeCode("getVar('screen').setFloat('screens', 1);")
	doTweenY('bzal', 'spr', -BLACK_BAR_HEIGHT, 0.24)
	doTweenY('balx', 'spr2', screenHeight, 0.24)
	setProperty('defaultCamZoom', getProperty('defaultCamZoom') - 0.35)

	setProperty('camFollow.x', getVar('dadCamX') - 70) setProperty('camGame.scroll.x', getVar('dadCamX') - 70 - (screenWidth/2))
	setProperty('camFollow.y', getVar('dadCamY') - 70) setProperty('camGame.scroll.y', getVar('dadCamY') - 70 - (screenHeight/2))
	setProperty('dad.visible', true)
	setProperty('isCameraOnForcedPos', false)

	for i = 0,3 do
	    setProperty('strumLineNotes.members['..i..'].alpha', 1)end

	for _, bgElements in pairs({'clocks', 'clockScar', 'clockFever'}) do
	    removeSpriteShader(bgElements)
	end
	setSpriteShader('clocks', 'WiggleEffect')
    end
end

function onStepHit()
    if curStep == 762 then
	setProperty('clap.alpha', 1)
	setProperty('dad.visible', false)
	setProperty('isCameraOnForcedPos', true)
	setProperty('camFollow.x', getProperty('camFollow.x') - 250)
	setProperty('defaultCamZoom', getProperty('defaultCamZoom') + 0.2)

	playAnim('clap', 'clap')
    end
end

function goodNoteHit()
    if curBeat >= 192 and curBeat <= 255 then
	setProperty('health', prevHealth)
    end
end