import luxe.Input;
import luxe.Sprite;
import luxe.Color;
import luxe.Vector;
import luxe.States;
import luxe.tween.Actuate;

class Main extends luxe.Game {

    var machine : States;

    override function config( config:luxe.AppConfig ) {

        config.preload.textures.push({ id:'assets/player.png' });
        config.preload.textures.push({ id:'assets/enemy.png' });
        config.preload.textures.push({ id:'assets/tiles.png' });

        config.preload.texts.push({ id:'assets/tilemap.tmx' });

        return config;

    } //config

    override function ready() {

        machine = new States({ name:'statemachine' });
        machine.add(new MenuState('menu_state'));
        machine.add(new PlayState('play_state'));
        machine.set('play_state');
        Luxe.camera.zoom = 0.5;
        Actuate.tween(Luxe.camera, 0.5, { zoom:1 });

    } //ready

    override function onkeyup(e:KeyEvent) {

        if(e.keycode == Key.escape) {
            Luxe.shutdown();
        }

    } //onkeyup

    override function update(dt:Float) {


    } //update

} //Main
