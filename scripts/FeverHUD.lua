local ranking = 'N/A'
local wifeConditions = {
    {'AAAAA', 0.999935},
    {'AAAA:', 0.99980},
    {'AAAA.', 0.99970},
    {'AAAA', 0.99955},
    {'AAA:', 0.9990},
    {'AAA.', 0.9980},
    {'AAA', 0.9970},
    {'AA:', 0.99},
    {'AA.', 0.9650},
    {'AA', 0.93},
    {'A:', 0.9},
    {'A.', 0.85},
    {'A', 0.8},
    {'B', 0.7},
    {'C', 0.6},
    {'D', 0.5999}
}
local wife = ''

luaDebugMode = true
function onCreate()
    setProperty('healthGain', 0)
end

function onCreatePost()
    setProperty('comboGroup.visible', false)

    setProperty('timeBar.visible', false)
    setProperty('timeTxt.visible', false)
    setTextFont('scoreTxt', 'vcr.ttf')

    loadGraphic('iconP1', 'icons/icon-'..getProperty('boyfriend.healthIcon'), 150, 150)
    addAnimation('iconP1', 'idle', {0, 1, 2}, 0, false)
    setProperty('iconP1.flipX', true)

    loadGraphic('iconP2', 'icons/icon-'..getProperty('dad.healthIcon'), 150, 150)
    addAnimation('iconP2', 'idle', {0, 1, 2}, 0, false)

    setProperty('iconP1.iconOffsets[0]', getProperty('iconP1.iconOffsets[0]') - 45)
    setProperty('iconP2.iconOffsets[0]', getProperty('iconP2.iconOffsets[0]') - 45)
end

function onUpdate(elapsed)
    -- not part of the hud, just some global vars
    dadCamX = runHaxeCode("return dad.getMidpoint().x + 150 + dad.cameraPosition[0] + opponentCameraOffset[0];") -- doing with rhc cuz im lazy
    dadCamY = runHaxeCode("return dad.getMidpoint().y - 100 + dad.cameraPosition[1] + opponentCameraOffset[1];")
    bfCamX = runHaxeCode("return boyfriend.getMidpoint().x - 100 - boyfriend.cameraPosition[0] + boyfriendCameraOffset[0];")
    bfCamY = runHaxeCode("return boyfriend.getMidpoint().y - 100 + boyfriend.cameraPosition[1] + boyfriendCameraOffset[1];")
    gfCamX = runHaxeCode("return gf.getMidpoint().x + gf.cameraPosition[0] + girlfriendCameraOffset[0];")
    gfCamY = runHaxeCode("return gf.getMidpoint().y + gf.cameraPosition[1] + girlfriendCameraOffset[1];")

    setVar('dadCamX', dadCamX) setVar('dadCamY', dadCamY) setVar('bfCamX', bfCamX) setVar('bfCamY', bfCamY) setVar('gfCamX', gfCamX) setVar('gfCamY', gfCamY)
end

function onUpdatePost()
    if dadName ~= 'taki' then
	if getHealth() > 1.6 then
	    setProperty('iconP1.animation.curAnim.curFrame', 2)
	elseif getHealth() < 0.4 then
	    setProperty('iconP2.animation.curAnim.curFrame', 2)
	end
    end

    setTextSize('scoreTxt', 18)

    for _, ratin in ipairs(wifeConditions) do
	if getProperty('ratingPercent') >= ratin[2] then
	    wife = ratin[1]
	    break
	end
    end

    local sicks = getProperty('ratingsData[0].hits')
    local goods = getProperty('ratingsData[1].hits')
    local bads = getProperty('ratingsData[2].hits')
    local shits = getProperty('ratingsData[3].hits')

    if misses == 0 and bads == 0 and shits == 0 and goods == 0 then
	ranking = '(SFC)'
    elseif misses == 0 and bads == 0 and shits == 0 and goods >= 1 then
	ranking = '(GFC)'
    elseif misses == 0 then
	ranking = '(FC)'
    elseif misses < 10 then
	ranking = '(SCDB)'
    else
	ranking = ''
    end

    if songName == 'Bad-Nun' and getVar('translate') then
	setTextString('scoreTxt', 'スコア: '..score..' | 見逃した: '..misses..' | 正確さ: '..math.floor(getProperty('ratingPercent') * 10000) * 0.01 .. '% • '..ranking..' '..wife)
    else
	setTextString('scoreTxt', 'Score: '..score..' | Misses: '..misses..' | Accuracy: '..math.floor(getProperty('ratingPercent') * 10000) * 0.01 .. '% • '..ranking..' '..wife)
    end
end

function goodNoteHit(id, noteData, noteType, isSustainNote)
    local rating_name = getPropertyFromGroup('notes', id, 'rating')

    if rating_name == 'shit' then
	setProperty('health', getProperty('health') - 0.2)
	misses = misses + 1
    elseif rating_name == 'bad' then
	setProperty('health', getProperty('health') - 0.06)
    elseif rating_name == 'good' then
	setProperty('health', getProperty('health') + 0.02)
    elseif rating_name == 'sick' then
	setProperty('health', getProperty('health') + 0.04)
    end

    if not isSustainNote then
	setVar('ratin', rating_name)
	popUpScore()
    end
end

local cb = 1
function popUpScore()
    local pixel = getPropertyFromClass('states.PlayState', 'isPixelStage')

    -- COMBO RATING SHIT
    makeAnimatedLuaSprite('comboRating'..cb, 'combo/ratings'..(pixel and '-pixel' or ''))
    for _, i in pairs({'sick', 'good', 'bad', 'shit'}) do
	addAnimationByPrefix('comboRating'..cb, i, i, 0, false)
    end
    playAnim('comboRating'..cb, getVar('ratin'))
    if pixel then
	local daPixelZoom = getPropertyFromClass('states.PlayState', 'daPixelZoom')
	setGraphicSize('comboRating'..cb, getProperty('comboRating'..cb..'.width') * daPixelZoom * 0.7, getProperty('comboRating'..cb..'.height') * daPixelZoom * 0.7)
    else
	setGraphicSize('comboRating'..cb, getProperty('comboRating'..cb..'.width') * 0.49, getProperty('comboRating'..cb..'.height') * 0.49)
    end
    setProperty('comboRating'..cb..'.velocity.x', -getRandomInt(0, 10)) setProperty('comboRating'..cb..'.velocity.y', -getRandomInt(140, 175))
    setProperty('comboRating'..cb..'.acceleration.y', 550)
    setProperty('comboRating'..cb..'.x', (screenWidth / 2) - (getProperty('comboRating'..cb..'.width') / 2))
    setProperty('comboRating'..cb..'.y', (screenHeight * 0.5) - (getProperty('comboRating'..cb..'.height') / 2) + 100)
    setObjectCamera('comboRating'..cb, 'hud')
    addLuaSprite('comboRating'..cb)

    -- COMBO NUM SHIT
    if combo >= 10 or combo == 0 then
	local index = 0
	local seperatedScore = stringSplit(combo, '')

	if #seperatedScore == 2 then
	    table.insert(seperatedScore, 1, '0')end

	for v,f in ipairs(seperatedScore) do
	    makeAnimatedLuaSprite('numScore'..v, 'combo/numbers'..(pixel and '-pixel' or ''))
	    for i = 0,9 do addAnimationByPrefix('numScore'..v, i, 'num'..i, 0, false)end
	    playAnim('numScore'..v, f)
	    if pixel then
		local daPixelZoom = getPropertyFromClass('states.PlayState', 'daPixelZoom')
		setGraphicSize('numScore'..v, getProperty('numScore'..v..'.width') * daPixelZoom, getProperty('numScore'..v..'.height') * daPixelZoom, false)
	    else
		setGraphicSize('numScore'..v, getProperty('numScore'..v..'.width') * 0.5, getProperty('numScore'..v..'.height') * 0.5, false)
	    end
	    setProperty('numScore'..v..'.acceleration.y', getRandomInt(200, 300))
	    setProperty('numScore'..v..'.velocity.y', -getRandomInt(140, 160))
	    setProperty('numScore'..v..'.velocity.x', getRandomFloat(-5, 5))
	    setProperty('numScore'..v..'.x', getProperty('comboRating'..cb..'.x') + (33 * index) - 8)
	    setProperty('numScore'..v..'.y', getProperty('comboRating'..cb..'.y') + 100 + (pixel and 30 or 0))
	    setObjectCamera('numScore'..v, 'hud')
	    addLuaSprite('numScore'..v)

	    setVar('maisquemerda', v) -- morre
	    startTween('numTween'..v, 'numScore'..v, {alpha = 0}, 0.2, {startDelay = 0.3, onComplete = 'killnum'})
	    function killnum()
		for v = 1, getVar('maisquemerda') do
		    callMethod('numScore'..v..'.kill', {''})
		end
	    end

	    index = index + 1
	end
    end

    setVar('buceta', cb)
    startTween('ratinTween'..cb, 'comboRating'..cb, {alpha = 0}, 0.45, {startDelay = 0.27, onComplete = 'killrating'})
    function killrating()
	for i = 1, getVar('buceta') do
	    callMethod('comboRating'..cb..'.kill', {''})
	    cb = cb - 1
	end
    end

    cb = cb + 1
end