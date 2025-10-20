setVar('directionalCameraDist', 15)
local animIndex = {{-1, 0}, {0, 1}, {0, -1}, {1, 0}}

function onCreatePost()
    runHaxeCode([[
	createGlobalCallback('snapCamera', function(xpos:Float, ypos:Float, isForced:Bool) {
	    game.camFollow.setPosition(xpos, ypos);
            game.camGame.snapToTarget();
	    game.isCameraOnForcedPos = isForced;
	});
    ]])
end

setVar('useDirectionalCamera', false)
function onUpdate()
    dadCamX = runHaxeCode("return dad.getMidpoint().x + 150 + dad.cameraPosition[0] + opponentCameraOffset[0];") -- doing with rhc cuz im lazy
    dadCamY = runHaxeCode("return dad.getMidpoint().y - 100 + dad.cameraPosition[1] + opponentCameraOffset[1];")
    bfCamX = runHaxeCode("return boyfriend.getMidpoint().x - 100 - boyfriend.cameraPosition[0] + boyfriendCameraOffset[0];")
    bfCamY = runHaxeCode("return boyfriend.getMidpoint().y - 100 + boyfriend.cameraPosition[1] + boyfriendCameraOffset[1];")
    gfCamX = runHaxeCode("return gf.getMidpoint().x + gf.cameraPosition[0] + girlfriendCameraOffset[0];")
    gfCamY = runHaxeCode("return gf.getMidpoint().y + gf.cameraPosition[1] + girlfriendCameraOffset[1];")

    setVar('dadCamX', dadCamX) setVar('dadCamY', dadCamY) setVar('bfCamX', bfCamX) setVar('bfCamY', bfCamY) setVar('gfCamX', gfCamX) setVar('gfCamY', gfCamY)
end

function onUpdatePost()
    if getProperty('isCameraOnForcedPos') or not getVar('useDirectionalCamera') then return end

    for i = 0, 3 do
	if stringStartsWith(getProperty((mustHitSection and 'boyfriend' or 'dad')..'.animation.curAnim.name'), getProperty('singAnimations')[i+1]) then
	    setProperty('camFollow.x', (mustHitSection and bfCamX or dadCamX) + animIndex[i+1][1] * getVar('directionalCameraDist'))
	    setProperty('camFollow.y', (mustHitSection and bfCamY or dadCamY) + animIndex[i+1][2] * getVar('directionalCameraDist'))
	elseif stringStartsWith(getProperty((not mustHitSection and 'dad' or 'boyfriend')..'.animation.curAnim.name'), 'idle') then
	    setProperty('camFollow.x', not mustHitSection and dadCamX or bfCamX) setProperty('camFollow.y', mustHitSection and bfCamY or dadCamY)
	end
    end
end