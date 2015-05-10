import luxe.Component;
import luxe.Sprite;
import luxe.Vector;
import luxe.Color;
import luxe.collision.shapes.*;
import luxe.collision.ShapeDrawerLuxe;

class Collider extends Component {

    var block : Sprite;
    var block_collider : Polygon;
    var shape_drawer : ShapeDrawerLuxe;
    var draw_collider : Bool = false;

    public function new( _name:String ) {

        super({ name:_name });

    } //new

    override function init () {

        block = cast entity;
        block_collider = Polygon.rectangle(block.pos.x, block.pos.y, block.size.x, block.size.y);
        block_collider.name = name;
        Main.block_collider_pool.push(block_collider);
        shape_drawer = new ShapeDrawerLuxe();

    } //init

    override function update( dt:Float ) {

        block_collider.position = block.pos;
        if(draw_collider) {
            shape_drawer.drawPolygon(block_collider);
        }

        if(Luxe.input.inputpressed('toggle_collider')) {
            draw_collider = !draw_collider;
        }

    } //update

} //Collider
