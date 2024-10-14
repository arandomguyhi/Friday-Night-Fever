luaDebugMode = true
function onCreate()
    makeLuaSprite('bg', nil, -720, -450)
    loadGraphic('bg', 'w1city', 2560, 1400, true)
    addAnimation('bg', 'idle', {3}, 0)
    playAnim('bg', 'idle')
    scaleObject('bg', 0.3, 0.3, false)
    setProperty('bg.antialiasing', true)
    setScrollFactor('bg', 0.9, 0.9)
    addLuaSprite('bg')

    makeLuaSprite('w1city', nil, getProperty('bg.x'), getProperty('bg.y'))
    loadGraphic('w1city', 'w1city', 2560, 1400, true)
    addAnimation('w1city', 'idle', {0, 1, 2}, 0)
    playAnim('w1city', 'idle')
    scaleObject('w1city', getProperty('bg.scale.x'), getProperty('bg.scale.y'), false)
    setProperty('w1city.antialiasing', true)
    setScrollFactor('w1city', 0.9, 0.9)
    addLuaSprite('w1city')

    makeLuaSprite('stageFront', 'stagefront', -730, 530)
    setGraphicSize('stageFront', getProperty('stageFront.width') * 1.1, getProperty('stageFront.height') * 1.1)
    setProperty('stageFront.antialiasing', true)
    setScrollFactor('stageFront', 0.9, 0.9)
    addLuaSprite('stageFront')

    makeLuaSprite('stageCurtains', songName:lower() == 'down bad' and 'stagecurtainsDOWNBAD' or 'stagecurtains', -500, -300)
    setGraphicSize('stageCurtains', getProperty('stageCurtains.width') * 0.9, getProperty('stageCurtains.height') * 0.9)
    setProperty('stageCuratins.antialiasing', true)
    setScrollFactor('stageCurtains', 0.9, 0.9)
    addLuaSprite('stageCurtains')

    makeAnimatedLuaSprite('dog', 'week1/eepydog', getProperty('stageCurtains.x') + (880 * 0.9), getProperty('stageCurtains.y') + (745 * 0.9))
    addAnimationByPrefix('dog', 'idle', 'r', 24)
    playAnim('dog', 'idle')
    setScrollFactor('dog', 0.9, 0.9)
    setProperty('dog.antialiasing', true)
    addLuaSprite('dog')

    makeAnimatedLuaSprite('leftAd', 'week1/ads', getProperty('stageCurtains.x') + (245 * 0.9), getProperty('stageCurtains.y') + (428 * 0.9))
    addAnimationByPrefix('leftAd', 'a', 'leftAds0', 0)
    playAnim('leftAd', 'a')
    setGraphicSize('leftAd', getProperty('leftAd.width') * 0.9, getProperty('leftAd.height') * 0.9)
    setScrollFactor('leftAd', 0.9, 0.9)
    setProperty('leftAd.antialiasing', true)
    addLuaSprite('leftAd')
    updateHitbox('leftAd')

    makeAnimatedLuaSprite('rightAd', 'week1/ads', getProperty('stageCurtains.x') + (1584 * 0.9), getProperty('stageCurtains.y') + (434 * 0.9))
    addAnimationByPrefix('rightAd', 'a', 'rightAds0', 0)
    playAnim('rightAd', 'a')
    setGraphicSize('rightAd', getProperty('rightAd.width') * 0.86, getProperty('rightAd.height') * 0.86)
    setProperty('rightAd.origin.x', 0) setProperty('righAd.origin.y', 0)
    setScrollFactor('rightAd', 0.9, 0.9)
    setProperty('rightAd.antialiasing', true)
    addLuaSprite('rightAd')
    updateHitbox('rightAd')
end

function onCreatePost()
    setScrollFactor('gf', 0.95, 0.95)
end

function onBeatHit()
    if curBeat % 2 == 0 then
	if getProperty('w1city.animation.curAnim.curFrame') > 2 then
	    setProperty('w1city.animation.curAnim.curFrame', 0)
	else
	    setProperty('w1city.animation.curAnim.curFrame', getProperty('w1city.animation.curAnim.curFrame') + 1)
	end
    end

    if curBeat % 8 == 0 then
	for _, i in pairs({'rightAd', 'leftAd'}) do
	    if getProperty(i..'.animation.curAnim.curFrame') > 2 then
		setProperty(i..'.animation.curAnim.curFrame', 0)
	    else
		setProperty(i..'.animation.curAnim.curFrame', getProperty(i..'.animation.curAnim.curFrame') + 1)
	    end
	end
    end
end