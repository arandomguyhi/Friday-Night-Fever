local firstTime = true
local curSelected = 0

luaDebugMode = true
function onCreate()
    --setPropertyFromClass('flixel.FlxG', 'mouse.visible', true)

    makeAnimatedLuaSprite('hand', 'newMain/cursor')
    addAnimationByPrefix('hand', 'idle', 'cursor nonselect', 0)
    addAnimationByPrefix('hand', 'select', 'cursor select', 0)
    addAnimationByPrefix('hand', 'qidle', 'cursor qnonselect', 0)
    addAnimationByPrefix('hand', 'qselect', 'cursor qselect', 0)
    --playAnim('hand', 'select')
    setGraphicSize('hand', getProperty('hand.width') / 1.5, getProperty('hand.height') / 1.5)
    setProperty('hand.antialiasing', true)
    setObjectCamera('hand', 'other')
    addLuaSprite('hand')
end

function onUpdate()
    setProperty('hand.x', getMouseX()) setProperty('hand.y', getMouseY())

    if mousePressed() then
	--playAnim('hand', curSelected ~= nil and 'qselect' or 'select')
	--setProperty('hand.offset.y', curSelected ~= nil and 34 or 8)
	debugPrint('is pressing')
    else
	--playAnim('hand', curSelected ~= nil and 'qidle' or 'idle')
	--setProperty('hand.offset.y', curSelected ~= nil and 24 or 0)
	debugPrint('just movin')
    end
end