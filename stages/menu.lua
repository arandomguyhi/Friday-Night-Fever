local firstTime = true
local selectedSomethin = false
local hitboxes = {}
local callbacks = {}

-- Brochure menu
local selectingFrenzy = true
local brochures = {}

luaDebugMode = true
function onCreate()
    setProperty('skipCountdown', true)
    setProperty('camGame.visible', false)
    setProperty('camHUD.visible', false) -- i don't need these cams for now
end

function onCreatePost()
    playMusic('freakyMenu', 1, true)
end

function onSongStart()
    openCustomSubstate('Main Menu')
end

function onPause() return Function_Stop end

function onCustomSubstateCreate(name)
    if name == 'Main Menu' then
	makeLuaSprite('tunnelBG', 'newMain/subway_bg_2', 0, -12)
	setObjectCamera('tunnelBG', 'other')
	addLuaSprite('tunnelBG')

	makeAnimatedLuaSprite('train', 'newMain/trainmenu', 255, 140)
	addAnimationByPrefix('train', 'come', 'Train come', 24, false)
	addAnimationByPrefix('train', 'idle', 'Train notselected', 24, true)
	addAnimationByPrefix('train', 'selected', 'Train selected', 24, false)
	addOffset('train', 'idle', 0, 0)
	addOffset('train', 'selected', 0, 42)
	playAnim('train', 'idle')
	scaleObject('train', 1.32, 1.32, false)
	setObjectCamera('train', 'other')
	addLuaSprite('train')
	createHitbox('trainhit', 480, 205, 165, 280, function()
	    closeCustomSubstate('Main Menu')
	    runTimer('cu', 1)
	    function onTimerCompleted(tag) if tag == 'cu' then openCustomSubstate('Brochure Menu')end end
	end)

	makeLuaSprite('mainBG', 'newMain/subway_bg', 0, -12)
	setObjectCamera('mainBG', 'other')
	addLuaSprite('mainBG')

	makeAnimatedLuaSprite('options', 'newMain/options', 915.5, 580.55)
	addAnimationByPrefix('options', 'idle', 'options notselected', 24, true)
	addAnimationByPrefix('options', 'selected', 'options selected', 24, false)
	addOffset('options', 'idle', 0, 0)
	addOffset('options', 'selected', 0, 34)
	playAnim('options', 'idle')
	setObjectCamera('options', 'other')
	addLuaSprite('options')
	createHitbox('optionshit', 915.5, 580.55, 365, 105, function()
	    startTween('zoomOption', 'camOther', {y = -60}, 2, {})
	    cameraFade('camOther', '000000', 0.5, false)
	    runTimer('switchToOptions', 0.5)
	    function onTimerCompleted(tag)
		if tag == 'switchToOptions' then debugPrint('switched') end
	    end
	end)

	makeAnimatedLuaSprite('credits', 'newMain/credits', -10, 45)
	addAnimationByPrefix('credits', 'idle', 'credits notselected', 24, true)
	addAnimationByPrefix('credits', 'selected', 'credits selected', 24, false)
	addOffset('credits', 'idle', 0, 0)
	addOffset('credits', 'selected', 216, 172)
	playAnim('credits', 'idle')
	setObjectCamera('credits', 'other')
	addLuaSprite('credits')
	createHitbox('creditshit', 40, 175, 225, 525)

	makeAnimatedLuaSprite('freeplay', 'newMain/freeplay', 1100, 160)
	addAnimationByPrefix('freeplay', 'idle', 'Freeplay not selected', 24, true)
	addAnimationByPrefix('freeplay', 'selected', 'Freeplay selected', 24, false)
	addOffset('freeplay', 'idle', 0, 0)
	addOffset('freeplay', 'selected', 256, 170)
	playAnim('freeplay', 'idle')
	setObjectCamera('freeplay', 'other')
	addLuaSprite('freeplay')
	createHitbox('freeplayhit', 1100, 160, 145, 225)

	makeAnimatedLuaSprite('boombox', 'newMain/boombox', 779, 433)
	addAnimationByPrefix('boombox', 'idle', 'boombox not selected', 24, true)
	addAnimationByPrefix('boombox', 'selected', 'boombox selected', 24, false)
	addOffset('boombox', 'idle', 0, 0)
	addOffset('boombox', 'selected', 0, 5)
	playAnim('boombox', 'idle')
	setObjectCamera('boombox', 'other')
	addLuaSprite('boombox')
	createHitbox('boomboxhit', 779, 433, 165, 135)

	makeAnimatedLuaSprite('costumes', 'newMain/costumes', 505, 580)
	addAnimationByPrefix('costumes', 'idle', 'costume notselected', 24, true)
	addAnimationByPrefix('costumes', 'selected', 'costume selected', 24, false)
	addOffset('costumes', 'idle', 0, 0)
	addOffset('costumes', 'selected', 83, 102)
	playAnim('costumes', 'idle')
	setObjectCamera('costumes', 'other')
	addLuaSprite('costumes')
	createHitbox('costumeshit', 505, 580, 240, 115)

	makeAnimatedLuaSprite('extras', 'newMain/extra', 839, 210)
	addAnimationByPrefix('extras', 'idle', 'extras notselected', 24, true)
	addAnimationByPrefix('extras', 'selected', 'extras selected', 24, false)
	addOffset('extras', 'idle', 0, 0)
	addOffset('extras', 'selected', 258, 258)
	playAnim('extras', 'idle')
	setObjectCamera('extras', 'other')
	addLuaSprite('extras')

	createHitbox('extrashit', 839, 210, 150, 175)

	makeLuaText('versionShit', 'Friday Night Fever 0.0.1', 0, 0, 0)
	setTextSize('versionShit', 20)
	setTextFont('versionShit', 'Plunge.otf')
	setTextAlignment('versionShit', 'left')
	setProperty('versionShit.x', screenWidth - getProperty('versionShit.width') - 10)
	setProperty('versionShit.y', screenHeight - getProperty('versionShit.height') - 10)
	setObjectCamera('versionShit', 'other')
	addLuaText('versionShit', true)

	makeAnimatedLuaSprite('hand', 'newMain/cursor')
	addAnimationByPrefix('hand', 'idle', 'cursor nonselect', 0)
	addAnimationByPrefix('hand', 'select', 'cursor select', 0)
	addAnimationByPrefix('hand', 'qidle', 'cursor qnonselect', 0)
	addAnimationByPrefix('hand', 'qselect', 'cursor qselect', 0)
	playAnim('hand', 'idle')
	setGraphicSize('hand', getProperty('hand.width') / 1.5, getProperty('hand.height') / 1.5)
	setProperty('hand.antialiasing', true)
	setObjectCamera('hand', 'other')
	addLuaSprite('hand', true)
    end

    if name == 'Brochure Menu' then
	makeLuaSprite('bg', 'story/selecting/bg')
	setProperty('bg.antialiasing', true)
	setObjectCamera('bg', 'other')
	addLuaSprite('bg')

	createInstance('cscroll', 'flixel.addons.display.FlxBackdrop', {nil, 0x01})
	loadGraphic('cscroll', 'story/selecting/cscroll')
	scaleObject('cscroll', 1.55, 1.55)
	setProperty('cscroll.alpha', 0.0000000000009)
	setObjectCamera('cscroll', 'other')

	createInstance('fscroll', 'flixel.addons.display.FlxBackdrop', {nil, 0x01})
	loadGraphic('fscroll', 'story/selecting/fscroll')
	scaleObject('fscroll', 1.55, 1.55)
	setProperty('fscroll.alpha', 0.0000000000009)
	setObjectCamera('fscroll', 'other')

	addInstance('cscroll')
	addInstance('fscroll')

	for i = 0, 1 do
	    makeAnimatedLuaSprite('brochure'..i, 'story/selecting/'..(i == 0 and 'f' or 'c')..'brochure')
	    for _,f in pairs({'confirm', 'nselected', 'selected', 'open'}) do
		addAnimationByPrefix('brochure'..i, f, f, 24, f:find('selected') and true or false)
	    end
	    playAnim('brochure'..i, 'nselected')
	    scaleObject('brochure'..i, 0.66, 0.66)
	    setProperty('brochure'..i..'.x', screenWidth * (i == 0 and 0.3 or 0.6) - (getProperty('brochure'..i..'.width') / 2))
	    setProperty('brochure'..i..'.y', (screenHeight * 0.5) - (getProperty('brochure'..i..'.height') / 2))
	    runHaxeCode("game.getLuaObject('brochure"..i.."').centerOffsets();")
	    playAnim('brochure'..i, 'open')
	    setProperty('brochure'..i..'.antialiasing', true)
	    setObjectCamera('brochure'..i, 'other')
	    addLuaSprite('brochure'..i)
	    table.insert(brochures, 'brochure'..i)
	    setProperty('brochure'..i..'.ID', i)

	    runHaxeCode([[
		game.getLuaObject('brochure]]..i..[[').animation.finishCallback = (t) -> {
		    if (t == 'open')
			game.callOnLuas('changeSelected', [true]);

		    if (t == 'confirm')
			debugPrint('test');
		}
	    ]])
	end

	makeLuaSprite('textBG', nil, 0, screenHeight * 0.9)
	makeGraphic('textBG', 10, 10, '000000')
	setProperty('textBG.alpha', 0.6)
	setProperty('textBG.origin.y', 0)
	setObjectCamera('textBG', 'other')
	addLuaSprite('textBG')

	makeLuaText('text', '', 0, 0, screenHeight * 0.9)
	setTextFont('text', 'VCR OSD Mono.otf')
	setTextSize('text', 22)
	setTextAlignment('text', 'center')
	setObjectCamera('text', 'other')
	addLuaText('text')
    end
end

local playedAnim, playedAnimSel = false -- this is probably so dumb
function onCustomSubstateUpdate(name, elapsed)
    if keyboardJustPressed('SPACE') then
	    restartSong()
	end

    setProperty('hand.x', getMouseX('other')) setProperty('hand.y', getMouseY('other'))

    if mousePressed() then
	playAnim('hand', selectedSomethin and 'qselect' or 'select')
	setProperty('hand.offset.y', selectedSomethin and 34 or 8)
    else
	playAnim('hand', selectedSomethin and 'qidle' or 'idle')
	setProperty('hand.offset.y', selectedSomethin and 24 or 0)
    end

    if name == 'Main Menu' then
	for _, entry in ipairs(callbacks) do
	    if getProperty(entry.sprite..'.visible') and mouseOverlaps(entry.sprite) then
		selectedSomethin = true
		playAnim(entry.sprite:gsub('hit', ''), 'selected', true)
		if mouseClicked() then
		    if entry.callback then -- check if it exists (just for now)
		    entry.callback()
		    end
		end
	    else
		selectedSomethin = false
		playAnim(entry.sprite:gsub('hit', ''), 'idle', true)
	    end
	end
    end

    if name == 'Brochure Menu' then
	if keyJustPressed('left') or keyJustPressed('right') then
	    changeSelected()end

	setProperty('cscroll.x', getProperty('cscroll.x') - elapsed * 120)
	setProperty('fscroll.x', getProperty('fscroll.x') - elapsed * 120)
	if getProperty('controls.ACCEPT') then
	    playAnim(brochures[selectingFrenzy and 1 or 2], 'confirm')
	end
    end
end

function changeSelected(firstStart)
    firstStart = false
    if not firstStart then
	selectingFrenzy = not selectingFrenzy end

    for _,i in pairs(brochures) do
	playAnim(i, (selectingFrenzy and getProperty(i..'.ID') == 0 or not selectingFrenzy and getProperty(i..'.ID') == 1) and 'selected' or 'nselected')

	if getProperty(i..'.ID') == 1 then
	    setProperty(i..'.offset.x', -52.27)
	    setProperty(i..'.offset.y', 128.93)
	end
    end

    setProperty('fscroll.alpha', selectingFrenzy and 0.2 or 0)
    setProperty('cscroll.alpha', not selectingFrenzy and 0.2 or 0)
    setTextString('text', selectingFrenzy and 'Contains all of the brand new weeks featured in the Frenzy update' or 'The original Friday Night Fever experience featuring Weeks 1 throught 6')
    screenCenter('text', 'X')
    screenCenter('textBG', 'X')
    scaleObject('textBG', (getProperty('text.width') / getProperty('textBG.width')) * 1.03, getProperty('text.height') / getProperty('textBG.height'), false)
end

function createHitbox(tag, xpos, ypos, width, height, cb)
    makeLuaSprite(tag, nil, xpos, ypos)
    makeGraphic(tag, width, height, 'ffffff')
    setObjectCamera(tag, 'other')
    setProperty(tag..'.alpha', 0.001)
    addLuaSprite(tag)
    table.insert(hitboxes, tag)

    table.insert(callbacks, {sprite = tag, callback = cb})
end

function mouseOverlaps(spr)
    return getMouseX('other') > getProperty(spr..'.x') and getMouseX('other') < getProperty(spr..'.x') + getProperty(spr..'.width') and getMouseY('other') > getProperty(spr..'.y') and getMouseY('other') < getProperty(spr..'.y') + getProperty(spr..'.height')
end