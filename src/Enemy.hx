import luxe.Component;
import luxe.Sprite;
import luxe.Vector;

class Enemy extends Component {

    public function new(_name:String) {

        super({ name:_name });

    } //new

    override function init() {

        Luxe.events.listen('took_a_step', move);


    } //init

    override function update(dt:Float) {


    } //update

    //TODO: moves when/after player moves (events?)
    function move(_) {
        // trace('event!');
    }

} //Enemy
