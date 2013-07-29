package scenes;

import flash.geom.Point;
import scenes.ALevel;
import entities.AEntity;
import entities.Barrack;
import entities.Fort;
import entities.Node;
import entities.Grunt;
import entities.Psycho;

class FourthLevel extends ALevel
{
    private var _iaTimer : Int;
    private var _nodeFortEnemy : Node;
    private var _nodeBarrackEnemy : Node;
    private var _nodeEmptyEnemy : Node;
    private var _nodeBarrackCenterEnemy : Node;
    
    public function new()
    {
        super(new Point(1000, 1400), new Point(500, 1285));
        // tech
        barrackOptions.push(Grunt);
        barrackOptions.push(Psycho);
        // forts
        var fortPlayer : Fort = new Fort(this, new Point(500, 1350), Owner.PLAYER);
        var nodeFortPlayer : Node = new Node(this, new Point(500, 1285), fortPlayer);
        var fortEnemy : Fort = new Fort(this, new Point(500, 50), Owner.ENEMY);
        var nodeFortEnemy : Node = new Node(this, new Point(500, 115), fortEnemy);
        fortPlayer.buildingOrder = nodeFortPlayer;
        fortEnemy.buildingOrder = nodeFortEnemy;
        var barrackPlayer : Barrack = new Barrack(this, new Point(500, 1050));
        var nodeBarrackPlayer : Node = new Node(this, new Point(500, 1115), barrackPlayer);
        var barrackEnemy : Barrack = new Barrack(this, new Point(500, 350));
        var nodeBarrackEnemy : Node = new Node(this, new Point(500, 285), barrackEnemy);
        barrackPlayer.buildingOrder = nodeBarrackPlayer;
        barrackEnemy.buildingOrder = nodeBarrackEnemy;
        // sub
        var barrackSubPlayer : Barrack = new Barrack(this, new Point(50, 1350));
        var nodeBarrackSubPlayer : Node = new Node(this, new Point(50, 1285), barrackSubPlayer);
        var barrackSubEnemy : Barrack = new Barrack(this, new Point(950, 50));
        var nodeBarrackSubEnemy : Node = new Node(this, new Point(950, 115), barrackSubEnemy);
        barrackSubPlayer.buildingOrder = nodeBarrackSubPlayer;
        barrackSubEnemy.buildingOrder = nodeBarrackSubEnemy;
        // empty
        var nodeEmptyPlayer : Node = new Node(this, new Point(900, 1100));
        var nodeEmptyEnemy : Node = new Node(this, new Point(100, 200));
        // center
        var barrackCenterPlayer : Barrack = new Barrack(this, new Point(50, 700));
        var nodeBarrackCenterPlayer : Node = new Node(this, new Point(115, 700), barrackCenterPlayer);
        var barrackCenterEnemy : Barrack = new Barrack(this, new Point(950, 700));
        var nodeBarrackCenterEnemy : Node = new Node(this, new Point(885, 700), barrackCenterEnemy);
        var barrackCenter : Barrack = new Barrack(this, new Point(500, 600));
        var nodeBarrackCenter : Node = new Node(this, new Point(500, 700), barrackCenter);
        barrackCenterPlayer.buildingOrder = nodeBarrackCenterPlayer;
        barrackCenterEnemy.buildingOrder = nodeBarrackCenterEnemy;
        barrackCenter.buildingOrder = nodeBarrackCenter;
        // nodes links
        nodeFortPlayer.addWay(nodeBarrackPlayer);
        nodeFortEnemy.addWay(nodeBarrackEnemy);
        nodeFortPlayer.addWay(nodeBarrackSubPlayer);
        nodeBarrackPlayer.addWay(nodeBarrackSubPlayer);
        nodeFortEnemy.addWay(nodeBarrackSubEnemy);
        nodeBarrackEnemy.addWay(nodeBarrackSubEnemy);
        nodeFortPlayer.addWay(nodeEmptyPlayer);
        nodeBarrackPlayer.addWay(nodeEmptyPlayer);
        nodeFortEnemy.addWay(nodeEmptyEnemy);
        nodeBarrackEnemy.addWay(nodeEmptyEnemy);
        nodeBarrackCenter.addWay(nodeBarrackCenterPlayer);
        nodeBarrackCenter.addWay(nodeBarrackCenterEnemy);
        nodeBarrackCenter.addWay(nodeEmptyPlayer);
        nodeBarrackCenter.addWay(nodeEmptyEnemy);
        nodeBarrackCenterPlayer.addWay(nodeBarrackSubPlayer);
        nodeBarrackCenterEnemy.addWay(nodeBarrackSubEnemy);
        nodeBarrackCenterPlayer.addWay(nodeEmptyEnemy);
        nodeBarrackCenterEnemy.addWay(nodeEmptyPlayer);
        // enemy orders
        this._nodeFortEnemy = nodeFortEnemy;
        this._nodeBarrackEnemy = nodeBarrackEnemy;
        this._nodeEmptyEnemy = nodeEmptyEnemy;
        this._nodeBarrackCenterEnemy = nodeBarrackCenterEnemy;
        nodeFortEnemy.enemyOrder = 1;
        nodeBarrackEnemy.enemyOrder = 1;
        nodeEmptyEnemy.enemyOrder = 2;
        nodeBarrackSubEnemy.enemyOrder = 2;
        nodeBarrackCenterPlayer.enemyOrder = 1;
        // init
        init();
        this._iaTimer = 500;
    }
    
    public override function enemy() : Void
    {
        if (0 == this._iaTimer) {
            if (2 == this._nodeFortEnemy.enemyOrder) {
                this._nodeFortEnemy.enemyOrder = 1;
            }
            else if (1 == this._nodeFortEnemy.enemyOrder) {
                this._nodeFortEnemy.enemyOrder = 0;
            }
            else {
                this._nodeFortEnemy.enemyOrder = 2;
            }
            if (2 == this._nodeBarrackEnemy.enemyOrder) {
                this._nodeBarrackEnemy.enemyOrder = 1;
            }
            else {
                this._nodeBarrackEnemy.enemyOrder = 2;
            }
            if (3 == this._nodeEmptyEnemy.enemyOrder) {
                this._nodeEmptyEnemy.enemyOrder = 2;
            }
            else {
                this._nodeEmptyEnemy.enemyOrder = 3;
            }
            if (2 == this._nodeBarrackCenterEnemy.enemyOrder) {
                this._nodeBarrackCenterEnemy.enemyOrder = 0;
            }
            else {
                this._nodeBarrackCenterEnemy.enemyOrder = 2;
            }
            this._iaTimer = 500;
        }
        else {
            --this._iaTimer;
        }
    }
}