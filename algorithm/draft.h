//
//  draft.h
//  objcDemo
//
//  Created by Berning on 2018/10/11.
//  Copyright © 2018年 BN. All rights reserved.
//

#ifndef draft_h
#define cdraft_h
//example-1
(i=2;i<=n; ++i;) (j=2; j<=i-1;++j;)
i=2, j<=1   ->0
i=3, j<=2   ->1
i=4, j<=3   ->2
.
.
.
i=n, j<=n-1 ->n-2

(n-2+0)(n-2+1)/2
(n-2)(n-1)/2

//bubble

//总共n个数，要向后交换n-1个数,所以交换的次数是n-2-0+1=n-1次
//交换第i个数（i趟）时，交换的次数为n-i-1次
(i=0;i<n-1;i++)  (int j = 0; j < n-i-1; ++j)

i=0     0=j<n-1   ->n-1
i=1     0=j<n-2   ->n-2
i=2     0=j<n-3   ->n-3
i=3     0=j<n-4   ->n-4
.
.
.
i=n-2   0=j<1     ->1

n(n-1)/2=(n^2-n)/2


//improve
(i=1,i<n,i++) (j=0;j<n-i)

i=1     0=j<n-1
i=2     0=j<n-2
.
.
.
i=n-1   0=j<1

n(n-1)/2=(n^2-n)/2


#endif /* craft_h */
