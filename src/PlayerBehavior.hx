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
    var enemy_pool : Array<Sprite>;

    public function new(_name:String) {

        super({ name:_name });

    } //new

    override function init() {

        player = cast entity;
        tilemap = cast PlayState.map1;
        enemy_pool = cast PlayState.enemy_pool;
        Luxe.events.listen('input_was_pressed', move);

    } //init

    override function update(dt:Float) {


    } //update

    function move(data:MoveEvent) {

        //TODO: attack fires an event, takes hp from enemy hit, kills/removes if necesary
        //TODO: clean up this player/direction code, try and make it one function instead of repetition
        //DONE: on direction check, see if there's an enemy on that tile we want to move to. if there is, run attack function and return (don't move)
        switch(data.direction) {
            case 'up':
                player.rotation_z = 0;
                //check for walls
                if(tilemap.tile_at_pos('ground', new Vector(player.pos.x, player.pos.y - tilemap.tile_height), 1).id <= 16) return;
                //check for enemies
                for(enemy in enemy_pool) {
                    if(tilemap.worldpos_to_map(enemy.pos, 1).x == tilemap.worldpos_to_map(player.pos, 1).x) {
                        if(tilemap.worldpos_to_map(enemy.pos, 1).y == tilemap.worldpos_to_map(player.pos, 1).y - 1) {
                            attack(enemy);
                            // trace("killed " + enemy.name);
                            return;
                        }
                    }
                }
                player.pos.y -= tilemap.tile_height;
                Luxe.events.fire('player_moved_or_skipped');
            case 'right':
                player.rotation_z = 90;
                //check for walls
                if(tilemap.tile_at_pos('ground', new Vector(player.pos.x + tilemap.tile_width, player.pos.y), 1).id <= 16) return;
                //check for enemies
                for(enemy in enemy_pool) {
                    if(tilemap.worldpos_to_map(enemy.pos, 1).y == tilemap.worldpos_to_map(player.pos, 1).y) {
                        if(tilemap.worldpos_to_map(enemy.pos, 1).x == tilemap.worldpos_to_map(player.pos, 1).x + 1) {
                            attack(enemy);
                            // trace("killed " + enemy.name);
                            return;
                        }
                    }
                }
                player.pos.x += tilemap.tile_width;
                Luxe.events.fire('player_moved_or_skipped');
            case 'down':
                player.rotation_z = 180;
                //check for walls
                if(tilemap.tile_at_pos('ground', new Vector(player.pos.x, player.pos.y + tilemap.tile_height), 1).id <= 16) return;
                //check for enemies
                for(enemy in enemy_pool) {
                    if(tilemap.worldpos_to_map(enemy.pos, 1).x == tilemap.worldpos_to_map(player.pos, 1).x) {
                        if(tilemap.worldpos_to_map(enemy.pos, 1).y == tilemap.worldpos_to_map(player.pos, 1).y + 1) {
                            attack(enemy);
                            // trace("killed " + enemy.name);
                            return;
                        }
                    }
                }
                player.pos.y += tilemap.tile_height;
                Luxe.events.fire('player_moved_or_skipped');
            case 'left':
                player.rotation_z = 270;
                //check for walls
                if(tilemap.tile_at_pos('ground', new Vector(player.pos.x - tilemap.tile_width, player.pos.y), 1).id <= 16) return;
                //check for enemies
                for(enemy in enemy_pool) {
                    if(tilemap.worldpos_to_map(enemy.pos, 1).y == tilemap.worldpos_to_map(player.pos, 1).y) {
                        if(tilemap.worldpos_to_map(enemy.pos, 1).x == tilemap.worldpos_to_map(player.pos, 1).x - 1) {
                            attack(enemy);
                            // trace("killed " + enemy.name);
                            return;
                        }
                    }
                }
                player.pos.x -= tilemap.tile_width;
                Luxe.events.fire('player_moved_or_skipped');
        }

    } //move

    function attack(_enemy:Sprite) {

        // trace(_enemy.name);
        enemy_pool.remove(_enemy);
        _enemy.destroy();

    } //attack

} //PlayerBehavior
