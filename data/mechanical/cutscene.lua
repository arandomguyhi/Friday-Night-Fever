function onCreate()
    setProperty('defaultCamZoom', 1)
    setProperty('camGame.zoom', 1)
    setProperty('camHUD.visible', false)
end

function onCreatePost()
    setProperty('dad.x', getProperty('dad.x') - 800)

    startTween('dadTween', 'dad', {x = getProperty('dad.x') + 800}, 1.2, {ease = 'quadInOut'})
	playSound('stoneslide', 1)
	playAnim('dad', 'arrive', true)
	runHaxeCode([[
	    dad.animation.finishCallback = function(a) {
		dad.animation.finishCallback = null;
		game.startCountdown();
		camHUD.visible = true;
	    }
	]])
end

function onStartCountdown()
    if not allowCountdown then
	allowCountdown = true
	return Function_Stop
    end
    return Function_Continue
end

function onUpdate()
    if getProperty('dad.animation.curAnim.name') == 'arrive' and not getProperty('hands.visible') and getProperty('dad.animation.curAnim.curFrame') >= 35 then
	setProperty('hands.visible', true)
	playAnim('hands', 'come', true)
    end
end