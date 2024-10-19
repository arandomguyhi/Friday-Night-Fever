function onCreate()
    makeLuaSprite('spookyBG', 'stages/week2/images/spooky', -200, -100)
    setProperty('spookyBG.antialiasing', true)

    makeLuaSprite('city', 'stages/week2/images/city', -290, -180)
    setProperty('city.antialiasing', true)
    setScrollFactor('city', 0.8, 0.8)

    addLuaSprite('city')
    addLuaSprite('spookyBG')
end

function onCreatePost()
    if songName:lower() == 'star-baby' then
	scaleObject('dad', 0.77, 0.77, false) end
    setScrollFactor('gf', 1, 1)
end

function onBeatHit()
    if songName:lower() == 'star-baby' then
	if curBeat == 128 then
	    setProperty('defaultCamZoom', getProperty('defaultCamZoom') + 0.17)
	    doTweenColor('bgcol', 'spookyBG', '828282', 0.45)
	    doTweenColor('gfcol', 'gf', '828282', 0.45)
	    setVar('useDirectionalCamera', true)
	elseif curBeat == 192 then
	    setProperty('defaultCamZoom', getProperty('defaultCamZoom') - 0.17)
	    doTweenColor('bgcol', 'spookyBG', 'FFFFFF', 0.45)
	    doTweenColor('gfcol', 'gf', 'FFFFFF', 0.45)
	    setVar('useDirectionalCamera', false)
	end

	if curBeat % 2 == 0 and curBeat > 128 and curBeat < 192 then
	    setProperty('camGame.zoom', getProperty('camGame.zoom') + 0.015)
	    setProperty('camHUD.zoom', getProperty('camHUD.zoom') + 0.03)
	end
    end
end