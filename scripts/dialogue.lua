luaDebugMode = true

-- tried to do something cool and useful lol, ig it didn't worked
-- that's a recreation of DialogueBox.hx from Fever btw

-- DialoguePortrait shit
DialoguePortrait = {}
DialoguePortrait.__index = DialoguePortrait

DialoguePortrait.character = ''
function DialoguePortrait.new(char)
    local self = setmetatable({}, DialoguePortrait)

    local p = 'p_'..char
    makeAnimatedLuaSprite(p, 'dialogue/'..char:lower(), 0, -90)
    setProperty(p..'.antialiasing', true)
    DialoguePortrait.character = char

    runHaxeCode([[
        for (i in game.getLuaObject(']]..p..[[').frames.frames) {
            var cu = StringTools.replace(i.name, ']]..char:lower()..[[ ', '');
            if (!game.getLuaObject(']]..p..[[').animation.exists(cu))
                game.getLuaObject(']]..p..[[').animation.addByNames(cu, [i.name], 0);
        }
    ]])
    setObjectCamera(p, 'other')

    if callMethod(p..'.animation.exists', {'neutral'}) then
        playAnim(p, 'neutral')
    end

    if char == 'mega' then
        setProperty(p..'.origin.x', 0) setProperty(p..'.origin.y', 0)
        scaleObject(p, 2.4, 2.4)
        setProperty(p..'.width', getProperty(p..'.width') - 250)
        setProperty(p..'.antialiasing', false)
    else
        scaleObject(p, 0.9, 0.9)
    end

    self.spr = p
    self.ogScale = getProperty(p..'.scale.x')

    return self
end

function DialoguePortrait:jump()
    local spr, ogScale = self.spr, self.ogScale
    unjump = function()
        startTween(spr..'_unjump', spr, {['scale.y'] = ogScale, y = getProperty(spr..'.y') + 18}, 0.04, {ease = 'elasticInOut'})
    end
    startTween(spr..'_jump', spr, {['scale.y'] = ogScale + 0.025, y = getProperty(spr..'.y') - 18}, 0.05, {onComplete = 'unjump'})
end

-- now, into the actual shitttttttttttt
local fadeOut = true

local actions = {}
local curLeft
local curRight
local curPortrait

local dialogueStarted = false
local skip = false

function onCreate()
    runHaxeFunction('parseDialogue', {'data/grando/dialogue.xml'})
end

runHaxeCode([[
    import haxe.Xml;

    typedef DialogueAction =
    {
	msg:String,
	portrait:String,
	portraits:Array<String>,
	emotion:String,
	library:String,

	playSound:String,
	fadeInMus:String,
	fadeOutMus:String,
	side:String,
	fillBG:Null<FlxColor>,
	setBG:String,
	effect:String,
	narrate:Bool,
	proceedImmediately:Bool,
	showOnlyBackground:Null<Bool>,
	removePortrait:String,
	fadeBG:String,
	shake:Bool
    }

    function parseDialogue(rawDialogue:String) {
        var data = Xml.parse(Paths.getTextFromFile(rawDialogue)).firstElement();
        for (a in data.elements())
        {
            var action:DialogueAction = {};

            action.shake = (a.exists('shake') && a.get('shake').charAt(0).toLowerCase() == "t");

            if (a.exists('showOnlyBG'))
                action.showOnlyBackground = a.get('showOnlyBG').charAt(0).toLowerCase() == 't' ? true : false;
            else
                action.showOnlyBackground = null;

            if (a.exists('removePortrait'))
                action.removePortrait = a.get('removePortrait');

            if (a.exists('portrait') || a.exists('portraits')) {
                if (a.exists('portraits')) {
                    var s = a.get('portraits').split(',');
                    for (i in s)
                        parentLua.call('addPortrait', [i]);
                    action.portraits = s;
                } else {
                    var portrait = a.get('portrait');
                    action.portrait = portrait;
                    parentLua.call('addPortrait', [portrait]);

                    if (a.exists('side'))
                        action.side = a.get('side').toLowerCase().charAt(0) == 'r' ? 'RIGHT' : 'LEFT';
                }
            }

            if (a.exists('emotion'))
                action.emotion = a.get('emotion').toLowerCase();

            if (a.exists('msg')) {
                if (a.get('msg').length < 1)
                    action.msg = '...'
                else
                    action.msg = StringTools.replace(StringTools.replace(a.get('msg'), '´', "'"), "&quot;", '"');
            } else if (a.exists('narrate')) {
                action.msg = a.get('narrate');
                action.narrate = true;
            }
        }
    }
]])