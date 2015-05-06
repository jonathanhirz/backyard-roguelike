import luxe.Input;
import luxe.Sprite;
import luxe.Color;
import luxe.Vector;
import luxe.States;

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

    public function new( _name:String ) {
        super({ name:_name });
    } //new

    override function init() {


    } //init

    override function onenter<T>( _value:T ) {

        var player = new Sprite({
            pos : Luxe.screen.mid,
            size : new Vector(100, 100),
            color : new Color().rgb(0x21bc36)
        }); //player
        player.add(new PlayerControls());


    } //onenter

    override function onleave<T>( _value:T ) {


    } //onleave

} //PlayState

class Main extends luxe.Game {

    var machine : States;

    override function config(config:luxe.AppConfig) {

        return config;

    } //config

    override function ready() {

        connect_input();
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

    } //connect_input


} //Main
