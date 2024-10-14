// leaving this as a .hx cuz why not
var purpleOverlay:FlxSprite;

function onCreate()
{
	purpleOverlay = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.PURPLE);
	purpleOverlay.alpha = 0.0;
	purpleOverlay.scale.set(1.5, 1.5);
	purpleOverlay.scrollFactor.set();
}

function onCreatePost()
{
	add(purpleOverlay);
	FlxTween.tween(purpleOverlay, {alpha: 0.33}, 2.6);
}

function opponentNoteHit()
{
    for (note in game.notes) {
	if (note.noteType == 2)
	{
		gf.holdTimer = 0;
		gf.playAnim('sing' + dataSuffix[note.noteData] + '-alt', true);
		//note.properties.singAnim = ""; // cancel dad singing
	}
    }
}

function onStepHit(curStep:Int)
{
	if (curStep == 1390)
	{
		gf.playAnim("pull");
		remove(gf);
		getGlobalVar("phands").visible = false;
		add(gf, game.members.length);
		gf.useAlternateIdle = true;
	}

	if (curStep == 1380)
		FlxTween.tween(purpleOverlay, {alpha: 0}, 1);
}
