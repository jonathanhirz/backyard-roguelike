import luxe.States;
import luxe.Input;
import luxe.Text;
import luxe.Color;
import luxe.Vector;

class MenuState extends State {

    var title : Text;
    var title_shader : phoenix.Shader;
    var subtitle : Text;
    var instructions : Text;

    public function new(_name:String) {

        super({ name:_name });

        title_shader = Luxe.renderer.shaders.bitmapfont.shader.clone('title_shader');
        title = new Text({
            text : 'BYRL',
            point_size : 200,
            pos : new Vector(Luxe.screen.w/2, -160),
            align : center,
            sdf : true,
            shader : title_shader,
            outline : 0.8,
            outline_color : new Color().rgb(0x359055)
        });

        subtitle = new Text({
            text : '\'backyard roguelike\'',
            point_size : 60,
            pos : new Vector(Luxe.screen.w/2, 80),
            align : center,
            sdf : true,
            shader : title_shader,
            outline : 0.8,
            outline_color : new Color().rgb(0x359055)
        });

        instructions = new Text({
            text : 'Carry your child to the gate. \nArrow keys or WASD to move&attack, SPACE to wait. \n \nPress SPACE to start.',
            pos : Luxe.screen.mid,
            align : center,
            point_size : 50
        });

    } //new

    override function init() {


    } //init

    override function onenter<T>(_value:T) {

        connect_input();


    } //onenter

    override function onleave<T>(_value:T) {

        title.destroy();
        subtitle.destroy();
        instructions.destroy();


    } //onleave

    override function update(dt:Float) {
        if(Luxe.input.inputpressed('skip')) {
            machine.set('play_state');
        }
    }

    function connect_input() {

        Luxe.input.bind_key('up', Key.up);
        Luxe.input.bind_key('up', Key.key_w);
        Luxe.input.bind_key('right', Key.right);
        Luxe.input.bind_key('right', Key.key_d);
        Luxe.input.bind_key('down', Key.down);
        Luxe.input.bind_key('down', Key.key_s);
        Luxe.input.bind_key('left', Key.left);
        Luxe.input.bind_key('left', Key.key_a);
        Luxe.input.bind_key('skip', Key.space);
        Luxe.input.bind_key('toggle_collider', Key.key_t);
        Luxe.input.bind_key('toggle_held', Key.enter);

    } //connect_input


} //MenuState