package scenes;

import flash.geom.Point;
import scenes.ALevel;
import entities.AEntity;
import entities.Barrack;
import entities.Fort;
import entities.Node;
import entities.Grunt;
import entities.Psycho;

class SecondLevel extends ALevel
{
    private var _iaTimer : Int;
    private var _nodeFortEnemy : Node;
    private var _nodeEmptyEnemy : Node;
    
    public function new()
    {
        super(new Point(1200, 1200), new Point(900, 1085));
        // tech
        barrackOptions.push(Grunt);
        barrackOptions.push(Psycho);
        // forts
        var fortPlayer : Fort = new Fort(this, new Point(900, 1150), Owner.PLAYER);
        var fortEnemy : Fort = new Fort(this, new Point(300, 50), Owner.ENEMY);
        var nodeFortPlayer : Node = new Node(this, new Point(900, 1085), fortPlayer);
        var nodeFortEnemy : Node = new Node(this, new Point(300, 115), fortEnemy);
        fortPlayer.buildingOrder = nodeFortPlayer;
        fortEnemy.buildingOrder = nodeFortEnemy;
        var barrackPlayer : Barrack = new Barrack(this, new Point(1100, 1150), Owner.PLAYER);
        var nodeBarrackPlayer : Node = new Node(this, new Point(1100, 1085), barrackPlayer);
        var barrackEnemy : Barrack = new Barrack(this, new Point(100, 50), Owner.ENEMY);
        var nodeBarrackEnemy : Node = new Node(this, new Point(100, 115), barrackEnemy);
        barrackPlayer.buildingOrder = nodeBarrackPlayer;
        barrackEnemy.buildingOrder = nodeBarrackEnemy;
        // center
        var nodeEmptyPlayer : Node = new Node(this, new Point(1000, 600));
        var nodeEmptyEnemy : Node = new Node(this, new Point(200, 600));
        var centerBarrack : Barrack = new Barrack(this, new Point(600, 550));
        var nodeCenterBarrack : Node = new Node(this, new Point(600, 615), centerBarrack);
        centerBarrack.buildingOrder = nodeCenterBarrack;
        // sub bases
        var nodeFastPlayer : Node = new Node(this, new Point(400, 900));
        var nodeFastEnemy : Node = new Node(this, new Point(800, 300));
        var subBarrackPlayer : Barrack = new Barrack(this, new Point(50, 1000));
        var nodeSubBarrackPlayer : Node = new Node(this, new Point(105, 1000), subBarrackPlayer);
        var subBarrackEnemy : Barrack = new Barrack(this, new Point(1150, 200));
        var nodeSubBarrackEnemy : Node = new Node(this, new Point(1085, 200), subBarrackEnemy);
        subBarrackPlayer.buildingOrder = nodeSubBarrackPlayer;
        subBarrackEnemy.buildingOrder = nodeSubBarrackEnemy;
        // nodes links
        nodeFortPlayer.addWay(nodeBarrackPlayer);
        nodeFortEnemy.addWay(nodeBarrackEnemy);
        nodeFortPlayer.addWay(nodeEmptyPlayer);
        nodeFortEnemy.addWay(nodeEmptyEnemy);
        nodeBarrackPlayer.addWay(nodeEmptyPlayer);
        nodeBarrackEnemy.addWay(nodeEmptyEnemy);
        nodeCenterBarrack.addWay(nodeEmptyPlayer);
        nodeCenterBarrack.addWay(nodeEmptyEnemy);
        nodeFortPlayer.addWay(nodeFastPlayer);
        nodeFortEnemy.addWay(nodeFastEnemy);
        nodeEmptyEnemy.addWay(nodeFastPlayer);
        nodeEmptyPlayer.addWay(nodeFastEnemy);
        nodeFortPlayer.addWay(nodeSubBarrackPlayer);
        nodeFortEnemy.addWay(nodeSubBarrackEnemy);
        nodeEmptyPlayer.addWay(nodeSubBarrackEnemy);
        nodeEmptyEnemy.addWay(nodeSubBarrackPlayer);
        nodeSubBarrackEnemy.addWay(nodeFastEnemy);
        nodeSubBarrackPlayer.addWay(nodeFastPlayer);
        // enemy orders
        this._nodeFortEnemy = nodeFortEnemy;
        this._nodeEmptyEnemy = nodeEmptyEnemy;
        nodeFortEnemy.enemyOrder = 2;
        nodeBarrackEnemy.enemyOrder = 1;
        nodeEmptyEnemy.enemyOrder = 2;
        nodeFastEnemy.enemyOrder = 1;
        nodeSubBarrackEnemy.enemyOrder = 1;
        // init
        init();
        this._iaTimer = 500;
    }
    
    public override function enemy() : Void
    {
        if (0 == this._iaTimer) {
            if (3 == this._nodeFortEnemy.enemyOrder) {
                this._nodeFortEnemy.enemyOrder = 2;
            }
            else {
                this._nodeFortEnemy.enemyOrder = 3;
            }
            if (3 == this._nodeEmptyEnemy.enemyOrder) {
                this._nodeEmptyEnemy.enemyOrder = 2;
            }
            else {
                this._nodeEmptyEnemy.enemyOrder = 3;
            }
            this._iaTimer = 500;
        }
        else {
            --this._iaTimer;
        }
    }
}