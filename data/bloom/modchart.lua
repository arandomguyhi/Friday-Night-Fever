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
    setProperty('clap.visible', false)

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

function onMoveCamera(focus)
    if curBeat >= 191 and curBeat < 256 then
	setProperty('dad.visible', true)

	if focus == 'dad' then
	    prevDad = true
	    --snapCamera(new FlxPoint(DAD_CAM_POS.x - 70, DAD_CAM_POS.y - 70));
	else
	    if prevDad then
		runHaxeCode("getVar('screen').setFloat('screens', getVar('screen').getFloat('screens') + 1);")

		prevDad = false
		--snapCamera(new FlxPoint(BF_CAM_POS.x + 70, BF_CAM_POS.y + 165));
		setProperty('dad.visible', false)
	    end
	end
    end
end

local fireOnce = false
setVar('BWValue', 0)
function onUpdatePost(elapsed)
    if curBeat >= 192 and curBeat <= 255 then
	scaleObject('iconP1', 1, 1, false)
	scaleObject('iconP2', 1, 1, false)
	scaleObject('scoreTxt', 1, 1, false)
	setTextString('scoreTxt', prevScore)
	setProperty('health', prevHealth)
	setProperty('scoreTxt.x', (screenWidth / 2) - (getProperty('scoreTxt.width') / 2))
    elseif curBeat == 256 and not fireOnce then
	fireOnce = true
    end

    if curBeat == 191 then
	for _, bgElements in pairs({'clocks', 'clockScar', 'clockFever'}) do
	    setShaderFloat(bgElements, 'u_colorFactor', getVar('BWValue'))
	end
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
	setProperty('clap.visible', false)
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

	runHaxeCode("game.getLuaObject('whittyBG').shader = null;")

	for i = 0,3 do
	    setProperty('strumLineNotes.members['..i..'].alpha', 0.43)end

	for _, bgElements in pairs({'clocks', 'clockScar', 'clockFever'}) do
	    runHaxeCode("game.getLuaObject('"..bgElements.."').shader = null;")
	end
    end
end

--[[
function onStepHit(curStep:Int)
{
	if (curStep == 762)
	{
		clap.visible = true;
		dad.visible = false;
		game.disableCamera = true;
		camFollow.x -= 250;
		game.defaultCamZoom += 0.2;

		clap.animation.play("clap");
	}
}

function onPlayerNoteHit(note)
{
	if (curBeat >= 192 && curBeat <= 255)
		game.health = prevHealth;
}
]]