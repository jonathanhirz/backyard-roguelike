import luxe.Component;
import luxe.Sprite;
import luxe.Vector;
import luxe.Input;

class PlayerControlsGrid extends Component {

    var player : Sprite;
    var player_width : Float;
    var player_height : Float;

    override function init() {

        connect_input();
        player = cast entity;
        player_width = player.size.x;
        player_height = player.size.y;


    } //init

    override function update(dt:Float) {

        if(Luxe.input.inputpressed('up')) {

            player.pos.y -= player_height;
            player.rotation_z = 0;

        }
        if(Luxe.input.inputpressed('right')) {

            player.pos.x += player_width;
            player.rotation_z = 90;

        }
        if(Luxe.input.inputpressed('down')) {

            player.pos.y += player_height;
            player.rotation_z = 180;

        }
        if(Luxe.input.inputpressed('left')) {

            player.pos.x -= player_width;
            player.rotation_z = 270;

        }

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
        Luxe.input.bind_key('toggle_held', Key.enter);

    } //connect_input


} //PlayerControlsGrid