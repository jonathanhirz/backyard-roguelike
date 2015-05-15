import luxe.Input;
import luxe.Sprite;
import luxe.Color;
import luxe.Vector;
import luxe.States;
import phoenix.Texture;
import phoenix.Texture.FilterType;
import luxe.collision.Collision;
import luxe.collision.shapes.*;
import luxe.collision.data.*;

import luxe.tilemaps.Ortho;
import luxe.tilemaps.Tilemap;
import luxe.importers.tiled.TiledMap;

class MenuState extends State {

    public function new(_name:String) {

        super({ name:_name });

    } //new

    override function init() {


    } //init

    override function onenter<T>(_value:T) {


    } //onenter

    override function onleave<T>(_value:T) {


    } //onleave


} //MenuState


class PlayState extends State {

    var player : Sprite;
    var player_texture : Texture;
    var child : Sprite;
    public static var map1 : TiledMap;

    public function new(_name:String) {

        super({ name:_name });

    } //new

    override function init() {

    } //init

    override function onenter<T>(_value:T) {

        // var background = new Sprite({
        //     pos : Luxe.screen.mid,
        //     size : new Vector(500, 500),
        //     color : new Color().rgb(0x198810)
        // }); //background

        var tilemap = Luxe.resources.text('assets/tilemap.tmx');

        map1 =  new TiledMap({ 
            tiled_file_data : tilemap.asset.text,
            format : 'tmx',
            pos : new Vector(0,0)
        }); //map1

        for(layer in map1.layers) {
            if(layer.name == 'collider') {
                layer.visible = false;
            }
        }

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
            pos : new Vector(48,48)
        }); //player
        // player.add(new PlayerControls());
        player.add(new PlayerControlsGrid());
        player.add(new Collider('player_collider'));

        child = new Sprite({
            pos : new Vector(player.pos.x + 30, player.pos.y -10),
            size : new Vector(15,25),
            color : new Color().rgb(0x675fd5),
            depth : 2
        }); //child
        child.add(new ChildBehavior('child_behavior'));
        child.add(new Collider('child_collider'));

    } //onenter

    override function onleave<T>(_value:T) {


    } //onleave

    override function update(dt:Float) {

        var player_child_col = Collision.shapeWithShape(player.get('player_collider').block_collider, child.get('child_collider').block_collider);
        if(player_child_col != null) {
            child.get('child_behavior').is_held = true;
        }

        // trace(map1.tile_at_pos('tiles', player.pos, 1));
        // trace(map1.worldpos_to_map(player.pos, 1));

    } //update


} //PlayState


class Main extends luxe.Game {

    var machine : States;
    public static var block_collider_pool : Array<Shape>;

    override function config( config:luxe.AppConfig ) {

        config.preload.textures.push({ id:'assets/player.png' });
        config.preload.textures.push({ id:'assets/tiles.png' });

        config.preload.texts.push({ id:'assets/tilemap.tmx' });

        return config;

    } //config

    override function ready() {

        block_collider_pool = [];
        machine = new States({ name:'statemachine' });
        machine.add(new MenuState('menu_state'));
        machine.add(new PlayState('play_state'));
        machine.set('play_state');

    } //ready

    override function onkeyup(e:KeyEvent) {

        if(e.keycode == Key.escape) {
            Luxe.shutdown();
        }

    } //onkeyup

    override function update(dt:Float) {


    } //update


} //Main
