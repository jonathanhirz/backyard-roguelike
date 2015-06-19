import luxe.Component;
import luxe.Sprite;
import luxe.Vector;
import luxe.tilemaps.Tilemap;
import luxe.utils.Random;
import CustomDefines;

class Enemy extends Component {

    //done: enemy needs fight action, able to hit player
    //done: @priority enemy needs to check if another enemy is on the tile it wants to move to
    //DONE: fix the corner follow issue. enemy should move to line up when dx = dy
    //DONE: @fix movement where player and enemy will land on same tile
    //DONE: each enemy needs an 'awareness' state: lost/wandering, aware of player and hunting, ready to attack (fixed basic, if >6 spaces away, wander, etc)

    var tilemap : Tilemap;
    var player : Sprite;
    var enemy_pool : Array<Sprite>;
    var event_id : String;

    public function new(_name:String) {

        super({ name:_name });

    } //new

    override function init() {

        event_id = Luxe.events.listen('player_moved_or_skipped', move);
        tilemap = cast PlayState.map1;
        player = cast PlayState.player;
        enemy_pool = cast PlayState.enemy_pool;


    } //init

    override function ondestroy() {
        Luxe.events.unlisten(event_id);
        tilemap = null;
        player = null;
        event_id = null;
        trace('destroyed ' + entity.name);
    }

    override function update(dt:Float) {

    } //update

    //DONE: moves when/after player moves (events?)
    function move(_) {

        var dx = tilemap.worldpos_to_map(entity.pos).x - tilemap.worldpos_to_map(player.pos).x;
        var dy = tilemap.worldpos_to_map(entity.pos).y - tilemap.worldpos_to_map(player.pos).y;
        // trace(dx);
        // trace(dy);

        if(Math.abs(dx) + Math.abs(dy) > 6) {
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
        } else {
            //TODO: @later work on enemy thought/movement. feels a little off now. they should know how to chase player
            //DONE: basic enemy movement/chase
            if(Math.abs(dx) > Math.abs(dy)) {
                if(dx > 0) {
                    step_left();
                } 
                if(dx < 0) {
                    step_right();
                }
            }
            if(Math.abs(dy) > Math.abs(dx)) {
                if(dy > 0) {
                    step_up();
                } 
                if(dy < 0) {
                    step_down();
                }
            }
            //solving the corner edge case (enemy is diagonal to player)
            if(Math.abs(dy) == Math.abs(dx)) {
                //top left
                if(dy < 0 && dx < 0) {
                    switch(Luxe.utils.random.int(0,2)) {
                        case 0: step_down();
                        case 1: step_right();
                    }
                }
                //top right
                if(dy < 0 && dx > 0) {
                    switch(Luxe.utils.random.int(0,2)) {
                        case 0: step_left();
                        case 1: step_down();
                    }
                }
                //bottom right
                if(dy > 0 && dx > 0) {
                    switch(Luxe.utils.random.int(0,2)) {
                        case 0: step_up();
                        case 1: step_left();
                    }
                }
                //bottom left
                if(dy > 0 && dx < 0) {
                    switch(Luxe.utils.random.int(0,2)) {
                        case 0: step_right();
                        case 1: step_up();
                    }
                }
            }
        }

    } //move

    function step_up() {

        if(tilemap.tile_at_pos('ground', new Vector(entity.pos.x, entity.pos.y - tilemap.tile_height), 1).id <= 16) return;
        if(tilemap.tile_at_pos('obstacles', new Vector(entity.pos.x, entity.pos.y - tilemap.tile_height), 1).id != 0) return;
        for(enemy in enemy_pool) {
            if(tilemap.worldpos_to_map(enemy.pos).x == tilemap.worldpos_to_map(entity.pos).x) {
                if(tilemap.worldpos_to_map(enemy.pos).y == tilemap.worldpos_to_map(entity.pos).y - 1) return;
            }
        }
        if(tilemap.worldpos_to_map(entity.pos).x == tilemap.worldpos_to_map(player.pos).x) {
            if(tilemap.worldpos_to_map(entity.pos,1).y - 1 == tilemap.worldpos_to_map(player.pos).y) {
                enemy_attacks();
                return;
            }
        }
        entity.pos.y -= tilemap.tile_height;

    } //step_up

    function step_right() {

        if(tilemap.tile_at_pos('ground', new Vector(entity.pos.x + tilemap.tile_width, entity.pos.y), 1).id <= 16) return;
        if(tilemap.tile_at_pos('obstacles', new Vector(entity.pos.x + tilemap.tile_width, entity.pos.y), 1).id != 0) return;
        for(enemy in enemy_pool) {
            if(tilemap.worldpos_to_map(enemy.pos).y == tilemap.worldpos_to_map(entity.pos).y) {
                if(tilemap.worldpos_to_map(enemy.pos).x == tilemap.worldpos_to_map(entity.pos).x + 1) return;
            }
        }
        if(tilemap.worldpos_to_map(entity.pos).y == tilemap.worldpos_to_map(player.pos).y) {
            if(tilemap.worldpos_to_map(entity.pos,1).x + 1 == tilemap.worldpos_to_map(player.pos).x) {
                enemy_attacks();
                return;
            }
        }
        entity.pos.x += tilemap.tile_width;

    } //step_right

    function step_down() {

        if(tilemap.tile_at_pos('ground', new Vector(entity.pos.x, entity.pos.y + tilemap.tile_height), 1).id <= 16) return;
        if(tilemap.tile_at_pos('obstacles', new Vector(entity.pos.x, entity.pos.y + tilemap.tile_height), 1).id != 0) return;
        for(enemy in enemy_pool) {
            if(tilemap.worldpos_to_map(enemy.pos).x == tilemap.worldpos_to_map(entity.pos).x) {
                if(tilemap.worldpos_to_map(enemy.pos).y == tilemap.worldpos_to_map(entity.pos).y + 1) return;
            }
        }
        if(tilemap.worldpos_to_map(entity.pos).x == tilemap.worldpos_to_map(player.pos).x) {
            if(tilemap.worldpos_to_map(entity.pos,1).y + 1 == tilemap.worldpos_to_map(player.pos).y) {
                enemy_attacks();
                return;
            }
        }
        entity.pos.y += tilemap.tile_height;

    } //step_down

    function step_left() {

        if(tilemap.tile_at_pos('ground', new Vector(entity.pos.x - tilemap.tile_width, entity.pos.y), 1).id <= 16) return;
        if(tilemap.tile_at_pos('obstacles', new Vector(entity.pos.x - tilemap.tile_width, entity.pos.y), 1).id != 0) return;
        for(enemy in enemy_pool) {
            if(tilemap.worldpos_to_map(enemy.pos).y == tilemap.worldpos_to_map(entity.pos).y) {
                if(tilemap.worldpos_to_map(enemy.pos).x == tilemap.worldpos_to_map(entity.pos).x - 1) return;
            }
        }
        if(tilemap.worldpos_to_map(entity.pos).y == tilemap.worldpos_to_map(player.pos).y) {
            if(tilemap.worldpos_to_map(entity.pos,1).x - 1 == tilemap.worldpos_to_map(player.pos).x) {
                enemy_attacks();
                return;
            }
        }
        entity.pos.x -= tilemap.tile_width;

    } //step_left

    function enemy_attacks() {
        //done: knock child out of player's hands
        Luxe.events.fire('knock_child_out_of_hand');
        trace("enemy attacks!");
        PlayerBehavior.life_amount--;
        PlayState.life_text.text = 'Life: ' + PlayerBehavior.life_amount;
    }

} //Enemy
