function onCreatePost()
    setProperty('camZoomingMult', 0)
    addCharacterToList('hallow-dum', 'dad')
    callScript('stages/hallow', 'changeBG')
end

function onStepHit()
    if curStep == 1936 then
	cameraFade('camGame', '000000', 0.2)
    end

    if curStep == 1952 then
	setProperty('inCutscene', true)
	triggerEvent('Change Character', 'dad', 'hallow-dum')
	makeVideoSprite('hallow', 'soul', 0, 0, 'camHUD')
    end
end
