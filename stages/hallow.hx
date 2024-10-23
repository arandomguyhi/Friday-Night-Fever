// for some reason it was lookin ass on lua, so i changed to hscript
// i'm changing this to lua later, im just to lazy rn
var wiggle;
function onCreate() {
    game.initLuaShader('WiggleEffect');
    wiggle = game.createRuntimeShader('WiggleEffect');

    wiggle.setInt('effectType', 1);
    wiggle.setFloat('uWaveAmplitude', 0.025);
    wiggle.setFloat('uFrequency', 3);
    wiggle.setFloat('uSpeed', 1);

    game.getLuaObject('painting').shader = wiggle;
}

var merda:Float = 0;
function onUpdate(elapsed) {
    merda += elapsed;
    wiggle.setFloat('uTime', merda);
}