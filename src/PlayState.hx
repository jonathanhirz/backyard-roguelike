import pmi.PyxelMapImporter;
import pmi.LuxeHelper;
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
import luxe.Text;
import phoenix.Batcher;
import phoenix.Camera;
import luxe.tween.Actuate;

class PlayState extends State {

    public static var player : Sprite;
    var player_texture : Texture;
    public static var child : Sprite;
    var enemy : Sprite;
    var enemy_texture : Texture;
    public static var map1 : Tilemap;
    public static var map2 : Tilemap;
    public static var map3 : Tilemap;
    public static var current_map : Tilemap;
    public static var block_collider_pool : Array<Shape>;
    public static var enemy_pool : Array<Sprite>;

    public static var life_text : Text;
    var hud_batcher : Batcher;
    var life_text_shader : phoenix.Shader;

    var next_step : Float = 0;
    var step_rate : Float = 0.17;

    public function new(_name:String) {

        super({ name:_name });

    } //new

    override function init() {

        block_collider_pool = [];
        
        hud_batcher = new Batcher(Luxe.renderer, 'hud_batcher');
        var hud_view = new Camera();
        hud_batcher.view = hud_view;
        hud_batcher.layer = 2;
        Luxe.renderer.add_batch(hud_batcher);
        life_text_shader = Luxe.renderer.shaders.bitmapfont.shader.clone('title-shader');

        if(map1 == null) {
            var tilemap_1_xml = new PyxelMapImporter(Luxe.resources.text('assets/tilemap_1_backyard.xml').asset.text);
            map1 = LuxeHelper.getTilemap('assets/tileset_backyard.png');
            var ground1 = tilemap_1_xml.getDatasFromLayer('ground');
            var obstacles1 = tilemap_1_xml.getDatasFromLayer('obstacles');
            LuxeHelper.fillLayer(map1, ground1);
            LuxeHelper.fillLayer(map1, obstacles1);
        }

        if(map2 == null) {
            var tilemap_2_xml = new PyxelMapImporter(Luxe.resources.text('assets/tilemap_2_backyard.xml').asset.text);
            map2 = LuxeHelper.getTilemap('assets/tileset_backyard.png');
            var ground2 = tilemap_2_xml.getDatasFromLayer('ground');
            var obstacles2 = tilemap_2_xml.getDatasFromLayer('obstacles');
            LuxeHelper.fillLayer(map2, ground2);
            LuxeHelper.fillLayer(map2, obstacles2);
        }

        if(map3 == null) {
            var tilemap_3_xml = new PyxelMapImporter(Luxe.resources.text('assets/tilemap_3_backyard.xml').asset.text);
            map3 = LuxeHelper.getTilemap('assets/tileset_backyard.png');
            var ground3 = tilemap_3_xml.getDatasFromLayer('ground');
            var obstacles3 = tilemap_3_xml.getDatasFromLayer('obstacles');
            LuxeHelper.fillLayer(map3, ground3);
            LuxeHelper.fillLayer(map3, obstacles3);
        }

    } //init

    override function onenter<T>(_value:T) {

        if(enemy_pool == null) enemy_pool = [];

        // Luxe.showConsole(true);

        Actuate.tween(Luxe.camera, 1.5, { zoom:1 });

        // var tilemap = Luxe.resources.text('assets/tilemap.tmx');
        
        var random_map = Luxe.utils.random.int(0,3);
        switch(random_map) {
            case 0: {
                map1.display({});
                current_map = map1;
            }
            case 1: {
                map2.display({});
                current_map = map2;
            }
            case 2: {
                map3.display({});
                current_map = map3;
            }
        }

        if(player_texture == null) player_texture = Luxe.resources.texture('assets/player.png');
        player = new Sprite({
            name : 'player',
            depth : 1,
            texture : player_texture,
            pos : map1.tile_pos('ground', 1, 1).add_xyz(map1.tile_width/2, map1.tile_height/2)
        }); //player
        player.add(new PlayerBehavior('player_behavior'));
        player.add(new Collider('player_collider'));

        life_text = new Text({
            text : 'Life: ' + PlayerBehavior.life_amount,
            pos : new Vector(0,0),
            sdf : true,
            shader : life_text_shader,
            outline : 0.75,
            outline_color : new Color().rgb(0x000000),
            batcher : hud_batcher
        }); //life_text

        child = new Sprite({
            pos : new Vector(player.pos.x, player.pos.y),
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
                // pos : map1.tile_pos('ground', Luxe.utils.random.int(1,20), Luxe.utils.random.int(1,20)).add_xyz(map1.tile_width/2, map1.tile_height/2)
                // pos : map1.tile_pos('ground',2,1).add_xyz(map1.tile_width/2, map1.tile_height/2)
                pos : get_enemy_position()
            }); //enemy
            enemy.add(new Enemy('enemy'));
            enemy_pool.push(enemy);
        }

    } //onenter

    override function onleave<T>(_value:T) {

        Actuate.tween(Luxe.camera, 1.5, { zoom:0.5 });
        player.destroy();
        life_text.destroy();
        child.destroy();
        for(dead_enemy in enemy_pool) {
            dead_enemy.destroy();
            // enemy_pool.remove(dead_enemy);
        }
        enemy_pool = null;
        //destroy ui/player/child/all enemies (explosion would be cool but do it @later)
        //tilemap stays


    } //onleave

    override function update(dt:Float) {

        Luxe.camera.center.weighted_average_xy(player.pos.x, player.pos.y, 10);

        var player_child_col = Collision.shapeWithShape(player.get('player_collider').block_collider, child.get('child_collider').block_collider);
        if(player_child_col != null) {
            child.get('child_behavior').is_held = true;
        }

        //DONE: fix movement. arrows move one space at a time. no holding movement. 05/20/2015
        //todo: @later revisiting hold movement controls, but hitting two inputs is...weird. revisit.
        //DONE: PlayerControlsGrid -> Input.hx - reads input, fires events that player and enemy listen for (took_a_step('direction')) 05/20/2015
        //TODO: @later touch/mouse to click on a spot and move multiple tiles.
        if(Luxe.input.inputdown('up')) {
            if(Luxe.time > next_step){
                Luxe.events.fire('input_was_pressed', { direction:'up' });
                next_step = Luxe.time + step_rate;
            }
        } else 
        if(Luxe.input.inputdown('right')) {
            if(Luxe.time > next_step){
                Luxe.events.fire('input_was_pressed', { direction:'right' });
                next_step = Luxe.time + step_rate;
            }
        } else
        if(Luxe.input.inputdown('down')) {
            if(Luxe.time > next_step){
                Luxe.events.fire('input_was_pressed', { direction:'down' });
                next_step = Luxe.time + step_rate;
            }
        } else
        if(Luxe.input.inputdown('left')) {
            if(Luxe.time > next_step){
                Luxe.events.fire('input_was_pressed', { direction:'left' });
                next_step = Luxe.time + step_rate;
            }
        } else
        if(Luxe.input.inputdown('skip')) {
            if(Luxe.time > next_step){
                Luxe.events.fire('player_moved_or_skipped');
                next_step = Luxe.time + step_rate;
            }
        }

    } //update

    //TODO: check position where enemy will be placed, make sure it's valid. check tile_at_pos for valid floor tile, make sure not on player/other enemy
    function get_enemy_position() {
        return map1.tile_pos('ground',Luxe.utils.random.int(1,20),Luxe.utils.random.int(1,20)).add_xyz(map1.tile_width/2, map1.tile_height/2);
    }


} //PlayState
