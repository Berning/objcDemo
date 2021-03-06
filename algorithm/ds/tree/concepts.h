//
//  concepts.h
//  algorithm
//
//  Created by Berning on 2018/10/18.
//  Copyright © 2018年 BN. All rights reserved.
//

#ifndef concepts_h
#define concepts_h

====结点：树是n（n≥0）个结点的有限集合T。当n=0时，称为空树；当n>0时， 该集合满足如下条件：
(1) 其中必有一个称为根（root）的特定结点，它没有直接前驱，但有零个或多个直接后继。
(2) 其余n-1个结点可以划分成m（m≥0）个互不相交的有限集T1，T2，T3，…，Tm，其中Ti又是一棵树，称为根root的子树。 每棵子树的根结点有且仅有一个直接前驱，但有零个或多个直接后继。

<relationship>

· 结点：包含一个数据元素及若干指向其它结点的分支信息。
· 结点的度：一个结点的子树个数称为此结点的度。
· 叶结点：度为0的结点，即无后继的结点，也称为终端结点。
· 分支结点：度不为0的结点，也称为非终端结点。
· 孩子结点：一个结点的直接后继称为该结点的孩子结点。在图6.1中， B、C是A的孩子。
· 双亲结点：一个结点的直接前驱称为该结点的双亲结点。在图6.1中，A 是B、C的双亲。
· 兄弟结点：同一双亲结点的孩子结点之间互称兄弟结点。在图6.1中，结点H、I、 J互为兄弟结点。
· 祖先结点：一个结点的祖先结点是指从根结点到该结点的路径上的所有结点。在图6.1中，结点K的祖先是A、B、E。
· 子孙结点：一个结点的直接后继和间接后继称为该结点的子孙结点。在图6.1中，结点D的子孙是H、I、 J、 M。
· 树的度： 树中所有结点的度的最大值。
· 结点的层次：从根结点开始定义，根结点的层次为1，根的直接后继的层次为2，依此类推。
· 树的高度（深度）： 树中所有结点的层次的最大值。
· 有序树：在树T中，如果各子树T(i)之间是有先后次序的，则称为有序树。
· 森林： m（m≥0）棵互不相交的树的集合。将一棵非空树的根结点删去，树就变成一个森林；反之，给森林增加一个统一的根结点，森林就变成一棵树。
</relationship>

====定义：我们把满足以下两个条件的树形结构叫做二叉树（Binary Tree）： 
（1） 每个结点的度都不大于2；
（2） 每个结点的孩子结点次序不能任意颠倒。

<character>
性质1: 在二叉树的第i层上至多有2^(i-1)个结点(i≥1)。
性质2: 深度为k的二叉树至多有2^k-1个结点（k≥1)。
性质3:对任意一棵二叉树T，若终端结点（度为0/叶结点）数为n0，而其度数为2的结点数为n2，则n0=n2+1。
n=n0+n1+n2
n=B+1
B=n1+2n2 //一个结点对应一个分支
n=B+1=n1+2n2+1
n0+n1+n2=n1+2n2+1
n0=n2+1

满二叉树：深度为k且有2k-1个结点的二叉树。
完全二叉树：深度为k，结点数为n的二叉树，如果其结点1~n的位置序号分别与满二叉树的结点1~n的位置序号一一对应，则为完全二叉树
* 满二叉树必为完全二叉树， 而完全二叉树不一定是满二叉树。

性质4：具有n个结点的完全二叉树的深度为［log2(n)］+1。
性质5:  对于具有n个结点的完全二叉树， 如果按照从上到下和从左到右的顺序对二叉树中的所有结点从1开始顺序编号， 则对于任意的序号为i的结点有： 
（1） 如i=1，则序号为i的结点是根结点， 无双亲结点； 如i>1， 则序号为i的结点的双亲结点序号为［i/2］。
（2） 如2×i>n，则序号为i的结点无左孩子；如2×i≤n，则序号为i的结点的左孩子结点的序号为2×i。
（3） 如2×i＋1>n，则序号为i的结点无右孩子；如2×i＋1≤n， 则序号为i的结点的右孩子结点的序号为2×i＋1。

</character>

->先序遍历（DLR）
->中序遍历（LDR）
->后续遍历 (LRD)

</character>



#endif /* concepts_h */
