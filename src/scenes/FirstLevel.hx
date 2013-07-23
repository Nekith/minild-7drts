package scenes;

import flash.geom.Point;
import scenes.ALevel;
import entities.AEntity;
import entities.Barrack;
import entities.Fort;
import entities.Node;

class FirstLevel extends ALevel
{
    public function new()
    {
        super(new Point(900, 1200), new Point(450, 1100));
        // forts
        var fortPlayer : Fort = new Fort(this, new Point(450, 1150), Owner.PLAYER);
        addEntity(fortPlayer);
        var fortEnemy : Fort = new Fort(this, new Point(450, 50), Owner.ENEMY);
        addEntity(fortEnemy);
        var nodeFortPlayer : Node = new Node(this, new Point(450, 1085), fortPlayer);
        addEntity(nodeFortPlayer);
        var nodeFortEnemy : Node = new Node(this, new Point(450, 115), fortEnemy);
        addEntity(nodeFortEnemy);
        // empty nodes
        var nodeEmptyPlayer : Node = new Node(this, new Point(795, 1000));
        addEntity(nodeEmptyPlayer);
        var nodeEmptyEnemy : Node = new Node(this, new Point(105, 200));
        addEntity(nodeEmptyEnemy);
        // barrack A
        var barrackA : Barrack = new Barrack(this, new Point(50, 1000));
        addEntity(barrackA);
        var nodeBarrackA : Node = new Node(this, new Point(105, 1000), barrackA);
        addEntity(nodeBarrackA);
        // barrack B
        var barrackB : Barrack = new Barrack(this, new Point(50, 550));
        addEntity(barrackB);
        var nodeBarrackB : Node = new Node(this, new Point(105, 550), barrackB);
        addEntity(nodeBarrackB);
        // barrack C
        var barrackC : Barrack = new Barrack(this, new Point(850, 550));
        addEntity(barrackC);
        var nodebarrackC : Node = new Node(this, new Point(795, 550), barrackC);
        addEntity(nodebarrackC);
        // barrack D
        var barrackD : Barrack = new Barrack(this, new Point(850, 200));
        addEntity(barrackD);
        var nodeBarrackD : Node = new Node(this, new Point(795, 200), barrackD);
        addEntity(nodeBarrackD);
        // nodes links
        nodeFortPlayer.addWay(nodeEmptyPlayer);
    }
}