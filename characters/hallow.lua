luaDebugMode = true
function onCreatePost()
    runHaxeCode([[
	var evilTrail = new flixel.addons.effects.FlxTrail(dad, null, 4, 24, 0.3, 0.069);
	addBehindGF(evilTrail);
	setVar('evilTrail', evilTrail);
    ]])
end

local floatY = 0
function onUpdate(elapsed)
    floatY = floatY + 0.07
    setProperty('dad.y', getProperty('dad.y') + math.sin(floatY))

    runHaxeCode("getVar('evilTrail').visible = dad.animation.curAnim.name == 'idle' ? false : true;")
end

function opponentNoteHit()
    if getProperty('healthBar.percent') > 5 then
	setProperty('health', getProperty('health') - 0.025)
    end
end