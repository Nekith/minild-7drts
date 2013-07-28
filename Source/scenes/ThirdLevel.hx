package scenes;

import flash.geom.Point;
import scenes.ALevel;
import entities.AEntity;
import entities.Barrack;
import entities.Fort;
import entities.Node;
import entities.Grunt;
import entities.Psycho;

class ThirdLevel extends ALevel
{
    private var _iaTimer : Int;
    private var _nodeBarrackEnemy : Node;
    private var _nodeCenter : Node;
    
    public function new()
    {
        super(new Point(1000, 1400), new Point(500, 1285));
        // tech
        barrackOptions.push(Grunt);
        barrackOptions.push(Psycho);
        // forts
        var fortPlayer : Fort = new Fort(this, new Point(500, 1350), Owner.PLAYER);
        var fortEnemy : Fort = new Fort(this, new Point(500, 50), Owner.ENEMY);
        var nodeFortPlayer : Node = new Node(this, new Point(500, 1285), fortPlayer);
        var nodeFortEnemy : Node = new Node(this, new Point(500, 115), fortEnemy);
        fortPlayer.buildingOrder = nodeFortPlayer;
        fortEnemy.buildingOrder = nodeFortEnemy;
        var barrackPlayer : Barrack = new Barrack(this, new Point(800, 1350), Owner.PLAYER);
        var nodeBarrackPlayer : Node = new Node(this, new Point(800, 1285));
        var barrackEnemy : Barrack = new Barrack(this, new Point(200, 50), Owner.ENEMY);
        var nodeBarrackEnemy : Node = new Node(this, new Point(200, 115));
        barrackPlayer.buildingOrder = nodeBarrackPlayer;
        barrackEnemy.buildingOrder = nodeBarrackEnemy;
        // empty
        var nodeEmptyPlayer : Node = new Node(this, new Point(100, 1285));
        var nodeEmptyEnemy : Node = new Node(this, new Point(900, 115));
        // tricky
        var barrackTrickyPlayer : Barrack = new Barrack(this, new Point(35, 1000));
        var nodeTrickyPlayer : Node = new Node(this, new Point(100, 1000));
        var nodeBarrackTrickyPlayer : Node = new Node(this, new Point(300, 800), barrackTrickyPlayer);
        barrackTrickyPlayer.buildingOrder = nodeTrickyPlayer;
        var barrackTrickyEnemy : Barrack = new Barrack(this, new Point(965, 400));
        var nodeTrickyEnemy : Node = new Node(this, new Point(900, 400));
        var nodeBarrackTrickyEnemy : Node = new Node(this, new Point(700, 600), barrackTrickyEnemy);
        barrackTrickyEnemy.buildingOrder = nodeTrickyEnemy;
        // center
        var nodeCenter : Node = new Node(this, new Point(500, 700));
        // straight
        var straightBarrackPlayer : Barrack = new Barrack(this, new Point(800, 900));
        var nodeStraightBarrackPlayer : Node = new Node(this, new Point(735, 900), straightBarrackPlayer);
        var straightBarrackEnemy : Barrack = new Barrack(this, new Point(200, 500));
        var nodeStraightBarrackEnemy : Node = new Node(this, new Point(265, 500), straightBarrackEnemy);
        straightBarrackPlayer.buildingOrder = nodeStraightBarrackPlayer;
        straightBarrackEnemy.buildingOrder = nodeStraightBarrackEnemy;
        var nodeBehindStraightPlayer : Node = new Node(this, new Point(900, 900));
        var nodeBehindStraightEnemy : Node = new Node(this, new Point(100, 500));
        // nodes links
        nodeFortPlayer.addWay(nodeBarrackPlayer);
        nodeFortEnemy.addWay(nodeBarrackEnemy);
        nodeFortPlayer.addWay(nodeEmptyPlayer);
        nodeFortEnemy.addWay(nodeEmptyEnemy);
        nodeTrickyPlayer.addWay(nodeEmptyPlayer);
        nodeTrickyEnemy.addWay(nodeEmptyEnemy);
        nodeTrickyPlayer.addWay(nodeBarrackTrickyPlayer);
        nodeTrickyEnemy.addWay(nodeBarrackTrickyEnemy);
        nodeBarrackPlayer.addWay(nodeStraightBarrackPlayer);
        nodeBarrackEnemy.addWay(nodeStraightBarrackEnemy);
        nodeFortPlayer.addWay(nodeStraightBarrackPlayer);
        nodeFortEnemy.addWay(nodeStraightBarrackEnemy);
        nodeBehindStraightPlayer.addWay(nodeBarrackPlayer);
        nodeBehindStraightEnemy.addWay(nodeBarrackEnemy);
        nodeBehindStraightPlayer.addWay(nodeTrickyEnemy);
        nodeBehindStraightEnemy.addWay(nodeTrickyPlayer);
        nodeCenter.addWay(nodeBarrackTrickyPlayer);
        nodeCenter.addWay(nodeBarrackTrickyEnemy);
        nodeCenter.addWay(nodeStraightBarrackPlayer);
        nodeCenter.addWay(nodeStraightBarrackEnemy);
        // enemy orders
        this._nodeBarrackEnemy = nodeBarrackEnemy;
        this._nodeCenter = nodeCenter;
        nodeFortEnemy.enemyOrder = 1;
        nodeBarrackEnemy.enemyOrder = 2;
        nodeEmptyEnemy.enemyOrder = 1;
        nodeTrickyEnemy.enemyOrder = 1;
        nodeBarrackTrickyEnemy.enemyOrder = 1;
        nodeCenter.enemyOrder = 2;
        nodeStraightBarrackEnemy.enemyOrder = 2;
        nodeBehindStraightEnemy.enemyOrder = 1;
        // init
        init();
        this._iaTimer = 500;
    }
    
    public override function enemy() : Void
    {
        if (0 == this._iaTimer) {
            if (2 == this._nodeBarrackEnemy.enemyOrder) {
                this._nodeBarrackEnemy.enemyOrder = 1;
            }
            else {
                this._nodeBarrackEnemy.enemyOrder = 2;
            }
            if (4 == this._nodeCenter.enemyOrder) {
                this._nodeCenter.enemyOrder = 2;
            }
            else {
                this._nodeCenter.enemyOrder = 4;
            }
            this._iaTimer = 500;
        }
        else {
            --this._iaTimer;
        }
    }
}