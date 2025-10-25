--luaDebugMode = true

dofile('mods/'..currentModDirectory..'/scripts/states/internal/InteractableState.lua')

local hey = InteractableState.new()

local options = Interactable.new('newMain/options', 915.5, 580.55, 1, 'options notselected', 'options selected',
    InteractHitbox.new(915.5, 580.55, 365, 105), {0, 34})
options.callback = function()
    debugPrint('OPTIOOONS')
end
hey:addInteractable(options)

local credits = Interactable.new('newMain/credits', -10, 45, 1, 'credits notselected', 'credits selected', InteractHitbox.new(40, 175, 225, 525),
{216, 172}, true, 'newMain/creditstext', 'credits text', {300, 140})
credits.callback = function()
    debugPrint('CREDITSSSSSSSSSSSS')
end
hey:addInteractable(credits)

function onUpdate(elapsed)
    hey:update(elapsed)
end

addLuaSprite(hey.hand, true)