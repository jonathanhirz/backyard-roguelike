import luxe.Input;
import luxe.Sprite;
import luxe.Color;
import luxe.Vector;
import luxe.States;
import luxe.collision.Collision;
import luxe.collision.shapes.*;
import luxe.collision.data.*;

class MenuState extends State {

    public function new( _name:String ) {
        super({ name:_name });
    } //new

    override function init() {


    } //init

    override function onenter<T>( _value:T ) {


    } //onenter

    override function onleave<T>( _value:T ) {


    } //onleave

} //MenuState

class PlayState extends State {

    var player : Sprite;
    var child : Sprite;

    public function new( _name:String ) {
        super({ name:_name });
    } //new

    override function init() {


    } //init

    override function onenter<T>( _value:T ) {

        var background = new Sprite({
            pos : Luxe.screen.mid,
            size : new Vector(500, 500),
            color : new Color().rgb(0x198810)
        }); //background

        player = new Sprite({
            pos : Luxe.screen.mid,
            size : new Vector(30, 50),
            color : new Color().rgb(0x1400b7)
        }); //player
        player.add(new PlayerControls());
        player.add(new Collider());

        child = new Sprite({
            pos : new Vector(player.pos.x + 30, player.pos.y -10),
            size : new Vector(15,25),
            color : new Color().rgb(0x1526b3)
        }); //child
        child.add(new Collider());


    } //onenter

    override function onleave<T>( _value:T ) {


    } //onleave

} //PlayState

class Main extends luxe.Game {

    var machine : States;
    public static var block_collider_pool : Array<Shape>;

    override function config(config:luxe.AppConfig) {

        return config;

    } //config

    override function ready() {

        connect_input();
        block_collider_pool = [];
        machine = new States({ name:'statemachine' });
        machine.add(new MenuState('menu_state'));
        machine.add(new PlayState('play_state'));
        machine.set('play_state');

    } //ready

    override function onkeyup( e:KeyEvent ) {

        if(e.keycode == Key.escape) {
            Luxe.shutdown();
        }

    } //onkeyup

    override function update(dt:Float) {


    } //update

    function connect_input() {

        Luxe.input.bind_key('up', Key.up);
        Luxe.input.bind_key('up', Key.key_w);
        Luxe.input.bind_key('right', Key.right);
        Luxe.input.bind_key('right', Key.key_d);
        Luxe.input.bind_key('down', Key.down);
        Luxe.input.bind_key('down', Key.key_s);
        Luxe.input.bind_key('left', Key.left);
        Luxe.input.bind_key('left', Key.key_a);
        Luxe.input.bind_key('attack', Key.space);
        Luxe.input.bind_key('toggle_collider', Key.key_t);

    } //connect_input


} //Main
