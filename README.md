# My GMTK Game jam demo

## 主题 ：Built to scale
- 元素：俄罗斯方块式的建造
- 元素：数字计算 几何大小及形状

## 游戏流程
     上方不断下落砖块，玩家控制砖块的下落来建造数学公式
     当每行被填满时，数学公式进行运算并将得到的结果加到最终值中
     玩家可以选择最终值的作用位置：玩家自身或者敌人
     为何正数作用玩家：当回合行动为攻击：作用玩家可以使得攻击造成的伤害增加
     为何负数作用玩家：当回合行动为受到攻击时：作用玩家可以使体积减少从而减少受到的攻击
     为何正数作用敌人：当敌人那边受到场地攻击时：作用敌人可以使敌人受到伤害增加
     为何负数作用敌人：当敌人那边行动为发出攻击时：作用敌人可以使敌人发出的伤害减少
     玩家生命或者敌人生命归零时游戏结算

## 关键设定
    每个砖块不一定要有数字或者符号 可以为空
    游戏追求在最短时间内击杀尽可能多的敌人
