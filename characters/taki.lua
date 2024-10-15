local iconHurtTimer = 0

luaDebugMode = true
function onUpdatePost(elapsed)
    iconHurtTimer = iconHurtTimer - elapsed

    if getHealth() >= 1.75 and iconHurtTimer <= 0 then
	setProperty('iconP2.animation.curAnim.curFrame', 1)
	setProperty('iconP1.animation.curAnim.curFrame', 2)
    elseif getHealth() <= 0.65 or iconHurtTimer > 0 then -- this is for taki
	setProperty('iconP2.animation.curAnim.curFrame', 2)
	setProperty('iconP1.animation.curAnim.curFrame', 1)
    else
	setProperty('iconP2.animation.curAnim.curFrame', 0)
	setProperty('iconP1.animation.curAnim.curFrame', 0)
    end
end

function opponentNoteHit(id, noteData, noteType, isSustainNote)
    iconHurtTimer = 0.45
    local mult = difficultyName:lower() == 'hard' and 0.6 or 1
    if songName == 'Prayer' then
	if curStep >= 1359 and curStep < 1422 then
	    setProperty('health', getProperty('health') - 0.0215) elseif curStep < 1681 then
	    setProperty('health', getProperty('health') - (getProperty('health') > 0.165 and 0.0165 * mult or 0.0065 * mult)) end
    elseif songName == 'Crucify' then
	setProperty('health', getProperty('health') - (isSustainNote and 0.01 or 0.025 * mult))
    elseif songName == 'Bazinga' then
	setProperty('health', getProperty('health') - (isSustainNote and 0.01435 or 0.025 * mult))
    else
	setProperty('health', getProperty('health') - 0.02 * mult)
    end

    playAnim('gf', 'scared')
end