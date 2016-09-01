//
//  LogicIn1024.h
//  LogicIn1024
//
//  Created by zhaimengyang on 15/12/7.
//  Copyright © 2015年 zhaimengyang. All rights reserved.
//


#define X 4
#define Y 4
//#define Start 6
#define Prov 2

void start(int *p, int toStart);

int* showMap(int (*p)[Y]);
int* show______Map(int *p);

void inPut(int (*p)[Y], int dire);

int provNums(int *p, int prov);

int isDied(int (*p)[Y]);
