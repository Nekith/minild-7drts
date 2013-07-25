package ;

import scenes.ALevel;
import entities.Node;

class Enemy
{
    public var regularSwitching(default, default) : Array<Node>;
    private var _level : ALevel;
    private var _cooldown : Int;
    
    public function new(level : ALevel)
    {
        regularSwitching = [];
        this._level = level;
        this._cooldown = 600;
    }
    
    public function update()
    {
        if (0 >= this._cooldown) {
            for (n in regularSwitching) {
                n.switchEnemyOrder();
            }
            this._cooldown = 600;
        }
        else {
            --this._cooldown;
        }
    }
}