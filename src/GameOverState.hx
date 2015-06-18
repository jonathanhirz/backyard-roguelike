import luxe.States;

class GameOverState extends State {

    public function new(_name:String) {

        super({ name:_name });

    } //new

    override function init() {


    } //init

    override function onenter<T>(_value:T) {

        //huge bloody text that says GAME OVER, hit space to restart


    } //onenter

    override function onleave<T>(_value:T) {


    } //onleave


} //GameOverState