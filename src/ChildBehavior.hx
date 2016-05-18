import luxe.Component;
import luxe.Sprite;
import luxe.Vector;
import luxe.Events;
import luxe.tilemaps.Tilemap;

class ChildBehavior extends Component {

    var child : Sprite;
    var player : Sprite;
    var is_held : Bool = false;
    var tilemap : Tilemap;

    //done: set up an event for knocking child out of hands
    //todo: better child sprite
    //todo: when not held, child walks around in random manner

    public function new(_name:String) {

        super({ name:_name });

    } //new

    override function init() {

        child = cast entity;
        player = cast Luxe.scene.entities.get('player');
        Luxe.events.listen('knock_child_out_of_hand', knocked_out);
        tilemap = cast PlayState.map1;

    } //init

    override function update(dt:Float) {

        if(is_held) {

            child.pos = player.pos.clone();
        }
        if(!is_held) {
            
        }

        if(Luxe.input.inputpressed('toggle_held')) {
            Luxe.events.fire('knock_child_out_of_hand');
        }

   } //update

   function knocked_out(_) {

        if(is_held) {
            is_held = false;
            new_child_position();
        }

   } //knocked_out

   function new_child_position() {
        var random_x = Luxe.utils.random.int(-1,2);
        var random_y = Luxe.utils.random.int(-1,2);
        if(random_x == 0 && random_y == 0) {
            trace('0 0');
            new_child_position();
        }
        
        var new_position = new Vector(child.pos.x + (32 * random_x), child.pos.y - (32 * random_y));
        // if(tilemap.tile_at_pos('ground', new Vector(new_position.x, new_position.y), 1).id == null) {
        //     new_child_position();
        //     trace('hit a void');
        // }
        if(tilemap.tile_at_pos('ground', new_position.x, new_position.y, 1).id <= 16 ||
            tilemap.tile_at_pos('obstacles', new_position.x, new_position.y, 1).id != 0) {
            new_child_position();
        } else {
            child.pos = new_position;
        }
        //done: make sure child doesn't land on a wall when flying out
        //done: fix null when child flies off of tilemap
   }

} //ChildBehavior