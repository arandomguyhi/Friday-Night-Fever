function onCreate()
    setProperty('camZoomingMult', 0)
    setCamZoom(1)
end

function onUpdate(elapsed)
    if curStep >= 248 and curStep < 256 then
	local currentBeat = (getSongPosition() / 1000)*(curBpm/120)
	for i=0,7 do
	    local note = i > 3 and 'defaultPlayerStrum' or 'defaultOpponentStrum'
	    setProperty((i > 3 and 'playerStrums' or 'opponentStrums')..'.members['..(i%4)..'].x', _G[note..'X'..(i%4)] + 200 * math.sin((currentBeat + i*25) * math.pi))
	    setProperty((i > 3 and 'playerStrums' or 'opponentStrums')..'.members['..(i%4)..'].y', _G[note..'Y'..(i%4)] + 100 * math.sin((currentBeat + i*50) * math.pi))
	end
    end

    if curStep >= 256 and curStep < 272 then
	local currentBeat = (getSongPosition() / 1000)*(curBpm/240)
	for i=0,7 do
	    local note = i > 3 and 'defaultPlayerStrum' or 'defaultOpponentStrum'
	    startTween('culol'..i, (i > 3 and 'playerStrums' or 'opponentStrums')..'.members['..(i%4)..']', {x = _G[note..'X'..(i%4)], y = _G[note..'Y'..(i%4)], angle = 0}, 0.6, {})
	end
    end

    if curStep >= 520 and curStep < 632 then -- wind thing
	local currentBeat = (getSongPosition() / 1000)*(curBpm/120)
	for i=0,7 do
	    local note = i > 3 and 'defaultPlayerStrum' or 'defaultOpponentStrum'
	    setProperty((i > 3 and 'playerStrums' or 'opponentStrums')..'.members['..(i%4)..'].y', _G[note..'Y'..(i%4)] + 5 * math.sin((currentBeat + i*50) * math.pi))
	    setProperty((i > 3 and 'playerStrums' or 'opponentStrums')..'.members['..(i%4)..'].x', _G[note..'X'..(i%4)] + 20 * math.cos((currentBeat + i*50) * math.pi))
	end
    end

    if curStep >= 632 and curStep < 640 then -- sonicsonic
	local currentBeat = (getSongPosition() / 1000)*(curBpm/240)
	for i=0,7 do
	    local note = i > 3 and 'defaultPlayerStrum' or 'defaultOpponentStrum'
	    setProperty((i > 3 and 'playerStrums' or 'opponentStrums')..'.members['..(i%4)..'].x', _G[note..'X'..(i%4)] + 300 * math.sin((currentBeat + i*25) * math.pi))
	    setProperty((i > 3 and 'playerStrums' or 'opponentStrums')..'.members['..(i%4)..'].y', _G[note..'Y'..(i%4)] + 50 * math.cos((currentBeat + i*0.25) * math.pi))
	end
    end
	
    if curStep >= 640 and curStep < 704 then -- return
	local currentBeat = (getSongPosition() / 1000)*(curBpm/1000)
	for i=0,7 do
	    local note = i > 3 and 'defaultPlayerStrum' or 'defaultOpponentStrum'
	    startTween('culol'..i, (i > 3 and 'playerStrums' or 'opponentStrums')..'.members['..(i%4)..']', {x = _G[note..'X'..(i%4)], y = _G[note..'Y'..(i%4)], angle = 0}, 0.6, {})
	end
    end
end

function setCamZoom(targetZoom)
    setProperty('camGame.zoom', targetZoom)
end