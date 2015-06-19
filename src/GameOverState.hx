import luxe.States;
import luxe.Text;
import luxe.Vector;
import luxe.Input;
import luxe.Color;
import phoenix.Batcher;
import phoenix.Camera;
import luxe.tween.Actuate;

class GameOverState extends State {

    var gameover_batcher : Batcher;
    var gameover_text : Text;
    var gameover_shader : phoenix.Shader;
    var restart_text : Text;
    var restart_shader : phoenix.Shader;
    var value : Int;

    public function new(_name:String, _value:Int) {

        super({ name:_name });
        value = _value;

    } //new

    override function init() {

        gameover_batcher = new Batcher(Luxe.renderer, 'gameover_batcher');
        var gameover_view = new Camera();
        gameover_batcher.view = gameover_view;
        gameover_batcher.layer = 2;
        Luxe.renderer.add_batch(gameover_batcher);
        gameover_shader = Luxe.renderer.shaders.bitmapfont.shader.clone('gameover_shader');
        restart_shader = Luxe.renderer.shaders.bitmapfont.shader.clone('restart_shader');

    } //init

    override function onenter<T>(_value:T) {

        var value:Int = cast _value;
        //huge bloody text that says GAME OVER, hit space to restart

        if(value == 0) {
            gameover_text = new Text({
                text : 'GAME OVER',
                pos : Luxe.screen.mid,
                align : center,
                point_size : 80,
                batcher : gameover_batcher,
                sdf : true,
                shader : gameover_shader,
                outline : 0.75,
                outline_color : new Color().rgb(0xfc0005)
            });
        }
        if(value == 1) {
            gameover_text = new Text({
                text : 'YOU WON!',
                pos : Luxe.screen.mid,
                align : center,
                point_size : 80,
                batcher : gameover_batcher,
                sdf : true,
                shader : gameover_shader,
                outline : 0.75,
                outline_color : new Color().rgb(0x1fa80f)
            });
        }

        restart_text = new Text({
            text : 'Press any key to restart',
            pos : new Vector(Luxe.screen.w/2, Luxe.screen.h/2 + 120),
            align : center,
            point_size : 35,
            batcher : gameover_batcher,
            sdf : true,
            shader : restart_shader,
            outline : 0.6,
            outline_color : new Color().rgb(0x000000)
        });

    } //onenter

    override function onleave<T>(_value:T) {

        gameover_text.destroy();
        restart_text.destroy();

    } //onleave

    override function onkeydown(e:KeyEvent) {

        PlayerBehavior.life_amount = 3;
        machine.set('play_state');

    } //onkeyup




} //GameOverState