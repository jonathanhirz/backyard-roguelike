import luxe.Component;
import luxe.Sprite;
import luxe.Vector;
import luxe.tilemaps.Tilemap;
import luxe.utils.Random;
import CustomDefines;

class Enemy extends Component {

    //TODO: each enemy needs an 'awareness' state: lost/wandering, aware of player and hunting, ready to attach

    var tilemap : Tilemap;

    public function new(_name:String) {

        super({ name:_name });

    } //new

    override function init() {

        Luxe.events.listen('player_took_action', move);
        tilemap = cast PlayState.map1;


    } //init

    override function update(dt:Float) {


    } //update

    //DONE: moves when/after player moves (events?)
    function move(data:MoveEvent) {

        var rand_direction = Luxe.utils.random.int(0,4);
        switch(rand_direction) {
            case 0: //up
                if(tilemap.tile_at_pos('ground', new Vector(entity.pos.x, entity.pos.y - tilemap.tile_height), 1).id <= 16) return;
                entity.pos.y -= tilemap.tile_height;
            case 1: //right
                if(tilemap.tile_at_pos('ground', new Vector(entity.pos.x + tilemap.tile_width, entity.pos.y), 1).id <= 16) return;
                entity.pos.x += tilemap.tile_width;
            case 2: //down
                if(tilemap.tile_at_pos('ground', new Vector(entity.pos.x, entity.pos.y + tilemap.tile_height), 1).id <= 16) return;
                entity.pos.y += tilemap.tile_height;
            case 3: //left
                if(tilemap.tile_at_pos('ground', new Vector(entity.pos.x - tilemap.tile_width, entity.pos.y), 1).id <= 16) return;
                entity.pos.x -= tilemap.tile_width;
        }
        // trace(tilemap.worldpos_to_map(entity.pos,1));

    }

} //Enemy
