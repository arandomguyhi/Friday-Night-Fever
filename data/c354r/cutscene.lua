luaDebugMode = true

if getPropertyFromClass('states.PlayState', 'deathCounter') > 0 then
    return
end
setProperty('skipCountdown', true)

local allowCountdown = false
queodio = getProperty('defaultCamZoom')

function onStartCountdown()
    if not allowCountdown then
        allowCountdown = true

        setProperty('camFollow.x', getCamPos('dad').x)
        setProperty('camFollow.y', getCamPos('dad').y)
        callMethod('camGame.snapToTarget', {''})

        setProperty('camGame.zoom', getProperty('camGame.zoom') + 0.12)
        cameraFlash('camGame', '000000', 1.3)

        for _, d in pairs({'dad', 'gf', 'boyfriend'}) do
            setProperty(d..'.visible', false) end

        makeAnimatedLuaSprite('tea', 'roboStage/C354R/tea_anim', getProperty('gf.x') - 120, getProperty('gf.y') - 34)
        addAnimationByPrefix('tea', 'anim', 'tea_anim', 24, false)
        playAnim('tea', 'anim')
        setProperty('tea.animation.curAnim.paused', true)
        setProperty('tea.antialiasing', true)
        addLuaSprite('tea')
        setObjectOrder('tea', getObjectOrder('gfGroup'))

        makeAnimatedLuaSprite('robo', 'roboStage/C354R/robo_anim', getProperty('dad.x') - 90, getProperty('dad.y') - 371)
        addAnimationByPrefix('robo', 'anim', 'robo animation', 24, false)
        playAnim('robo', 'anim')
        setProperty('robo.animation.curAnim.paused', true)
        setProperty('robo.antialiasing', true)
        addLuaSprite('robo')
        setObjectOrder('robo', getObjectOrder('dadGroup'))

        makeAnimatedLuaSprite('fever', 'roboStage/C354R/fever_anim', getProperty('boyfriend.x') - 63, getProperty('boyfriend.y') - 96)
        addAnimationByPrefix('fever', 'anim', 'fever_anim', 24, false)
        playAnim('fever', 'anim')
        setProperty('fever.animation.curAnim.paused', true)
        setProperty('fever.antialiasing', true)
        addLuaSprite('fever')
        setObjectOrder('fever', getObjectOrder('boyfriendGroup'))

        for _,i in pairs({'fever', 'tea', 'robo'}) do
            setProperty(i..'.color', 0xc681c6)
        end

        setProperty('camHUD.visible', false)
        setProperty('fever.animation.curAnim.paused', false)
        setProperty('robo.animation.curAnim.paused', false)
        setProperty('tea.animation.curAnim.paused', false)

        runTimer('robCut', 0.08)
        runTimer('start', 5.6)

        return Function_Stop
    end
    return Function_Continue
end

function onUpdate()
    if getProperty('robo.animation.curAnim.curFrame') >= 53 and getProperty('zombie.animation.curAnim.name') ~= 'EXPLODE' then
        playAnim('zombie', 'EXPLODE')
        setProperty('zombie.offset.x', getProperty('zombie.offset.x') + 293)
        setProperty('zombie.offset.y', getProperty('zombie.offset.y') + 246)
    end
end

function onUpdatePost()
    if keyboardJustPressed('ONE') then
        restartSong()
    end

    if getProperty('tea.animation.curAnim.finished') then
        setProperty('tea.visible', false)
        setProperty('gf.visible', true)
    end

    if getProperty('robo.animation.curAnim.finished') then
        setProperty('robo.visible', false)
        setProperty('dad.visible', true)
        setProperty('camHUD.visible', true)
        doTweenZoom('socorrotabugando', 'camGame', getProperty('defaultCamZoom'), 0.6)
        setProperty('camZooming', false)
    end

    if getProperty('fever.animation.curAnim.finished') then
        setProperty('fever.visible', false)
        setProperty('boyfriend.visible', true)
    end
end

function onTimerCompleted(tag)
    if tag == 'robCut' then
        playSound('robertCutscene', 1, 'cu')
    end

    if tag == 'start' then
        startCountdown()
        stopSound('cu')
    end
end