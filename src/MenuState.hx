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

    } //new

    override function init() {


    } //init

    override function onenter<T>(_value:T) {

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
            text : 'Carry your child to the gate. \nEnemies will knock your child out of your hands and hurt you. \n \nArrow keys or WASD to move & attack, SPACE to wait. \n \nPress any key to start.',
            pos : Luxe.screen.mid,
            align : center,
            point_size : 50
        });

    } //onenter

    override function onleave<T>(_value:T) {

        title.destroy();
        subtitle.destroy();
        instructions.destroy();

    } //onleave

    override function onkeyup(e:KeyEvent) {
        machine.set('play_state');
    }

} //MenuState
