function onCreate()
    precacheImage('noteSkins/hallowNotes') -- i feel it lags a bit when it comes for the first time
end

function onSpawnNote()
    -- yes i know i don't need the loop here
    for i = 0, getProperty('notes.length')-1 do
	if getPropertyFromGroup('notes', i, 'noteType') == 'Hallow' then
	    setPropertyFromGroup('notes', i, 'texture', 'noteSkins/hallowNotes')
	    setPropertyFromGroup('notes', i, 'noAnimation', getProperty('notes.members['..i..'].mustPress'))
	end
    end
end

function onUpdate()
    -- this is maybe so freakin dumb but who cares
    if getProperty('boyfriend.animation.curAnim.name') == 'dodge' then
	for i = 0, getProperty('notes.length')-1 do
	    if getPropertyFromGroup('notes', i, 'mustPress') then
		setPropertyFromGroup('notes', i, 'noAnimation', true)

		if getProperty('boyfriend.animation.curAnim.curFrame') > 3 then --idk i just choosed a random frame
		    setPropertyFromGroup('notes', i, 'noAnimation', false)
		end
	    end
	end
    end
end

function goodNoteHit(id, noteData, noteType, isSustainNote)
    if noteType == 'Hallow' then
	playAnim('boyfriend', 'dodge', true)
	setProperty('boyfriend.specialAnim', true)
    end
end