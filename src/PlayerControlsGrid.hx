import luxe.Component;
import luxe.Sprite;
import luxe.Vector;
import luxe.Input;
import luxe.tilemaps.Tilemap;

class PlayerControlsGrid extends Component {

    var player : Sprite;
    var player_width : Float;
    var player_height : Float;
    var tilemap : Tilemap;
    var step_speed : Float = 0.25;
    var next_step : Float = 0;

    override function init() {

        connect_input();
        player = cast entity;
        player_width = player.size.x;
        player_height = player.size.y;
        tilemap = cast Main.PlayState.map1;

    } //init

    override function update(dt:Float) {

        if(Luxe.time > next_step) {
            if(Luxe.input.inputdown('up')) {
                player.rotation_z = 0;
                if(tilemap.tile_at_pos('ground', new Vector(player.pos.x, player.pos.y - tilemap.tile_height), 1).id <= 16) return;
                player.pos.y -= tilemap.tile_height;
                next_step = Luxe.time + step_speed;
                Luxe.events.fire('took_a_step');
            }
            if(Luxe.input.inputdown('right')) {
                player.rotation_z = 90;
                if(tilemap.tile_at_pos('ground', new Vector(player.pos.x + tilemap.tile_width, player.pos.y), 1).id <= 16) return;
                player.pos.x += tilemap.tile_width;
                next_step = Luxe.time + step_speed;
                Luxe.events.fire('took_a_step');
            }
            if(Luxe.input.inputdown('down')) {
                player.rotation_z = 180;
                if(tilemap.tile_at_pos('ground', new Vector(player.pos.x, player.pos.y + tilemap.tile_height), 1).id <= 16) return;
                player.pos.y += tilemap.tile_height;
                next_step = Luxe.time + step_speed;
                Luxe.events.fire('took_a_step');
            }
            if(Luxe.input.inputdown('left')) {
                player.rotation_z = 270;
                if(tilemap.tile_at_pos('ground', new Vector(player.pos.x - tilemap.tile_width, player.pos.y), 1).id <= 16) return;
                player.pos.x -= tilemap.tile_width;
                next_step = Luxe.time + step_speed;
                Luxe.events.fire('took_a_step');
            }
        }
        if(Luxe.input.inputreleased('up') ||
            Luxe.input.inputreleased('right') ||
            Luxe.input.inputreleased('down') ||
            Luxe.input.inputreleased('left')) {
                next_step = Luxe.time;
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