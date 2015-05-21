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

    var player : Sprite;
    var player_texture : Texture;
    var child : Sprite;
    var enemy : Sprite;
    var enemy_texture : Texture;
    public static var map1 : TiledMap;
    public static var block_collider_pool : Array<Shape>;

    public function new(_name:String) {

        super({ name:_name });
        block_collider_pool = [];

    } //new

    override function init() {

        connect_input();

    } //init

    override function onenter<T>(_value:T) {

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

        if(enemy_texture == null) enemy_texture = Luxe.resources.texture('assets/enemy.png');
        enemy = new Sprite({
            name : 'enemy',
            depth : 1,
            texture : enemy_texture,
            pos : map1.tile_pos('ground', 5,3).add_xyz(map1.tile_width/2, map1.tile_height/2)
        }); //enemy
        enemy.add(new Enemy('enemy'));

    } //onenter

    override function onleave<T>(_value:T) {


    } //onleave

    override function update(dt:Float) {

        Luxe.camera.center.weighted_average_xy(player.pos.x, player.pos.y, 10);

        var player_child_col = Collision.shapeWithShape(player.get('player_collider').block_collider, child.get('child_collider').block_collider);
        if(player_child_col != null) {
            child.get('child_behavior').is_held = true;
        }

        if(Luxe.input.inputpressed('up')) {
            player.events.fire('took_a_step', { direction:up });
        }
        if(Luxe.input.inputpressed('right')) {
            player.events.fire('took_a_step', { direction:right });
        }
        if(Luxe.input.inputpressed('down')) {
            player.events.fire('took_a_step', { direction:down });
        }
        if(Luxe.input.inputpressed('left')) {
            player.events.fire('took_a_step', { direction:left });
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
        Luxe.input.bind_key('attack', Key.space);
        Luxe.input.bind_key('toggle_collider', Key.key_t);
        Luxe.input.bind_key('toggle_held', Key.enter);

    } //connect_input


} //PlayState
