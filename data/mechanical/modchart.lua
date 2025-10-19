local strumLine1Visible = true

luaDebugMode = true

function onCreate()
    setProperty('camZoomingMult', 0)

    setVar('forceComboPos', {x = 80, y = 500})

    makeLuaSprite('purpleOverlay')
    makeGraphic('purpleOverlay', screenWidth, screenHeight, '800080')
    setProperty('purpleOverlay.alpha', 0)
    scaleObject('purpleOverlay', 1.5, 1.5, false)
    setScrollFactor('purpleOverlay', 0, 0)
end

function onCreatePost()
    addLuaSprite('purpleOverlay', true)
    startTween('purpie', 'purpleOverlay', {alpha = 0.33}, 2.6, {})
end

function onUpdate(elapsed)
    if curStep == 48 or curStep == 52 or curStep == 54 or curStep == 56 or curStep == 912 or curStep == 916 or curStep == 918 or curStep == 920 then
	--setCamZoom(0.73) NO BAD VORTMITE NO ADDING IT BACK
	setHudZoom(1.03)
    end

    if curStep >= 1 and curStep < 4 then
	local currentBeat = (getSongPosition() / 1000)*(curBpm/240)
	for i=4,7 do
	    setProperty('playerStrums.members['..(i%4)..'].x', _G['defaultPlayerStrumX'..(i%4)] + 1000 * math.sin((currentBeat + i*50) * math.pi))
	    for i=0,3 do
		setProperty('opponentStrums.members['..i..'].x', _G['defaultOpponentStrumX'..i] + 450 * math.sin((currentBeat + i*50) * math.pi))
	    end
	end
    end

    if curStep >= 60 and curStep < 66 then
	local currentBeat = (getSongPosition() / 1000)*(curBpm/120)
	for i=0,3 do
	    setProperty('opponentStrums.members['..i..'].x', _G['defaultOpponentStrumX'..i] + -500 * math.sin((currentBeat + i*50) * math.pi))
	end
    end

    if curStep == 66 then
	strumLine1Visible = false
    end

    if curStep >= 60 and curStep < 66 then
	local currentBeat = (getSongPosition() / 1000)*(curBpm/240)
	for i=4,7 do
	    setProperty('playerStrums.members['..(i%4)..'].x', _G['defaultPlayerStrumX'..(i%4)] + -838 * math.sin((currentBeat + i*50) * math.pi))
	end
    end

    if curStep == 128 then
	local currentBeat = (getSongPosition() / 1000)*(curBpm/30)
	for i=0, 7 do
	    local note = i > 3 and 'defaultPlayerStrum' or 'defaultOpponentStrum'
	    startTween('culol'..i, (i > 3 and 'playerStrums' or 'opponentStrums')..'.members['..(i%4)..']', {x = _G[note..'X'..(i%4)], y = _G[note..'Y'..(i%4)], angle = 0}, 0.1, {})
	    strumLine1Visible = true
	end
    end

    for i = 0, 3 do
	setProperty('strumLineNotes.members['..i..'].visible', strumLine1Visible)
    end
end

function onBeatHit()
    if curStep >= 48 and curStep < 384 or curStep >= 510 and curStep < 635 or curStep >= 766 and curStep < 894 or curStep >= 926 and curStep < 1278 or curStep >= 1282 and curStep < 1646 then
	--setCamZoom(0.73)
	setHudZoom(1.03)
    end

    if curStep >= 384 and curStep < 506 or curStep >= 638 and curStep < 762 or curStep >= 1646 and curStep < 1656 then
	--setCamZoom(0.71)
	setHudZoom(1.01)
    end

    if curStep >= 128 and curStep < 384 or curStep >= 512 and curStep < 624 or curStep >= 768 and curStep < 896 or curStep >= 928 and curStep < 1648 then
	local currentBeat = (getSongPosition() / 1000)*(curBpm/120)
	for i=0,7 do
	    local note = i > 3 and 'defaultPlayerStrum' or 'defaultOpponentStrum'
	    setProperty((i > 3 and 'playerStrums' or 'opponentStrums')..'.members['..(i%4)..'].x', _G[note..'X'..(i%4)] + 25 * math.sin((currentBeat + i*50) * math.pi))
	end
    end
end

function onStepHit()
    if curStep == 1390 then
	playAnim('gf', 'pull', true)
	setProperty('gf.specialAnim', true)
	setObjectOrder('gf', getObjectOrder('phands')+1)
	setProperty('phands.visible', false)
	setProperty('gf.idleSuffix', '-alt')
    end

    if curStep == 1380 then
	startTween('noMorePurp', 'purpleOverlay', {alpha = 0}, 1, {})
    end
end

function opponentNoteHit(id, noteData, noteType, isSustainNote)
    if noteType == 'Hey!' then
	setProperty('gf.holdTimer', 0)
	playAnim('gf', getProperty('singAnimations')[noteData+1]..'-alt', true)
    end
end

function onSpawnNote()
    for i = 0,3 do
	if getPropertyFromGroup('notes', i, 'noteType') == 'Hey!' then
	    setPropertyFromGroup('notes', i, 'noAnimation', true)
	end
    end
end

function setCamZoom(zoomAmount)
    setProperty('camGame.zoom', zoomAmount)
end

function setHudZoom(zoomAmount)
    setProperty('camHUD.zoom', zoomAmount)
end