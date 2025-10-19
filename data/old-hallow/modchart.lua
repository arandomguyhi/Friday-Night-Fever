function start (song)

end

function onUpdate(elapsed)
    if curStep >= 0 then
        local currentBeat = (getSongPosition() / 1000)*(curBpm/65)
        for i=0,7 do
            local member = i > 3 and 'defaultPlayerStrum' or 'defaultOpponentStrum'
	    setProperty('strumLineNotes.members['..i..'].y', _G[member..'Y'..(i%4)] + 8 * math.cos((currentBeat + i*0.25) * math.pi))
	end
    end
end