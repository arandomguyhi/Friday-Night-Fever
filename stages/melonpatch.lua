function onCreate()
    local scary = songName == 'Retribution' or songName == 'Farmed'

    makeLuaSprite('bg', 'stages/week3/'..(scary and 'skyMoon' or 'sky'), -90, -20)
    setProperty('bg.antialiasing', true)
    scaleObject('bg', 0.7, 0.7, false)
    addLuaSprite('bg')

    makeLuaSprite('outerBuilding', 'stages/week3/mako_buildings_2', -100)
    setProperty('outerBuilding.antialiasing', true)
    setScrollFactor('outerBuilding', 0.46, 0.7)
    addLuaSprite('outerBuilding')

    makeLuaSprite('innerBuilding', 'stages/week3/mako_buildings', -100)
    setScrollFactor('innerBuilding', 0.7, 0.8)
    setProperty('innerBuilding.antialiasing', true)
    addLuaSprite('innerBuilding')

    makeLuaSprite('ground', 'stages/week3/'..(scary and 'mako_ground_2' or 'mako_ground'), -100)
    setProperty('ground.antialiasing', true)
    addLuaSprite('ground')
end