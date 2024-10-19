function onCreate()
    setProperty('camZoomingMult', 0) setProperty('camZooming', true)
    setCamZoom(1)
end

function onUpdate(elapsed)
    if curStep >= 128 and curStep < 256 then
	local currentBeat = (getSongPosition() / 1000)*(curBpm/30)
	for i=0,7 do
	    local member = i > 3 and 'defaultPlayerStrum' or 'defaultOpponentStrum'
	    setProperty('strumLineNotes.members['..i..'].x', _G[member..'X'..(i%4)] + 5 * math.sin((currentBeat + i*50) * math.pi))
	end
    end

    if curStep >= 640 and curStep < 768 then
	local currentBeat = (getSongPosition() / 1000)*(curBpm/30)
	for i=0,7 do
	    local member = i > 3 and 'defaultPlayerStrum' or 'defaultOpponentStrum'
	    setProperty('strumLineNotes.members['..i..'].x', _G[member..'X'..(i%4)] + 5 * math.sin((currentBeat + i*50) * math.pi))
	end
    end

    if curStep == 384 then
	setCamZoom(1.1)
	setHudZoom(1.1)
    end

    if curStep == 396 then
	setCamZoom(1.1)
	setHudZoom(1.1)
    end

    if curStep == 416 then
	setCamZoom(1.1)
	setHudZoom(1.1)
    end

    if curStep == 428 then
	setCamZoom(1.1)
	setHudZoom(1.1)
    end
	
    if curStep == 448 then
	setCamZoom(1.1)
	setHudZoom(1.1)
    end

    if curStep == 460 then
	setCamZoom(1.1)
	setHudZoom(1.1)
    end

    if curStep == 480 then
	setCamZoom(1.1)
	setHudZoom(1.1)
    end

    if curStep == 492 then
	setCamZoom(1.1)
	setHudZoom(1.1)
    end

    if curStep == 896 then
	setCamZoom(1.1)
	setHudZoom(1.1)
    end

    if curStep == 908 then
	setCamZoom(1.1)
	setHudZoom(1.1)
    end

    if curStep == 928 then
	setCamZoom(1.1)
	setHudZoom(1.1)
    end

    if curStep == 940 then
	setCamZoom(1.1)
	setHudZoom(1.1)
    end


    if curStep == 960 then
	setCamZoom(1.1)
	setHudZoom(1.1)
    end

    if curStep == 972 then
	setCamZoom(1.1)
	setHudZoom(1.1)
    end

    if curStep == 992 then
	setCamZoom(1.1)
	setHudZoom(1.1)
    end

    if curStep == 1004 then
	setCamZoom(1.1)
	setHudZoom(1.1)
    end
	
    if curStep == 1408 then
	setCamZoom(1.1)
	setHudZoom(1.1)
    end

    if curStep == 1420 then
	setCamZoom(1.1)
	setHudZoom(1.1)
    end

    if curStep == 1440 then
	setCamZoom(1.1)
	setHudZoom(1.1)
    end

    if curStep == 1452 then
	setCamZoom(1.1)
	setHudZoom(1.1)
    end


    if curStep == 1472 then
	setCamZoom(1.1)
	setHudZoom(1.1) 
    end

    if curStep == 1484 then
	setCamZoom(1.1)
	setHudZoom(1.1)
    end

    if curStep == 1504 then
	setCamZoom(1.1)
	setHudZoom(1.1)
    end

    if curStep == 1516 then
	setCamZoom(1.1)
	setHudZoom(1.1)
    end
end


function setCamZoom(zoomAmount)
    setProperty('camGame.zoom', zoomAmount)
end

function setHudZoom(zoomAmount)
    setProperty('camHUD.zoom', zoomAmount)
end