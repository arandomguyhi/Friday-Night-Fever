luaDebugMode = true
function onCreate()
    initLuaShader('WiggleEffect')

    makeLuaSprite('purpleOverlay')
    makeGraphic('purpleOverlay', screenWidth, screenHeight, '800080')
    setProperty('purpleOverlay.alpha', 0.33)
    addLuaSprite('purpleOverlay')
    setObjectCamera('purpleOverlay', 'hud')
    scaleObject('purpleOverlay', 1.5, 1.5, false)
    setScrollFactor('purpleOverlay', 0, 0)

    makeLuaSprite('blackScreen')
    makeGraphic('blackScreen', screenWidth, screenHeight, '000000')
    setProperty('blackScreen.alpha', 0.001)
    setScrollFactor('blackScreen', 0, 0)
    scaleObject('blackScreen', 5, 5, false)
    addLuaSprite('blackScreen', true)

    for i = 1,4 do
	makeLuaSprite('t'..i, 'tranquility/'..i)
	setScrollFactor('t'..i, 0, 0)
	scaleObject('t'..i, 1 * (1 / getProperty('defaultCamZoom')), 1 * (1 / getProperty('defaultCamZoom')))
	setProperty('t'..i..'.antialiasing', true)
	screenCenter('t'..i, 'XY')
	addLuaSprite('t'..i, true)
	setProperty('t'..i..'.alpha', 0.000000009)
    end

    for _, i in pairs({'iconP1', 'iconP2', 'whittyBG', 'scoreTxt'}) do
	setSpriteShader(i, 'WiggleEffect')
	setShaderFloat(i, 'uWaveAmplitude', 0.0055)
	setShaderFloat(i, 'uFrequency', 7)
	setShaderFloat(i, 'uSpeed', 1.15)
    end
end

local test = 0
function onUpdate(elapsed)
    test = test + elapsed
    for _, i in pairs({'iconP1', 'iconP2', 'whittyBG', 'scoreTxt'}) do setShaderFloat(i, 'uTime', test) end

    if curStep >= 0 then
	local currentBeat = (getSongPosition() / 1000)*(curBpm/240)
	for i=0,7 do
	    local note = i > 3 and 'defaultPlayerStrum' or 'defaultOpponentStrum'
	    setProperty((i > 3 and 'playerStrums' or 'opponentStrums')..'.members['..(i%4)..'].x', _G[note..'X'..(i%4)] + 5 * math.sin((currentBeat + i*0.25) * math.pi))
	    setProperty((i > 3 and 'playerStrums' or 'opponentStrums')..'.members['..(i%4)..'].y', _G[note..'Y'..(i%4)] + 10 * math.cos((currentBeat + i*0.25) * math.pi))
	end
    end
end

function onBeatHit()
    if curBeat == 48 then
	startTween('camfoltwn', 'camFollow', {y = getProperty('camFollow.y') - 550}, 0.64, {})
	startTween('bacl', 'blackScreen', {alpha = 1}, 0.58, {onComplete = 'purpshit'})
	function purpshit()
	    setProperty('isCameraOnForcedPos', true)

	    startTween('prupe', 'purpleOverlay', {alpha = 0}, 0.1, {})
	    for _, i in pairs({'iconP1', 'iconP2', 'healthBar', 'healthBar.bg'}) do
		startTween('balcl'.._, i, {alpha = 0}, 0.46, {})end

	    local yAdd = downscroll and -200 or 200
	    startTween('diabeisso', 'scoreTxt', {y = getProperty('scoreTxt.y') + (downscroll and yAdd / 3.3 or 0), alpha = 0.7}, 0.4, {startDelay = 0.46})

	    for i = 0, 7 do
		startTween('alphie'..i, 'strumLineNotes.members['..i..']', {alpha = i > 3 and 0.6 or 0}, 0.6, {})
	    end
	end
    elseif curBeat == 50 then
        setVar('forceComboPos', {x = getProperty('strumLineNotes.members[4].x') - 200, y = getProperty('strumLineNotes.members[4].y')})
	doTweenAlpha('t1', 't1', 1, 0.7)
    elseif curBeat == 59 then
	doTweenAlpha('t1out', 't1', 0, 0.7)
    elseif curBeat == 62 then
	doTweenAlpha('t2', 't2', 1, 0.7)
    elseif curBeat == 71 then
	doTweenAlpha('t2out', 't2', 0, 0.7)
    elseif curBeat == 75 then
	doTweenAlpha('t3', 't3', 1, 0.7)
    elseif curBeat == 83 then
	doTweenAlpha('t3out', 't3', 0, 0.7)
    elseif curBeat == 87 then
	doTweenAlpha('t4', 't4', 1, 0.7)
    elseif curBeat == 94 then
	doTweenAlpha('t4out', 't4', 0, 0.7)
    elseif curBeat == 96 then
	doTweenAlpha('nbacl', 'blackScreen', 0, 1.5)
	doTweenAlpha('prupr', 'purpleOverlay', 0.33, 0.7)
	setProperty('isCameraOnForcedPos', false)
    elseif curBeat == 97 then
        setVar('forceComboPos', nil)
	local yAdd = downscroll and -200 or 200
	startTween('diabeissodnv', 'scoreTxt', {y = getProperty('scoreTxt.y') - (downscroll and yAdd / 3.3 or 0), alpha = 1}, 0.4, {startDelay = 0.46, onComplete = 'completo'})
	function completo()
	    for _, i in pairs({'iconP1', 'iconP2', 'healthBar', 'healthBar.bg'}) do
		startTween('balcl'.._, i, {alpha = 1}, 0.46, {})end

	    for i = 0, 7 do
		startTween('alphie'..i, 'strumLineNotes.members['..i..']', {alpha = 1}, 0.6, {})
	    end
	end
    end
end