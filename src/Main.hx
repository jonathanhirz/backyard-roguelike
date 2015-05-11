import luxe.Input;
import luxe.Sprite;
import luxe.Color;
import luxe.Vector;
import luxe.States;
import phoenix.Texture;
import phoenix.Texture.FilterType;
import luxe.collision.Collision;
import luxe.collision.shapes.*;
import luxe.collision.data.*;

class MenuState extends State {

    public function new(_name:String) {

        super({ name:_name });

    } //new

    override function init() {


    } //init

    override function onenter<T>(_value:T) {


    } //onenter

    override function onleave<T>(_value:T) {


    } //onleave


} //MenuState


class PlayState extends State {

    var player : Sprite;
    var player_texture : Texture;
    var child : Sprite;

    public function new(_name:String) {

        super({ name:_name });

    } //new

    override function init() {

    } //init

    override function onenter<T>(_value:T) {

        var background = new Sprite({
            pos : Luxe.screen.mid,
            size : new Vector(500, 500),
            color : new Color().rgb(0x198810)
        }); //background

        if(player_texture == null) player_texture = Luxe.resources.texture('assets/player.png');
        player = new Sprite({
            name : 'player',
            texture : player_texture,
            pos : Luxe.screen.mid,
        }); //player
        // player.add(new PlayerControls());
        player.add(new PlayerControlsGrid());
        player.add(new Collider('player_collider'));

        child = new Sprite({
            pos : new Vector(player.pos.x + 30, player.pos.y -10),
            size : new Vector(15,25),
            color : new Color().rgb(0x675fd5),
            depth : 1
        }); //child
        child.add(new ChildBehavior('child_behavior'));
        child.add(new Collider('child_collider'));

    } //onenter

    override function onleave<T>(_value:T) {


    } //onleave

    override function update(dt:Float) {

        var player_child_col = Collision.shapeWithShape(player.get('player_collider').block_collider, child.get('child_collider').block_collider);
        if(player_child_col != null) {
            child.get('child_behavior').is_held = true;
        }

    } //update


} //PlayState


class Main extends luxe.Game {

    var machine : States;
    public static var block_collider_pool : Array<Shape>;

    override function config( config:luxe.AppConfig ) {

        config.preload.textures.push({ id:'assets/player.png' });
        return config;

    } //config

    override function ready() {

        block_collider_pool = [];
        machine = new States({ name:'statemachine' });
        machine.add(new MenuState('menu_state'));
        machine.add(new PlayState('play_state'));
        machine.set('play_state');

    } //ready

    override function onkeyup(e:KeyEvent) {

        if(e.keycode == Key.escape) {
            Luxe.shutdown();
        }

    } //onkeyup

    override function update(dt:Float) {


    } //update


} //Main
