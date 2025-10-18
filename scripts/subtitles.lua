if not checkFileExists('data/'..songPath..'/subtitles.json') then return end

luaDebugMode = true
function onCreatePost()
    makeLuaSprite('textBG') makeGraphic('textBG', 10, 10, '000000')
    setProperty('textBG.origin.y', 0)
    setProperty('textBG.y', screenHeight * 0.68)
    setObjectCamera('textBG', 'camHUD')
    addLuaSprite('textBG')

    makeLuaText('textSub')
    setTextFont('textSub', 'vcr.ttf')
    setTextSize('textSub', 28)
    setTextBorder('textSub', 1.4, '000000', 'outline_fast')
    setProperty('textSub.y', screenHeight * 0.68) 
    setProperty('textSub.antialiasing', true)
    setProperty('textSub.alpha', 0)
    addLuaText('textSub')
end

local array = callMethodFromClass('tjson.TJSON', 'parse', {getTextFromFile('data/'..songName..'/subtitles.json')})
function onStepHit()
    if array[1] ~= nil then
	if array[1].startStep == curStep then
	    setTextString('textSub', array[1].text)
	    screenCenter('textSub', 'X')

	    screenCenter('textBG', 'X')
	    scaleObject('textBG', (getProperty('textSub.width') / getProperty('textBG.width')) * 1.03, getProperty('textSub.height') / getProperty('textBG.height'), false)

	    startTween('bgtween', 'textBG', {alpha = 0.6}, 0.32, {type = 'oneshot'})
	    startTween('textwenn', 'textSub', {alpha = 1}, 0.32, {type = 'oneshot'})
	end

	if array[1].endStep == curStep then
	    if array[2] == nil or curStep + 6 < array[2].startStep then
		for _, i in ipairs({'textSub', 'textBG'}) do
		    startTween('endsteptween'.._, i, {alpha = 0}, 0.32, {type = 'oneshot'}) end
	    end
	    table.remove(array, 1)
	end
    end
end