package scenes;

import flash.geom.Point;
import scenes.ALevel;
import entities.AEntity;
import entities.Barrack;
import entities.Fort;
import entities.Node;
import entities.Grunt;

class FirstLevel extends ALevel
{
    private var _iaTimer : Int;
    private var _nodeFortEnemy : Node;
    
    public function new()
    {
        super(new Point(1000, 1200), new Point(500, 1085));
        // tech
        barrackOptions.push(Grunt);
        // forts
        var fortPlayer : Fort = new Fort(this, new Point(500, 1150), Owner.PLAYER);
        var fortEnemy : Fort = new Fort(this, new Point(500, 50), Owner.ENEMY);
        var nodeFortPlayer : Node = new Node(this, new Point(500, 1085), fortPlayer);
        var nodeFortEnemy : Node = new Node(this, new Point(500, 115), fortEnemy);
        fortPlayer.buildingOrder = nodeFortPlayer;
        fortEnemy.buildingOrder = nodeFortEnemy;
        // empty nodes
        var nodeEmptyPlayer : Node = new Node(this, new Point(895, 950));
        var nodeEmptyEnemy : Node = new Node(this, new Point(155, 250));
        // barrack A
        var barrackA : Barrack = new Barrack(this, new Point(50, 1000));
        var nodeBarrackA : Node = new Node(this, new Point(105, 1000), barrackA);
        barrackA.buildingOrder = nodeBarrackA;
        // barrack B
        var barrackB : Barrack = new Barrack(this, new Point(50, 550));
        var nodeBarrackB : Node = new Node(this, new Point(105, 550), barrackB);
        barrackB.buildingOrder = nodeBarrackB;
        // barrack C
        var barrackC : Barrack = new Barrack(this, new Point(950, 550));
        var nodeBarrackC : Node = new Node(this, new Point(895, 550), barrackC);
        barrackC.buildingOrder = nodeBarrackC;
        // barrack D
        var barrackD : Barrack = new Barrack(this, new Point(950, 200));
        var nodeBarrackD : Node = new Node(this, new Point(895, 200), barrackD);
        barrackD.buildingOrder = nodeBarrackD;
        // nodes links
        nodeFortPlayer.addWay(nodeEmptyPlayer);
        nodeFortPlayer.addWay(nodeBarrackA);
        nodeBarrackA.addWay(nodeBarrackB);
        nodeBarrackC.addWay(nodeBarrackB);
        nodeBarrackC.addWay(nodeEmptyPlayer);
        nodeBarrackC.addWay(nodeBarrackD);
        nodeBarrackB.addWay(nodeEmptyEnemy);
        nodeFortEnemy.addWay(nodeEmptyEnemy);
        nodeFortEnemy.addWay(nodeBarrackD);
        // enemy orders
        this._nodeFortEnemy = nodeFortEnemy;
        nodeFortEnemy.enemyOrder = 0;
        nodeEmptyEnemy.enemyOrder = 0;
        nodeBarrackD.enemyOrder = 0;
        nodeBarrackC.enemyOrder = 0;
        nodeBarrackB.enemyOrder = 0;
        nodeBarrackA.enemyOrder = 0;
        nodeEmptyPlayer.enemyOrder = 0;
        // init
        init();
        this._iaTimer = 500;
    }
    
    public override function enemy() : Void
    {
        if (0 == this._iaTimer) {
            if (0 == this._nodeFortEnemy.enemyOrder) {
                this._nodeFortEnemy.enemyOrder = 1;
            }
            else {
                this._nodeFortEnemy.enemyOrder = 0;
            }
            this._iaTimer = 500;
        }
        else {
            --this._iaTimer;
        }
    }
}