import luxe.Component;
import luxe.Sprite;
import luxe.Vector;
import luxe.Events;
import luxe.tilemaps.Tilemap;

typedef MoveEvent = {
    direction : String
}

class PlayerBehavior extends Component {

    var player : Sprite;
    var tilemap : Tilemap;

    public function new(_name:String) {

        super({ name:_name });

    } //new

    override function init() {

        player = cast entity;
        tilemap = cast PlayState.map1;
        entity.events.listen('took_a_step', move);

    } //init

    override function update(dt:Float) {


    } //update

    function move(data:MoveEvent) {

        switch(data.direction) {
            case 'up':
                player.rotation_z = 0;
                if(tilemap.tile_at_pos('ground', new Vector(player.pos.x, player.pos.y - tilemap.tile_height), 1).id <= 16) return;
                player.pos.y -= tilemap.tile_height;
            case 'right':
                player.rotation_z = 90;
                if(tilemap.tile_at_pos('ground', new Vector(player.pos.x + tilemap.tile_width, player.pos.y), 1).id <= 16) return;
                player.pos.x += tilemap.tile_width;
            case 'down':
                player.rotation_z = 180;
                if(tilemap.tile_at_pos('ground', new Vector(player.pos.x, player.pos.y + tilemap.tile_height), 1).id <= 16) return;
                player.pos.y += tilemap.tile_height;
            case 'left':
                player.rotation_z = 270;
                if(tilemap.tile_at_pos('ground', new Vector(player.pos.x - tilemap.tile_width, player.pos.y), 1).id <= 16) return;
                player.pos.x -= tilemap.tile_width;
        }

    } //move

} //PlayerBehavior