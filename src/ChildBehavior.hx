import luxe.Component;
import luxe.Sprite;
import luxe.Vector;

class ChildBehavior extends Component {

    var child : Sprite;
    var player : Sprite;
    var is_held : Bool = false;

    public function new( _name:String ) {

        super({ name:_name });

    } //new

    override function init() {

        child = cast entity;
        player = cast Luxe.scene.entities.get('player');

    } //init

    override function update( dt:Float ) {

        if(is_held) {

            child.pos = player.pos.clone();
        }

        if(Luxe.input.inputpressed('toggle_held')) {

            is_held = false;
            child.pos = new Vector(child.pos.x + 30, child.pos.y - 50);

        }

   } //update

} //ChildBehavior