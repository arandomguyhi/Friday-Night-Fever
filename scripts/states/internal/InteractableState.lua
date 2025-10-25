--luaDebugMode = true

InteractableState = {}
InteractableState.__index = InteractableState

function InteractableState.new()
    local self = setmetatable({}, InteractableState)

    self.allowInput = true
    self.curSelected = nil
    self.interactables = {}
    self.order = {}

    self.hand = 'hand_'
    makeAnimatedLuaSprite(self.hand, 'newMain/cursor', getMouseX('camHUD'), getMouseY('camHUD'))
    addAnimationByPrefix(self.hand, 'idle', 'cursor nonselect', 0)
    addAnimationByPrefix(self.hand, 'select', 'cursor select', 0)
    addAnimationByPrefix(self.hand, 'qidle', 'cursor qnonselect', 0)
    addAnimationByPrefix(self.hand, 'qselect', 'cursor qselect', 0)
    playAnim(self.hand, 'idle')
    setGraphicSize(self.hand, getProperty(self.hand..'.width') / 1.5, getProperty(self.hand..'.height') / 1.5)
    setProperty(self.hand..'.antialiasing', true)
    setObjectCamera(self.hand, 'camHUD')

    return self
end

function InteractableState:update(elapsed)
    if getPropertyFromClass('flixel.FlxG', 'mouse.justMoved') then
        setProperty(self.hand..'.x', getMouseX('camHUD'))
        setProperty(self.hand..'.y', getMouseY('camHUD'))
    end

    if self.allowInput and keyJustPressed('left') then
        self:moveSelection(-1)
        local cur = self.order[index]
        setProperty(self.hand..'.x', getProperty(cur..'.x') + (getProperty(cur..'.width') / 2))
        setProperty(self.hand..'.y', getProperty(cur..'.y') + (getProperty(cur..'.height') / 2))
    elseif self.allowInput and keyJustPressed('right') then
        self:moveSelection(1)
        local cur = self.order[index]
        setProperty(self.hand..'.x', getProperty(cur..'.x') + (getProperty(cur..'.width') / 2) - (getProperty(self.hand..'.width') / 2))
        setProperty(self.hand..'.y', getProperty(cur..'.y') + (getProperty(cur..'.height') / 2) - (getProperty(self.hand..'.height') / 2))
    end

    if mouseClicked('left') or (keyboardJustPressed('ENTER') or keyboardJustPressed('SPACE')) then
        playAnim(self.hand, self.curSelected and 'qselect' or 'select')
        setProperty(self.hand..'.offset.y', self.curSelected and 34 or 8)

        if self.curSelected ~= nil and (mouseClicked('left') or (keyboardJustPressed('ENTER') or keyboardJustPressed('SPACE'))) then
            self:onMouseClick(self.curSelected)
        end
    else
        playAnim(self.hand, self.curSelected and 'qidle' or 'idle')
        setProperty(self.hand..'.offset.y', self.curSelected and 24 or 0)
    end

    for i, item in ipairs(self.interactables) do
        local mx, my = getMouseX('camHUD') + getProperty('camHUD.scroll.x'), getMouseY('camHUD') + getProperty('camHUD.scroll.x')
        local hb = item.hitbox

        if hb and hb.spr then
            local x, y = getProperty(hb.spr..'.x'), getProperty(hb.spr..'.y')
            local w, h = getProperty(hb.spr..'.width'), getProperty(hb.spr..'.height')

            local over = (mx > x) and (mx < x + w) and (my > y) and (my < y + h)
            if over then
                if self.curSelected ~= item then
                    self:onMouseHover(item)
                end
                if mouseClicked('left') then
                    self:onMouseClick(item)
                end
            elseif self.curSelected == item then
                self:onMouseLeave(item)
            end
        end
    end
end

function InteractableState:moveSelection(dir)
    if #self.order == 0 then return end

    local index = 1
    if self.curSelected ~= nil then
        for i, obj in ipairs(self.order) do
            if obj == self.curSelected then
                index = i
                break
            end
        end
    end

    index = index + dir
    if index < 1 then index = #self.order end
    if index > #self.order then index = 1 end

    if self.curSelected then
        self:onMouseLeave(self.order[index])
    end
    self.curSelected = self.order[index]
    self:onMouseHover(self.curSelected)
end

function InteractableState:addInteractable(item)
    addLuaSprite(item.spr, true)

    if item.text ~= nil then
        addLuaSprite(item.text, true)
    end

    table.insert(self.interactables, item)
    table.insert(self.order, item)
end

function InteractableState:onMouseClick(item)
    if not self.allowInput then return end

    if item.callback ~= nil then
        self.allowInput = false
        item.callback()
    end
end

function InteractableState:onMouseHover(item)
    if not self.allowInput then return end

    if getProperty(item.spr..'.animation.curAnim.name') ~= 'selected' and getProperty(item.spr..'.animation.curAnim.name') == 'idle' then
        item:playAnim('selected')
        self.curSelected = item

        if item.sound then
            playSound('menu/'..item.sound..'-interact')
        end
    end
end

function InteractableState:onMouseLeave(item)
    if getProperty(item.spr..'.animation.curAnim') ~= nil and getProperty(item.spr..'.animation.curAnim.name') == 'selected' then
        item:playAnim('idle')
        self.curSelected = nil
    end
end



MenuBG = {}
MenuBG.__index = MenuBG

function MenuBG.new(img, x, y, scale)
    local self = setmetatable({}, MenuBG)
    scale = scale or 1

    self.spr = 'menuBG_'..img
    makeLuaSprite(self.spr, img, x, y)
    setProperty(self.spr..'.antialiasing', true)

    if scale ~= 1 then
        setProperty(self.spr..'.origin.x', 0) setProperty(self.spr..'.origin.y', 0)
        scaleObject(self.spr, scale, scale, false)
    end

    setObjectCamera(self.spr, 'camHUD')

    return self
end



Interactable = {}
Interactable.__index = Interactable

Interactable.selectOffset = {0, 0}

function Interactable.new(img, x, y, scale, unselectAnim, selectAnim, hitbox, selectOffset, loopSelect, textImg, textAnim, textLoc, textScale)
    local self = setmetatable({}, Interactable)

    self.callback = nil
    self.sound = 'general'
    loopSelect = loopSelect or false

    scale = scale or 1
    self.spr = 'interactable_'..img
    makeAnimatedLuaSprite(self.spr, img, x, y)
    setProperty(self.spr..'.antialiasing', true)
    addAnimationByPrefix(self.spr, 'idle', unselectAnim, 24, true)
    addAnimationByPrefix(self.spr, 'selected', selectAnim, 24, loopSelect)
    playAnim(self.spr, 'idle')
    setObjectCamera(self.spr, 'camHUD')

    self.hitbox = hitbox
    hitbox.parent = self

    if scale ~= 1 then
        setProperty(self.spr..'.origin.x', 0) setProperty(self.spr..'.origin.y', 0)
        scaleObject(self.spr, scale, scale, false)
    end

    if selectOffset ~= nil then
        self.selectOffset = selectOffset
    end

    if textLoc ~= nil then
        textScale = textScale or 1
        self.text = 'text_'..textImg

        makeAnimatedLuaSprite(self.text, textImg, textLoc[1], textLoc[2])
        addAnimationByPrefix(self.text, 'anim', textAnim, 24, false)
        playAnim(self.text, 'anim')
        setProperty(self.text..'.antialiasing', true)
        setProperty(self.text..'.visible', false)
        setProperty(self.text..'.ID', 420)
        setObjectCamera(self.text, 'camHUD')

        setProperty(self.text..'.origin.x', 0) setProperty(self.text..'.origin.y', 0)
        scaleObject(self.text, textScale == 1 and scale or textScale)
    end

    return self
end

function Interactable:playAnim(name)
    playAnim(self.spr, name, true)
    if name == 'selected' then
        setProperty(self.spr..'.offset.x', self.selectOffset[1])
        setProperty(self.spr..'.offset.y', self.selectOffset[2])
        if self.text ~= nil then
            setProperty(self.text..'.visible', true)
            playAnim(self.text, 'anim', true)
        end
    else
        setProperty(self.spr..'.offset.x', 0)
        setProperty(self.spr..'.offset.y', 0)
        if self.text ~= nil then
            setProperty(self.text..'.visible', false)
        end
    end
end



InteractHitbox = {}
InteractHitbox.__index = InteractHitbox

function InteractHitbox.new(x, y, w, h)
    local self = setmetatable({}, InteractHitbox)
    self.spr = 'hitbox_'..w..'_'..h
    makeLuaSprite(self.spr, nil, x, y)
    makeGraphic(self.spr, w, h, '000000')
    setProperty(self.spr..'.alpha', 0.001)
    setObjectCamera(self.spr, 'camHUD')
    self.parent = nil
    return self
end


return InteractableState