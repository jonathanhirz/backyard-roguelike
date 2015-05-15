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

    override function init() {

        connect_input();
        player = cast entity;
        player_width = player.size.x;
        player_height = player.size.y;
        tilemap = cast Main.PlayState.map1;


    } //init

    override function update(dt:Float) {

        if(Luxe.input.inputpressed('up')) {
            player.rotation_z = 0;
            if(tilemap.tile_at_pos('collider', new Vector(player.pos.x, player.pos.y - 32), 1).id != 0) return;
            player.pos.y -= player_height;
        }
        if(Luxe.input.inputpressed('right')) {
            player.rotation_z = 90;
            if(tilemap.tile_at_pos('collider', new Vector(player.pos.x + 32, player.pos.y), 1).id != 0) return;
            player.pos.x += player_width;
        }
        if(Luxe.input.inputpressed('down')) {
            player.rotation_z = 180;
            if(tilemap.tile_at_pos('collider', new Vector(player.pos.x, player.pos.y + 32), 1).id != 0) return;
            player.pos.y += player_height;
        }
        if(Luxe.input.inputpressed('left')) {
            player.rotation_z = 270;
            if(tilemap.tile_at_pos('collider', new Vector(player.pos.x - 32, player.pos.y), 1).id != 0) return;
            player.pos.x -= player_width;
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