import luxe.Component;
import luxe.Sprite;
import luxe.Vector;
import luxe.Events;

class ChildBehavior extends Component {

    var child : Sprite;
    var player : Sprite;
    var is_held : Bool = false;

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
            var random_x = Luxe.utils.random.int(-3,3);
            var random_y = Luxe.utils.random.int(-3,3);
            child.pos = new Vector(child.pos.x + (32 * random_x), child.pos.y - (32 * random_y));
            //TODO: make sure child doesn't land on a wall when flying out
        }

   } //knocked_out

} //ChildBehavior