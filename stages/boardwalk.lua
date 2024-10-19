function onCreate()
    local suffix = (songName:lower() == 'throw-it-back' and '-night' or '')

    for _, i in ipairs({'sky', 'city', 'water', 'boardwalk'}) do
	makeLuaSprite('spr'.._, 'stages/week4/'..(i == 'city' and i or i..suffix), -300, -300)
	scaleObject('spr'.._, 1.4, 1.4, false)
	setProperty('spr'.._..'.antialiasing', true)
	addLuaSprite('spr'.._)
    end
end

function onCreatePost()
    scaleObject('dad', 0.8, 0.8, false)
end