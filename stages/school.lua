local prefix = 'stages/week6/weeb/'
local getScared = false

luaDebugMode = true
function onCreate()
    makeLuaSprite('bgSky', prefix..'weebSky', 0, -200)
    setScrollFactor('bgSky', 0.9, 0.9)
    addLuaSprite('bgSky')

    local repositionShit = -200

    makeLuaSprite('bgSchool', prefix..'weebSchool', repositionShit)
    setScrollFactor('bgSchool', 0.9, 0.9)
    addLuaSprite('bgSchool')

    makeLuaSprite('bgStreet', prefix..'weebStreet', repositionShit)
    setScrollFactor('bgStreet', 0.9, 0.9)
    addLuaSprite('bgStreet')

    local widShit, hgShit = tonumber(getProperty('bgSky.width') * 6), tonumber(getProperty('bgSky.height') * 6)

    setGraphicSize('bgSky', widShit, hgShit)
    setGraphicSize('bgSchool', widShit, hgShit)
    setGraphicSize('bgStreet', widShit, hgShit)

    if songName:lower() ~= 'space-demons' then
	makeAnimatedLuaSprite('bgGirls', prefix..'bgCrowd', -1205, -290)
	addAnimationByPrefix('bgGirls', 'idle', 'FTRS - Ur Girl ', 24, false)
	addAnimationByPrefix('bgGirls', 'idle-scared', 'FTRS - Chicken Sandwich', 24, false)
	setScrollFactor('bgGirls', 0.9, 0.9)

	if songName:lower() == 'chicken-sandwich' then getScared = true end
	playAnim('bgGirls', 'idle'..(getScared and '-scared' or ''))

	setGraphicSize('bgGirls', getProperty('bgGirls.width') * 6, getProperty('bgGirls.height') * 6)
	addLuaSprite('bgGirls')
    end

    makeLuaSprite('bgFront', prefix..'weebfront', repositionShit)
    setScrollFactor('bgFront', 0.9, 0.9)
    addLuaSprite('bgFront')

    makeLuaSprite('bgOverlay', prefix..'weeboverlay', repositionShit)
    setScrollFactor('bgOverlay', 0.9, 0.9)
    addLuaSprite('bgOverlay')

    setGraphicSize('bgFront', widShit, hgShit)
    setGraphicSize('bgOverlay', widShit, hgShit)
end

function onCreatePost()
    for _, i in pairs({'dad', 'boyfriend', 'gf'}) do
	setScrollFactor(i, 0.9, 0.9) end
end

function onBeatHit()
    setProperty('bgGirls.animation.curAnim.curFrame', 0)
    playAnim('bgGirls', 'idle'..(getScared and '-scared' or ''))
end