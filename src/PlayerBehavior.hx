import luxe.Component;
import luxe.Sprite;
import luxe.Vector;
import luxe.Events;
import luxe.tilemaps.Tilemap;
import CustomDefines;

// typedef MoveEvent = {
//     direction : String
// }

//DONE: new class - PlayerAction - listens for event, looks at tile in direction, decides action (walk, block, fight, etc)

class PlayerBehavior extends Component {

    var player : Sprite;
    var tilemap : Tilemap;

    public function new(_name:String) {

        super({ name:_name });

    } //new

    override function init() {

        player = cast entity;
        tilemap = cast PlayState.map1;
        Luxe.events.listen('input_was_pressed', move);

    } //init

    override function update(dt:Float) {


    } //update

    function move(data:MoveEvent) {

        //TODO: on direction check, see if there's an enemy on that tile we want to move to. if there is, run attack function and return (don't move)

        switch(data.direction) {
            case 'up':
                player.rotation_z = 0;
                if(tilemap.tile_at_pos('ground', new Vector(player.pos.x, player.pos.y - tilemap.tile_height), 1).id <= 16) return;
                for(enemy in PlayState.enemy_pool) {
                    if(tilemap.worldpos_to_map(enemy.pos, 1).x == tilemap.worldpos_to_map(player.pos, 1).x) {
                        if(tilemap.worldpos_to_map(enemy.pos, 1).y == tilemap.worldpos_to_map(player.pos, 1).y -1) {
                            attack();
                            trace("killed " + enemy.name);
                            return;
                        }
                    }
                }

                player.pos.y -= tilemap.tile_height;
                Luxe.events.fire('player_moved_or_skipped');
            case 'right':
                player.rotation_z = 90;
                if(tilemap.tile_at_pos('ground', new Vector(player.pos.x + tilemap.tile_width, player.pos.y), 1).id <= 16) return;
                player.pos.x += tilemap.tile_width;
                Luxe.events.fire('player_moved_or_skipped');
            case 'down':
                player.rotation_z = 180;
                if(tilemap.tile_at_pos('ground', new Vector(player.pos.x, player.pos.y + tilemap.tile_height), 1).id <= 16) return;
                player.pos.y += tilemap.tile_height;
                Luxe.events.fire('player_moved_or_skipped');
            case 'left':
                player.rotation_z = 270;
                if(tilemap.tile_at_pos('ground', new Vector(player.pos.x - tilemap.tile_width, player.pos.y), 1).id <= 16) return;
                player.pos.x -= tilemap.tile_width;
                Luxe.events.fire('player_moved_or_skipped');
        }

    } //move

    function attack() {

        trace("ATTACK!");

    } //attach

} //PlayerBehavior
