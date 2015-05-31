import luxe.Component;
import luxe.Sprite;
import luxe.Vector;
import luxe.tilemaps.Tilemap;
import luxe.utils.Random;
import CustomDefines;

class Enemy extends Component {

    //TODO: each enemy needs an 'awareness' state: lost/wandering, aware of player and hunting, ready to attach
    //TODO: enemy needs fight action, able to hit player
    //TODO: enemy needs to check if another enemy is on the tile it wants to move to
    //DONE: @fix movement where player and enemy will land on same tile

    var tilemap : Tilemap;
    var player : Sprite;

    public function new(_name:String) {

        super({ name:_name });

    } //new

    override function init() {

        Luxe.events.listen('player_moved_or_skipped', move);
        tilemap = cast PlayState.map1;
        player = cast PlayState.player;


    } //init

    override function update(dt:Float) {


    } //update

    //DONE: moves when/after player moves (events?)
    function move(_) {

        var dx = Math.abs(tilemap.worldpos_to_map(entity.pos).x - tilemap.worldpos_to_map(player.pos).x);
        var dy = Math.abs(tilemap.worldpos_to_map(entity.pos).y - tilemap.worldpos_to_map(player.pos).y);

        if(dx + dy > 6) {
            var rand_direction = Luxe.utils.random.int(0,4);
            switch(rand_direction) {
                case 0: //up
                    step_up();
                case 1: //right
                    step_right();
                case 2: //down
                    step_down();
                case 3: //left
                    step_left();
            }
        }

    } //move

    function step_up() {

        if(tilemap.tile_at_pos('ground', new Vector(entity.pos.x, entity.pos.y - tilemap.tile_height), 1).id <= 16) return;
        if(tilemap.worldpos_to_map(entity.pos).x == tilemap.worldpos_to_map(player.pos).x) {
            if(tilemap.worldpos_to_map(entity.pos,1).y - 1 == tilemap.worldpos_to_map(player.pos).y) {
                trace("enemy attacks!");
                return;
            }
        }
        entity.pos.y -= tilemap.tile_height;

    } //step_up

    function step_right() {

        if(tilemap.tile_at_pos('ground', new Vector(entity.pos.x + tilemap.tile_width, entity.pos.y), 1).id <= 16) return;
        if(tilemap.worldpos_to_map(entity.pos).y == tilemap.worldpos_to_map(player.pos).y) {
            if(tilemap.worldpos_to_map(entity.pos,1).x + 1 == tilemap.worldpos_to_map(player.pos).x) {
                trace("enemy attacks!");
                return;
            }
        }
        entity.pos.x += tilemap.tile_width;

    } //step_right

    function step_down() {

        if(tilemap.tile_at_pos('ground', new Vector(entity.pos.x, entity.pos.y + tilemap.tile_height), 1).id <= 16) return;
        if(tilemap.worldpos_to_map(entity.pos).x == tilemap.worldpos_to_map(player.pos).x) {
            if(tilemap.worldpos_to_map(entity.pos,1).y + 1 == tilemap.worldpos_to_map(player.pos).y) {
                trace("enemy attacks!");
                return;
            }
        }
        entity.pos.y += tilemap.tile_height;

    } //step_down

    function step_left() {

        if(tilemap.tile_at_pos('ground', new Vector(entity.pos.x - tilemap.tile_width, entity.pos.y), 1).id <= 16) return;
        if(tilemap.worldpos_to_map(entity.pos).y == tilemap.worldpos_to_map(player.pos).y) {
            if(tilemap.worldpos_to_map(entity.pos,1).x - 1 == tilemap.worldpos_to_map(player.pos).x) {
                trace("enemy attacks!");
                return;
            }
        }
        entity.pos.x -= tilemap.tile_width;

    } //step_left

} //Enemy
