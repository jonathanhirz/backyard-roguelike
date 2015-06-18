import luxe.Input;
import luxe.Sprite;
import luxe.Color;
import luxe.Vector;
import luxe.States;

class Main extends luxe.Game {

    var machine : States;

    override function config( config:luxe.AppConfig ) {

        config.preload.textures.push({ id:'assets/player.png' });
        config.preload.textures.push({ id:'assets/enemy.png' });
        config.preload.textures.push({ id:'assets/tileset_backyard.png' });

        config.preload.texts.push({ id:'assets/tilemap_backyard.xml' });

        return config;

    } //config

    override function ready() {

        machine = new States({ name:'statemachine' });
        machine.add(new MenuState('menu_state'));
        machine.add(new PlayState('play_state'));
        machine.add(new GameOverState('gameover_state'));
        machine.set('menu_state');

        Luxe.camera.zoom = 0.5;

    } //ready

    override function onkeyup(e:KeyEvent) {

        if(e.keycode == Key.escape) {
            Luxe.shutdown();
        }

    } //onkeyup

    override function update(dt:Float) {


    } //update

} //Main
