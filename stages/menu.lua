local firstTime = true
local selectedSomethin = false

local mainMenuObjects = {'options', 'credits', 'freeplay', 'boombox', 'costumes', 'extras', 'train'}

luaDebugMode = true
function onCreate()
    setPropertyFromClass('flixel.FlxG', 'mouse.visible', false)

    makeLuaSprite('tunnelBG', 'newMain/subway_bg_2', 0, -12)
    setObjectCamera('tunnelBG', 'other')
    addLuaSprite('tunnelBG')

    makeAnimatedLuaSprite('train', 'newMain/trainmenu', 255, 140)
    addAnimationByPrefix('train', 'come', 'Train come', 24, false)
    addAnimationByPrefix('train', 'idle', 'Train notselected', 24, false)
    addAnimationByPrefix('train', 'selected', 'Train selected', 24, false)
    addOffset('train', 'idle', 0, 0)
    addOffset('train', 'selected', 0, 42)
    playAnim('train', 'idle')
    scaleObject('train', 1.32, 1.32, false)
    setObjectCamera('train', 'other')
    addLuaSprite('train')

    makeLuaSprite('mainBG', 'newMain/subway_bg', 0, -12)
    setObjectCamera('mainBG', 'other')
    addLuaSprite('mainBG')

    makeAnimatedLuaSprite('options', 'newMain/options', 915.5, 580.55)
    addAnimationByPrefix('options', 'idle', 'options notselected', 24, false)
    addAnimationByPrefix('options', 'selected', 'options selected', 24, false)
    addOffset('options', 'idle', 0, 0)
    addOffset('options', 'selected', 0, 34)
    playAnim('options', 'idle')
    setObjectCamera('options', 'other')
    addLuaSprite('options')

    makeAnimatedLuaSprite('credits', 'newMain/credits', -10, 45)
    addAnimationByPrefix('credits', 'idle', 'credits notselected', 24, false)
    addAnimationByPrefix('credits', 'selected', 'credits selected', 24, false)
    addOffset('credits', 'idle', 0, 0)
    addOffset('credits', 'selected', 216, 172)
    playAnim('credits', 'idle')
    setObjectCamera('credits', 'other')
    addLuaSprite('credits')

    makeAnimatedLuaSprite('freeplay', 'newMain/freeplay', 1100, 160)
    addAnimationByPrefix('freeplay', 'idle', 'Freeplay not selected', 24, false)
    addAnimationByPrefix('freeplay', 'selected', 'Freeplay selected', 24, false)
    addOffset('freeplay', 'idle', 0, 0)
    addOffset('freeplay', 'selected', 256, 170)
    playAnim('freeplay', 'idle')
    setObjectCamera('freeplay', 'other')
    addLuaSprite('freeplay')

    makeAnimatedLuaSprite('boombox', 'newMain/boombox', 779, 433)
    addAnimationByPrefix('boombox', 'idle', 'boombox not selected', 24, false)
    addAnimationByPrefix('boombox', 'selected', 'boombox selected', 24, false)
    addOffset('boombox', 'idle', 0, 0)
    addOffset('boombox', 'selected', 0, 5)
    playAnim('boombox', 'idle')
    setObjectCamera('boombox', 'other')
    addLuaSprite('boombox')

    makeAnimatedLuaSprite('costumes', 'newMain/costumes', 505, 580)
    addAnimationByPrefix('costumes', 'idle', 'costume notselected', 24, false)
    addAnimationByPrefix('costumes', 'selected', 'costume selected', 24, false)
    addOffset('costumes', 'idle', 0, 0)
    addOffset('costumes', 'selected', 83, 102)
    playAnim('costumes', 'idle')
    setObjectCamera('costumes', 'other')
    addLuaSprite('costumes')

    makeAnimatedLuaSprite('extras', 'newMain/extra', 839, 210)
    addAnimationByPrefix('extras', 'idle', 'extras notselected', 24, false)
    addAnimationByPrefix('extras', 'selected', 'extras selected', 24, false)
    addOffset('extras', 'idle', 0, 0)
    addOffset('extras', 'selected', 258, 258)
    playAnim('extras', 'idle')
    setObjectCamera('extras', 'other')
    addLuaSprite('extras')

    makeLuaText('versionShit', 'Friday Night Fever 0.0.1', 0, 0, 0)
    setTextSize('versionShit', 20)
    setTextFont('versionShit', 'Plunge.ttf')
    setTextAlignment('versionShit', 'left')
    setProperty('versionShit.x', screenWidth - getProperty('versionShit.width') - 10)
    setProperty('versionShit.y', screenHeight - getProperty('versionShit.height') - 10)
    setObjectCamera('versionShit', 'other')
    addLuaText('versionShit')

    makeAnimatedLuaSprite('hand', 'newMain/cursor')
    addAnimationByPrefix('hand', 'idle', 'cursor nonselect', 0)
    addAnimationByPrefix('hand', 'select', 'cursor select', 0)
    addAnimationByPrefix('hand', 'qidle', 'cursor qnonselect', 0)
    addAnimationByPrefix('hand', 'qselect', 'cursor qselect', 0)
    playAnim('hand', 'select')
    setGraphicSize('hand', getProperty('hand.width') / 1.5, getProperty('hand.height') / 1.5)
    setProperty('hand.antialiasing', true)
    setObjectCamera('hand', 'other')
    addLuaSprite('hand', true)
end

function onUpdate()
    setProperty('hand.x', getMouseX('other')) setProperty('hand.y', getMouseY('other'))

    for i, obj in pairs(mainMenuObjects) do
	if mouseOverlaps(obj) then
	    playAnim(obj, 'selected')

	    playAnim('hand', 'qidle')
	    setProperty('hand.offset.y', 24)
	else
	    playAnim('hand', 'idle')
	    setProperty('hand.offset.y', 0)

	    playAnim(obj, 'idle')
	end
    end

--[[    if mousePressed() then
	playAnim('hand', selectedSomethin and 'qselect' or 'select')
	setProperty('hand.offset.y', selectedSomethin and 34 or 8)
    else
	playAnim('hand', selectedSomethin and 'qidle' or 'idle')
	setProperty('hand.offset.y', selectedSomethin and 24 or 0)
    end]]
end

function mouseOverlaps(spr)
    -- much easier :)
    return runHaxeCode("FlxG.mouse.overlaps(game.getLuaObject('"..spr.."'));")
end