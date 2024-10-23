function onBeatHit()
    if curBeat == 96 then
	callScript('stages/hallow', 'changeBG')
	setVar('useDirectionalCamera', true)
    end
end