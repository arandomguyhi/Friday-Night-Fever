addHaxeLibrary('FlxTypedGrpup', 'flixel.group')

local firstTime = true
local selectedSomethin = false
local hitboxes = {}
local callbacks = {}

-- Freeplay Menu
local waitTimer = 0
local curSelected = 0
local textGrp = {}
local icons = {}
initSaveData('FreeplayMenu')
flushSaveData('FreeplayMenu')

-- I HATED DOING THIS BYE
local FREEPLAY_SONGS = {
    {
	image = 'week1',
	songs = {
	    {'Milk tea', 'gf'},
	    {'Peastep', 'peakek'},
	    {'Eros', 'peakek'},
	    {'Down Horrendous', 'peakek'}
	}
    },
    {
	image = 'week2',
	songs = {
	    {'Start Baby', 'spooky'},
	    {'Last Meow', 'feralspooky'},
	    {'Bazinga', 'taki'},
	    {'Crucify', 'taki'}
	}
    },
    {
	image = 'week2.5',
	songs = {{'Prayer', 'taki'}, {'Bad Nun', 'taki'}}
    },
    {
	image = 'week3',
	songs = {{'Mako', 'mako'}, {'VIM', 'mako'}, {'Retribution', 'mako-demon'}}
    },
    {
	image = 'week4',
	songs = {{'Honey', 'hunni'}, {'Bunni', 'hunni'}, {'Thorow It Back', 'hunni'}}
    },
    {
	image = 'week5',
	songs = {{'Mild', 'pepper'}, {'Spice', 'pepper'}, {'Party Crasher', 'yukichi'}}
    },
    {
	image = 'week6',
	songs = {
	    {'Ur Girl', 'mega-real'},
	    {'Chicken Sandwich', 'mega-real'},
	    {'Funkin God', 'flippy-real'}
	}
    },
    {
	image = 'extras',
	songs = {
	    {'Metamorphosis', 'peakek'},
	    {'Void', 'peakek'},
	    {'Down Bad', 'peakek'},
	    {'Farmed', 'mako-demon'},
	    {'Space Demons', 'bf-old'},
	    {'Old Hardships', 'tea-bat'}
	}
    }
}

local FRENZY_SONGS = {
    {
	image = 'week7',
	songs = {
	    {'Preparation', 'gf'},
	    {'C354R', 'robo-cesar'},
	    {'Loaded', 'robo-cesar'},
	    {'Gears', 'robofvr-final'}
	}
    },
    {
	image = 'week8',
	songs = {
	    {'Tranquility', 'scarlet'},
	    {'Princess', 'scarlet'},
	    {'Crack', 'scarlet'},
	    {'Bloom', 'scarlet-final'}
	}
    },
    {	image = 'weekhallow',
	songs = {
	    {'Hallow', 'hallow'},
	    {'Eclipse', 'hallow'},
	    {'SOUL', 'hallow'},
	    {'Dead Mans Melody', 'toothpaste'}
	}
    },
    {
	image = 'weekminus',
	songs = {{'Grando', 'robo-cesar'}, {'Feel The Rage', 'taki'}}
    },
    {
    	image = 'week9',
	songs = {
	    {'DUI', 'rolldog'},
	    {'Cosmic Swing', 'rolldog'},
	    {'Cell From Hell', 'rolldog'},
	    {'W00F', 'rolldog'}
	}
    },
    {
	image = 'extras',
	songs = {
	    {'Hardships', 'tea-bat'},
	    {'Erm...', 'pepper'},
	    {'Mechanical', 'scarlet'},
	    {'Old Hallow', 'hallow'},
	    {'Old Portrait', 'hallow'},
	    {'Old Soul', 'hallow'}
	}
    }
}

-- Brochure menu
local selectingFrenzy = true
local brochures = {}
setVar('allowInput', false)

-- Story Mode Menu
initSaveData('StoryMenuState')
flushSaveData('StoryMenuState')

luaDebugMode = true
function createMainMenuState()
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
	createHitbox('freeplayhit', 1100, 160, 145, 225, function()
	    closeCustomSubstate('Main Menu')
	    runTimer('cudnv', 1)
	    function onTimerCompleted(tag) if tag == 'cudnv' then openCustomSubstate('Freeplay State')end end
	end)

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

local freeplayStateAssets = {'bgfreeplay', 'peeps', 'chairs', 'feva', 'peppa', 'table', 'hands', 'classic', 'frenzy'}
function createFreeplayState()
	makeLuaSprite('bgfreeplay', 'freeplay/bg')
	setProperty('bgfreeplay.antialiasing', true)
	setObjectCamera('bgfreeplay', 'other')
	addLuaSprite('bgfreeplay')

	makeAnimatedLuaSprite('peeps', 'freeplay/peeps', 19, 65)
	addAnimationByPrefix('peeps', 'bop', 'people', 24, false)
	playAnim('peeps', 'bop')
	setProperty('peeps.origin.x', 0) setProperty('peeps.origin.y', 0)
	scaleObject('peeps', 0.67, 0.67, false)
	setProperty('peeps.antialiasing', true)
	setObjectCamera('peeps', 'other')
	addLuaSprite('peeps')

	makeLuaSprite('chairs', 'freeplay/chairs', 319, 134)
	setProperty('chairs.antialiasing', true)
	setObjectCamera('chairs', 'other')
	addLuaSprite('chairs')

	createInstance('feva', 'objects.Character', {742, 115, 'bf-freeplay', true})
	setObjectCamera('feva', 'other')
	addInstance('feva')

	createInstance('peppa', 'objects.Character', {154, 291, 'pepper-freeplay'})
	setObjectCamera('peppa', 'other')
	addInstance('peppa')

	makeLuaSprite('table', 'freeplay/table', 257, 385)
	setProperty('table.antialiasing', true)
	setObjectCamera('table', 'other')
	addLuaSprite('table')

	makeAnimatedLuaSprite('hands', 'characters/pepper/hands', 259, 16)
	addAnimationByPrefix('hands', 'idle', 'pepper', 24, false)
	playAnim('hands', 'idle')
	scaleObject('hands', 0.67, 0.67, false)
	setProperty('hands.antialiasing', true)
	setObjectCamera('hands', 'other')
	addLuaSprite('hands')

	makeAnimatedLuaSprite('classic', 'freeplay/classicm', 609, 456)
	addAnimationByPrefix('classic', 'n', 'Classicn', 0)
	addAnimationByPrefix('classic', 's', 'Classics', 0)
	playAnim('classic', 'n')
	scaleObject('classic', 0.67, 0.67, false)
	setProperty('classic.antialiasing', true)
	setObjectCamera('classic', 'other')
	addLuaSprite('classic')

	makeAnimatedLuaSprite('frenzy', 'freeplay/frenzym', 374, 456)
	addAnimationByPrefix('frenzy', 'n', 'Frenzyn', 0)
	addAnimationByPrefix('frenzy', 's', 'Frenzys', 0)
	playAnim('frenzy', 'n')
	scaleObject('frenzy', 0.67, 0.67, false)
	setProperty('frenzy.antialiasing', true)
	setObjectCamera('frenzy', 'other')
	addLuaSprite('frenzy')
end

local freeplayMenuAssets = {'header', 'body', 'footer', 'diffText'}
function createFreeplayMenu()
    runHaxeCode([[
	    var freeCam:FlxCamera = new FlxCamera();
	    freeCam.bgColor = 0x0;
	    freeCam.copyFrom(camOther);
	    FlxG.cameras.add(freeCam);
	    setVar('freeCam', freeCam);
	]])

	makeAnimatedLuaSprite('header', 'freeplay/menu')
	addAnimationByPrefix('header', 'header frenzy', 'header frenzy', 0)
	addAnimationByPrefix('header', 'header classic', 'header classic', 0)
	playAnim('header', 'header classic')
	setProperty('header.origin.x', 0) setProperty('header.origin.y', 0)
	scaleObject('header', 1.8, 1.8)
	runHaxeCode("game.getLuaObject('header').camera = getVar('freeCam');")
	screenCenter('header', 'X')
	addLuaSprite('header')

	MenuSprite('body', getProperty('header.x'), 0, 'body')
	addLuaSprite('body')

	MenuSprite('footer', getProperty('header.x'), 0, 'footer')
	addLuaSprite('footer')

	makeLuaText('diffText', '< Normal >', 0, 0, 0)
	setTextFont('diffText', 'Funkin.otf')
	setTextSize('diffText', 24)
	setTextBorder('diffText', 0, 'FFFFFFF')
	setTextAlignment('diffText', 'center')
	setProperty('diffText.antialiasing', true)
	runHaxeCode([[
	    game.modchartTexts.get('diffText').camera = getVar('freeCam');
	    game.modchartTexts.get('diffText').scrollFactor.set(1, 1);
	]])
	addLuaText('diffText')
	setProperty('diffText.visible', false)
end

function onCreate()
    setProperty('skipCountdown', true)
    setProperty('camGame.visible', false)
    setProperty('camHUD.visible', false) -- i don't need these cams for now

    createMainMenuState()

    createFreeplayState()
    for _, i in ipairs(freeplayStateAssets) do setProperty(i..'.alpha', 0.001) end

    createFreeplayMenu()
    for _, i in ipairs(freeplayMenuAssets) do setProperty(i..'.alpha', 0.001) end
end

function onCreatePost()
    playMusic('freakyMenu', 1, true)
    setProperty('dad.visible', false) setProperty('boyfriend.visible', false) setProperty('gf.visible', false)
end

function onSongStart()
    openCustomSubstate('Main Menu')
end

function onPause() return Function_Stop end

function onCustomSubstateCreate(name)
    if name == 'Main Menu' then
	--hi?
    end

    if name == 'Freeplay State' then
	for _, i in ipairs(freeplayStateAssets) do
	    setProperty(i..'.alpha', 1)
	end

	allowInput = true
	selectingFrenzy = false
	changeSelection(true)
    end

    if name == 'Freeplay Menu' then
	playAnim('header', 'header '..(getDataFromSave('FreeplayMenu', 'isFrenzy') and 'frenzy' or 'classic'), true)	
	setProperty('body.y', getProperty('header.y') + getProperty('header.height') - 1)

	local nextLoc = 45
	local list = getDataFromSave('FreeplayMenu', 'isFrenzy') and FRENZY_SONGS or FREEPLAY_SONGS
	setVar('songList', list)

	for v, i in ipairs(list) do
	    MenuSprite('image'..v, getProperty('body.x'), getProperty('body.y'), i.image)
	    setProperty('image'..v..'.x', getProperty('body.x') + (getProperty('body.width') * ((v + 1) % 2 == 0 and 0.75 or 0.25)) - (getProperty('image'..v..'.width') / 2))
	    setProperty('image'..v..'.y', getProperty('body.y') + nextLoc)
	    addLuaSprite('image'..v)
	    table.insert(freeplayMenuAssets, 'image'..v)

	    for ii = 1, #i.songs do
		local song = i.songs[ii]
		local textX = (v + 1) % 2 == 0 and getProperty('image'..v..'.x') - 20 or getProperty('image'..v..'.x') + getProperty('image'..v..'.width') + 20

		makeLuaText('songText'..v..'_'..ii, song[1]..'\n', 0, textX, 0)
		setTextFont('songText'..v..'_'..ii, 'Funkin.otf')
		setTextSize('songText'..v..'_'..ii, 40)
		setTextBorder('songText'..v..'_'..ii, 0, 'FFFFFF')
		if (v + 1) % 2 == 0 then
		    setProperty('songText'..v..'_'..ii..'.x', getProperty('songText'..v..'_'..ii..'.x') - getProperty('songText'..v..'_'..ii..'.width')) end

		if i.image == 'extras' then
		    setProperty('songText'..v..'_'..ii..'.y', getProperty('image'..v..'.y') + (70 * ii))
		else
		    setProperty('songText'..v..'_'..ii..'.y', (getProperty('image'..v..'.y') + (getProperty('image'..v..'.height') / 2)) - ((getProperty('songText'..v..'_'..ii..'.height') + 20) * (#i.songs)) + ((getProperty('songText'..v..'_'..ii..'.height') + 40) * ii))
		end

		setProperty('songText'..v..'_'..ii..'.ID', #textGrp)

		local songText = 'songText'..v..'_'..ii
		makeLuaSprite('icon'..v..'_'..ii)
		loadGraphic('icon'..v..'_'..ii, 'icons/icon-'..song[2], 150, 150)
		addAnimation('icon'..v..'_'..ii, 'neutral', {0}, 0, false)
		playAnim('icon'..v..'_'..ii, 'neutral')
	 	setProperty('icon'..v..'_'..ii..'.origin.x', 0)
		setProperty('icon'..v..'_'..ii..'.origin.y', 0)
		scaleObject('icon'..v..'_'..ii, 0.6, 0.6)
		setProperty('icon'..v..'_'..ii..'.x', getProperty('image'..v..'.x') > getProperty(songText..'.x') and getProperty(songText..'.x') - getProperty('icon'..v..'_'..ii..'.width') or getProperty(songText..'.x') + getProperty(songText..'.width') + 5)
		setProperty('icon'..v..'_'..ii..'.y', getProperty(songText..'.y') - (getProperty('icon'..v..'_'..ii..'.height') / 2) + 20)
		addLuaSprite('icon'..v..'_'..ii)
		table.insert(icons, 'icon'..v..'_'..ii)
		table.insert(freeplayMenuAssets, 'icon'..v..'_'..ii)

		runHaxeCode([[
		    game.modchartTexts.get('songText]]..v..[[_]]..ii..[[').camera = getVar('freeCam');
		    game.modchartTexts.get('songText]]..v..[[_]]..ii..[[').scrollFactor.set(1, 1);
		]])
		addLuaText('songText'..v..'_'..ii)
		table.insert(textGrp, 'songText'..v..'_'..ii)
		table.insert(freeplayMenuAssets, 'songText'..v..'_'..ii)
	    end

	    nextLoc = nextLoc + getProperty('image'..v..'.height') + 45
	end

	setProperty('body.scale.y', ((getProperty('body.y') + nextLoc - 45) / getProperty('body.height')) * 1.8)
	updateHitbox('body')
	setProperty('body.antialiasing', false)
	setProperty('footer.y', getProperty('body.y') + getProperty('body.height') - 1)

	for _, i in ipairs(freeplayMenuAssets) do
	    setProperty(i..'.alpha', 1)
	end

	changeSelectionFree()
	allowInput = false
	setProperty('freeCam.scroll.y', -500)
	startTween('camcoisada', 'freeCam', {['scroll.y'] = 0}, 0.65, {ease = 'elasticOut'})
	runTimer('allow', 0.65)
	function onTimerCompleted(tag) if tag == 'allow' then allowInput = true end end
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
		    if (t == 'open') {
			setVar('allowInput', true);
			game.callOnLuas('changeSelected', [true]);
		    }else if (t == 'confirm') {
			game.callOnLuas('setDataFromSave', ['StoryMenuState', 'isFrenzy', getVar('selectingFrenzy')]);
			debugPrint(game.callOnLuas('getDataFromSave', ['StoryMenuState', 'isFrenzy']));
		    }
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

    if name == 'Freeplay State' then
	if not allowInput then return end

	if keyJustPressed('left') or keyJustPressed('right') then
	    changeSelection()
	    waitTimer = 0
	end

	if getProperty('controls.ACCEPT') then
	    allowInput = false
	    waitTimer = 0
	    setDataFromSave('FreeplayMenu', 'isFrenzy', selectingFrenzy)

	    closeCustomSubstate('Freeplay State')
	    runTimer('cunovamente', 1)
	    function onTimerCompleted(tag) if tag == 'cunovamente' then openCustomSubstate('Freeplay Menu')end end
	end

	if waitTimer >= 20 and allowInput then
	    loadSong(selectingFrenzy and 'Mechanical' or 'Erm', true)
	elseif allowInput then
	    waitTimer = waitTimer + elapsed
	end

	if curBeat % 1 == 0 then
	    playAnim('peeps', 'bop')
	    playAnim('hands', 'idle')
	    callMethod('peppa.dance', {''})
	    callMethod('feva.dance', {''})
	end
    end

    if name == 'Freeplay Menu' then
	if not allowInput then return end

	if getProperty('controls.ACCEPT') then
	    allowInput = false
	    local selectedSong = textGrp[curSelected+1]
	    if selectedSong then
	    	loadFreeplaySong(getProperty(selectedSong..'.text'), 1)
	    end
	end

	if keyJustPressed('up') then
	    changeSelectionFree(-1)
	elseif keyJustPressed('down') then
	    changeSelectionFree(1)
	elseif getProperty('controls.BACK') then
	    allowInput = false
	    closeCustomSubstate('Freeplay Menu')
	    startTween('closin', 'freeCam', {['scroll.y'] = -950}, 0.65, {onComplete = 'openfreeplaystate', ease = 'quadInOut'})
	    function openfreeplaystate()
		openCustomSubstate('Freeplay State')
	    end
	end

	if curBeat % 1 == 0 then
	    playAnim('peeps', 'bop')
	    playAnim('hands', 'idle')
	    callMethod('peppa.dance', {''})
	    callMethod('feva.dance', {''})
	end
    end

    if name == 'Brochure Menu' then
	if getVar('allowInput') and (keyJustPressed('left') or keyJustPressed('right')) then
	    changeSelected()end

	setProperty('cscroll.x', getProperty('cscroll.x') - elapsed * 120)
	setProperty('fscroll.x', getProperty('fscroll.x') - elapsed * 120)
	if getProperty('controls.ACCEPT') then
	    setVar('allowInput', false)
	    playAnim(brochures[selectingFrenzy and 1 or 2], 'confirm')
	end

	setVar('selectingFrenzy', selectingFrenzy)
    end
end

function onCustomSubstateDestroy(name)
    if name == 'Freeplay Menu' then
	for _, i in ipairs(freeplayMenuAssets) do
	    setProperty(i..'.alpha', 0.001)
	end
	for _, i in ipairs(getVar('songList')) do removeLuaSprite('image'.._) end
	for _, i in ipairs(textGrp) do removeLuaText(i) end
	for _, i in ipairs(icons) do removeLuaSprite(i) end
	textGrp = {}
	icons = {}
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

function changeSelection(mute)
    if mute == nil then mute = false end
    selectingFrenzy = not selectingFrenzy

    playAnim('frenzy', selectingFrenzy and 's' or 'n')
    playAnim('classic', selectingFrenzy and 'n' or 's')

    if not mute then
	playSound('menu/general-interact')
    end
end

function changeSelectionFree(change)
    if change == nil then change = 0 curSelected = 0 end
    curSelected = curSelected + change

    if curSelected >= #textGrp then
	curSelected = 0
    elseif curSelected < 0 then
	curSelected = #textGrp - 1
    end

    for _, text in ipairs(textGrp) do
	setProperty(text..'.color', getColorFromHex(curSelected == getProperty(text..'.ID') and 'FFFFFF' or '808080'))
	setProperty(icons[getProperty(text..'.ID')+1]..'.alpha', curSelected == getProperty(text..'.ID') and 1 or 0.7)
	if curSelected == getProperty(text..'.ID') then
	    startTween('changeSel', 'freeCam', {['scroll.y'] = getProperty(text..'.y') - 400 < 0 and 0 or getProperty(text..'.y') - 400}, 0.3, {ease = 'smoothStepInOut'})
	    setProperty('diffText.x', getProperty(text..'.x') + (getProperty(text..'.width') / 2) - (getProperty('diffText.width') / 2))
	    setProperty('diffText.y', getProperty(text..'.y') + getProperty(text..'.height'))
	    setProperty('diffText.visible', true)
	end
    end
end

function loadFreeplaySong(song, diff)
    song = stringTrim(song:gsub('\n', '')):gsub('%.%.%.', ''):lower()
    setPropertyFromClass('backend.Difficulty', 'list', {'Normal', 'Hard'})

    startTween('loadieTime', 'freeCam', {['scroll.y'] = -950}, 0.65, {ease = 'cubeInOut', onComplete = 'loadTime'})
    function loadTime()
	if song ~= 'mechanical' and song ~= 'erm' then
	    makeAnimatedLuaSprite('enter', 'freeplay/freeplayenter', 0, 290)
	    addAnimationByPrefix('enter', 'cover', 'cover', 24, false)
	    playAnim('enter', 'cover')
	    callMethod('enter.animation.pause', {''})
	    setProperty('enter.antialiasing', true)
	    scaleObject('enter', 0.67, 0.67, false)
	    setObjectCamera('enter', 'other')
	    addLuaSprite('enter')
	    screenCenter('enter', 'X')

	    setProperty('enter.alpha', 0.001)
	    setProperty('enter.y', getProperty('enter.y') - 60)
	    startTween('served', 'enter', {y = getProperty('enter.y') + 60, alpha = 1}, 0.4, {onComplete = 'loadCurrentSong'})
	    function loadCurrentSong()
		callMethod('enter.animation.resume', {''})
		runTimer('whyarewe...', 0.9)
		function onTimerCompleted(tag) if tag == 'whyarewe...' then startTween('enterit', 'camOther', {['scroll.y'] = 175, zoom = 12}, 0.6, {ease = 'cubeInOut'})end end
		runHaxeCode([[
		    game.getLuaObject('enter').animation.finishCallback = (a) -> {
			game.callOnLuas('loadSong', [']]..song..[[', ]]..tonumber(diff)..[[]);
		    }
	    	]])
	    end
	else
	    closeCustomSubstate('Freeplay Menu')
	    setPropertyFromClass('flixel.addons.transition.FlxTransitionableState', 'skipNextTransOut', true)
	    setPropertyFromClass('flixel.addons.transition.FlxTransitionableState', 'skipNextTransIn', true)
	    loadSong(song, diff)
	end
    end
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

-- this is for freeplay thing
function MenuSprite(tag, x, y, anim)
    makeAnimatedLuaSprite(tag, 'freeplay/menu', x, y)
    addAnimationByPrefix(tag, anim, anim, 0)
    playAnim(tag, anim)
    setProperty(tag..'.origin.x', 0) setProperty(tag..'.origin.y', 0)
    scaleObject(tag, 1.8, 1.8)
    runHaxeCode("game.getLuaObject('"..tag.."').camera = getVar('freeCam');")
end

function mouseOverlaps(spr)
    return getMouseX('other') > getProperty(spr..'.x') and getMouseX('other') < getProperty(spr..'.x') + getProperty(spr..'.width') and getMouseY('other') > getProperty(spr..'.y') and getMouseY('other') < getProperty(spr..'.y') + getProperty(spr..'.height')
end