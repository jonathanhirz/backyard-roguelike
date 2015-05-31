import luxe.States;
import luxe.Sprite;
import luxe.Vector;
import luxe.Input;
import luxe.Color;
import phoenix.Texture;
import luxe.tilemaps.Ortho;
import luxe.tilemaps.Tilemap;
import luxe.importers.tiled.TiledMap;
import phoenix.Texture.FilterType;
import luxe.collision.Collision;
import luxe.collision.shapes.*;
import luxe.collision.data.*;

class PlayState extends State {

    public static var player : Sprite;
    var player_texture : Texture;
    var child : Sprite;
    var enemy : Sprite;
    var enemy_texture : Texture;
    public static var map1 : TiledMap;
    public static var block_collider_pool : Array<Shape>;
    public static var enemy_pool : Array<Sprite>;

    public function new(_name:String) {

        super({ name:_name });
        block_collider_pool = [];
        enemy_pool = [];
        // connect_input();

    } //new

    override function init() {

    } //init

    override function onenter<T>(_value:T) {

        connect_input();
        // Luxe.showConsole(true);

        var tilemap = Luxe.resources.text('assets/tilemap.tmx');

        map1 =  new TiledMap({ 
            tiled_file_data : tilemap.asset.text,
            format : 'tmx',
            pos : new Vector(0,0)
        }); //map1

        map1.display({
            scale : 1,
            depth : 0,
            grid : false,
            filter : FilterType.nearest
        });


        if(player_texture == null) player_texture = Luxe.resources.texture('assets/player.png');
        player = new Sprite({
            name : 'player',
            depth : 1,
            texture : player_texture,
            pos : map1.tile_pos('ground', 1, 5).add_xyz(map1.tile_width/2, map1.tile_height/2)
        }); //player
        player.add(new PlayerBehavior('player_behavior'));
        player.add(new Collider('player_collider'));

        child = new Sprite({
            pos : new Vector(player.pos.x + 30, player.pos.y -10),
            size : new Vector(15,25),
            color : new Color().rgb(0x675fd5),
            depth : 2
        }); //child
        child.add(new ChildBehavior('child_behavior'));
        child.add(new Collider('child_collider'));

        //DONE: get an enemy on screen 05/15/2015
        if(enemy_texture == null) enemy_texture = Luxe.resources.texture('assets/enemy.png');
        for(i in 0...10) {
            enemy = new Sprite({
                name : 'enemy',
                name_unique : true,
                depth : 1,
                texture : enemy_texture,
                //TODO: check position where enemy will be placed, make sure it's valid. check tile_at_pos for valid floor tile, make sure not on player/other enemy
                pos : map1.tile_pos('ground', Luxe.utils.random.int(1,20), Luxe.utils.random.int(1,20)).add_xyz(map1.tile_width/2, map1.tile_height/2)
            }); //enemy
            enemy.add(new Enemy('enemy'));
            enemy_pool.push(enemy);
        }

    } //onenter

    override function onleave<T>(_value:T) {


    } //onleave

    override function update(dt:Float) {

        Luxe.camera.center.weighted_average_xy(player.pos.x, player.pos.y, 10);

        var player_child_col = Collision.shapeWithShape(player.get('player_collider').block_collider, child.get('child_collider').block_collider);
        if(player_child_col != null) {
            child.get('child_behavior').is_held = true;
        }

        //DONE: fix movement. arrows move one space at a time. no holding movement. 05/20/2015
        //DONE: PlayerControlsGrid -> Input.hx - reads input, fires events that player and enemy listen for (took_a_step('direction')) 05/20/2015
        //TODO: @later touch/mouse to click on a spot and move multiple tiles.
        if(Luxe.input.inputpressed('up')) {
            Luxe.events.fire('input_was_pressed', { direction:'up' });
        }
        if(Luxe.input.inputpressed('right')) {
            Luxe.events.fire('input_was_pressed', { direction:'right' });
        }
        if(Luxe.input.inputpressed('down')) {
            Luxe.events.fire('input_was_pressed', { direction:'down' });
        }
        if(Luxe.input.inputpressed('left')) {
            Luxe.events.fire('input_was_pressed', { direction:'left' });
        }
        if(Luxe.input.inputpressed('skip')) {
            Luxe.events.fire('player_moved_or_skipped');
        }

    } //update

    function connect_input() {

        Luxe.input.bind_key('up', Key.up);
        Luxe.input.bind_key('up', Key.key_w);
        Luxe.input.bind_key('right', Key.right);
        Luxe.input.bind_key('right', Key.key_d);
        Luxe.input.bind_key('down', Key.down);
        Luxe.input.bind_key('down', Key.key_s);
        Luxe.input.bind_key('left', Key.left);
        Luxe.input.bind_key('left', Key.key_a);
        Luxe.input.bind_key('skip', Key.space);
        Luxe.input.bind_key('toggle_collider', Key.key_t);
        Luxe.input.bind_key('toggle_held', Key.enter);

    } //connect_input


} //PlayState
