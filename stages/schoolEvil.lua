luaDebugMode = true
function onCreate()
    local posX = 400
    local posY = 200

    makeAnimatedLuaSprite('bg', 'stages/week6/weeb/animatedEvilSchool', posX, posY)
    addAnimationByPrefix('bg', 'idle', 'background 2', 24)
    playAnim('bg', 'idle')
    setScrollFactor('bg', 0.8, 0.9)
    scaleObject('bg', 6, 6, false)
    addLuaSprite('bg')

    createInstance('meat', 'objects.Character', {260, 100.9, 'meat'})
    addInstance('meat')
end

function onCreatePost()
    setScrollFactor('boyfriend', 0.9, 0.9)
    setScrollFactor('gf', 0.9, 0.9)

    setObjectOrder('meat', getObjectOrder('dadGroup')-1)
    callMethodFromClass('flixel.tweens.FlxTween', 'circularMotion', {instanceArg('meat'), 300, 200, 50, 0, true, 4, true, {type = 2}})
end

function opponentNoteHit(id, noteData, noteType, isSustainNote)
    setProperty('meat.holdTimer', 0)
    playAnim('meat', getProperty('singAnimations')[noteData+1], true)
    setProperty('health', getProperty('health') - (difficultyName:lower() == 'hard' and 0.02 or 0.01))
end

function onBeatHit()
    if curBeat % 2 == 0 and getProperty('meat.animation.curAnim.name') == 'idle' then
	callMethod('meat.dance', {''})
    end
end