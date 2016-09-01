//
//  LogicIn1024.c
//  MyGame1024
//
//  Created by zhaimengyang on 8/31/16.
//  Copyright © 2016 zhaimengyang. All rights reserved.
//

#include "LogicIn1024.h"
#include <stdlib.h>

void calcUp(int (*p)[Y]){
    for (int t = 0, i = X-1; t < X-1; t++) {
        for (int tem_i = i; tem_i > 0; tem_i--) {
            for (int j = 0; j < Y; j++) {
                if (*(*(p+tem_i-1) + j) == 0) {
                    *(*(p+tem_i-1) + j) = *(*(p+tem_i) + j);
                    *(*(p+tem_i) + j) = 0;
                } else if (*(*(p+tem_i-1) + j) == *(*(p+tem_i) + j)) {
                    *(*(p+tem_i-1) + j) += 1;
                    *(*(p+tem_i) + j) = 0;
                }
            }
        }
        i--;
    }
    
    for (int i = X-1; i > 0; i--) {
        for (int j = 0; j < Y; j++) {
            if (*(*(p+i-1) + j) == 0) {
                *(*(p+i-1) + j) = *(*(p+i) + j);
                *(*(p+i) + j) = 0;
            }
        }
    }
}

void calcDown(int (*p)[Y]){
    for (int t = 0, i = 0; t < X-1; t++) {
        for (int tem_i = i; tem_i < X-1; tem_i++) {
            for (int j = 0; j < Y; j++) {
                if (*(*(p+tem_i+1) + j) == 0) {
                    *(*(p+tem_i+1) + j) = *(*(p+tem_i) + j);
                    *(*(p+tem_i) + j) = 0;
                } else if (*(*(p+tem_i+1) + j) == *(*(p+tem_i) + j)) {
                    *(*(p+tem_i+1) + j) += 1;
                    *(*(p+tem_i) + j) = 0;
                }
            }
        }
        i++;
    }
    
    for (int i = 0; i < X-1; i++) {
        for (int j = 0; j < Y; j++) {
            if (*(*(p+i+1) + j) == 0) {
                *(*(p+i+1) + j) = *(*(p+i) + j);
                *(*(p+i) + j) = 0;
            }
        }
    }
}

void calcLeft(int (*p)[Y]){
    for (int t = 0, j = Y-1; t < Y-1; t++) {
        for (int i = 0; i < X; i++) {
            for (int tem_j = j; tem_j > 0; tem_j--) {
                if (*(*(p+i) + (tem_j-1)) == 0) {
                    *(*(p+i) + (tem_j-1)) = *(*(p+i) + tem_j);
                    *(*(p+i) + tem_j) = 0;
                } else if (*(*(p+i) + (tem_j-1)) == *(*(p+i) + tem_j)) {
                    *(*(p+i) + (tem_j-1)) += 1;
                    *(*(p+i) + tem_j) = 0;
                }
            }
        }
        j--;
    }
    
    for (int i = 0; i < X; i++) {
        for (int j = Y-1; j > 0; j--) {
            if (*(*(p+i) + (j-1)) == 0) {
                *(*(p+i) + (j-1)) = *(*(p+i) + j);
                *(*(p+i) + j) = 0;
            }
        }
    }
}

void calcRight(int (*p)[Y]){
    for (int t = 0, j = 0; t < Y-1; t++) {
        for (int i = 0; i < X; i++) {
            for (int tem_j = j; tem_j < Y-1; tem_j++) {
                if (*(*(p+i) + (tem_j+1)) == 0) {
                    *(*(p+i) + (tem_j+1)) = *(*(p+i) + tem_j);
                    *(*(p+i) + tem_j) = 0;
                } else if (*(*(p+i) + (tem_j+1)) == *(*(p+i) + tem_j)) {
                    *(*(p+i) + (tem_j+1)) += 1;
                    *(*(p+i) + tem_j) = 0;
                }
            }
        }
        j++;
    }
    
    for (int i = 0; i < X; i++) {
        for (int j = 0; j < Y-1; j++) {
            if (*(*(p+i) + (j+1)) == 0) {
                *(*(p+i) + (j+1)) = *(*(p+i) + j);
                *(*(p+i) + j) = 0;
            }
        }
    }
}

void start(int *p, int toStart){
    int temp;
    int index;
    int tag[X*Y];
    
    for (int i = 0; i < X*Y; i++) {
        tag[i] = i;
    }
    for (int i = 0; i < toStart; i++) {
        temp = tag[index = arc4random_uniform(X*Y)];
        tag[index] = tag[X*Y - (i + 1)];
        tag[X*Y - (i + 1)] = temp;
    }
    
    for (int i = X*Y - toStart; i < X*Y; i++) {
        *(p + tag[i]) = arc4random_uniform(2) + 1;
    }
}

int isDied(int (*p)[Y]){
    for (int i = 0; i < X-1; i++) {
        for (int j = 0; j < Y-1; j++) {
            if (((*(*(p+i)+j)) == (*(*(p+i)+(j+1)))) || ((*(*(p+i)+j)) == (*(*(p+(i+1))+j))))
                return 1;
        }
    }
    return 0;
}

/*********************************************************/
/*    UISwipeGestureRecognizerDirectionRight = 1 << 0    */
/*    UISwipeGestureRecognizerDirectionLeft  = 1 << 1    */
/*    UISwipeGestureRecognizerDirectionUp    = 1 << 2    */
/*    UISwipeGestureRecognizerDirectionDown  = 1 << 3    */
/*********************************************************/
void inPut(int (*p)[Y], int dire){
    switch (dire) {
        case 1 << 2:calcUp(p);
            break;
            
        case 1 << 1:calcLeft(p);
            break;
            
        case 1 << 3:calcDown(p);
            break;
            
        case 1 << 0:calcRight(p);
            break;
            
        default:
            break;
    }
}

int provNums(int *p, int prov){
    int i1, i2, temp;
    int index = 0;
    int count = 0;
    int tag[X*Y] = {0};
    
    for (int i = 0; i < X*Y; i++) {
        if (*(p + i) == 0) {
            count++;
            tag[index++] = i;
        }
    }
    
    if (count >= 2) {
        i1 = tag[temp = arc4random_uniform(count)];
        for (int k = 0; k < count - temp - 1; k++) {
            tag[temp] = tag[temp+1];
            temp++;
        }
        i2 = tag[temp = arc4random_uniform(count-1)];
        
        *(p + i1) = arc4random_uniform(2) + 1;
        *(p + i2) = prov == 1 ? 0 : arc4random_uniform(2) + 1;
        return 1;
    }
    else if(count == 1){
        *(p + tag[0]) = arc4random_uniform(2) + 1;
        return 1;
    }
    else return 0;
}

int * showMap(int (*p)[Y]){
    int temp = 0;
    int *cp = malloc(16 * sizeof(int));
    
    for (int i = 0; i < X; i++) {
        for (int j = 0; j < Y; j++) {
            temp = p[i][j];
            switch (temp) {
                case 0:
                    *(cp+i*X + j) = 0;
                    break;
                case 1:
                    *(cp+i*X + j) = 2;
                    break;
                case 2:
                    *(cp+i*X + j) = 4;
                    break;
                case 3:
                    *(cp+i*X + j) = 8;
                    break;
                case 4:
                    *(cp+i*X + j) = 16;
                    break;
                case 5:
                    *(cp+i*X + j) = 32;
                    break;;
                case 6:
                    *(cp+i*X + j) = 64;
                    break;
                case 7:
                    *(cp+i*X + j) = 128;
                    break;
                case 8:
                    *(cp+i*X + j) = 256;
                    break;
                case 9:
                    *(cp+i*X + j) = 512;
                    break;
                case 10:
                    *(cp+i*X + j) = 1024;
                    break;
                case 11:
                    *(cp+i*X + j) = 2048;
                    break;
                case 12:
                    *(cp+i*X + j) = 4096;
                    break;
                case 13:
                    *(cp+i*X + j) = 8192;
                    break;
                    
                default:
                    *(cp+i*X + j) = 16384;
                    break;
            }
        }
    }
    
    return cp;
}

int* show______Map(int *p){
    int temp = 0;
    int *cp = malloc(16 * sizeof(int));
    for (int i = 0; i < X*Y; i++) {
        temp = *(p+i);
        switch (temp) {
            case 0:
                *(cp+i) = 0;
                break;
            case 1:
                *(cp+i) = 2;
                break;
            case 2:
                *(cp+i) = 4;
                break;
            case 3:
                *(cp+i) = 8;
                break;
            case 4:
                *(cp+i) = 16;
                break;
            case 5:
                *(cp+i) = 32;
                break;;
            case 6:
                *(cp+i) = 64;
                break;
            case 7:
                *(cp+i) = 128;
                break;
            case 8:
                *(cp+i) = 256;
                break;
            case 9:
                *(cp+i) = 512;
                break;
            case 10:
                *(cp+i) = 1024;
                break;
            case 11:
                *(cp+i) = 2048;
                break;
            case 12:
                *(cp+i) = 4096;
                break;
            case 13:
                *(cp+i) = 8192;
                break;
                
            default:
                *(cp+i) = 16384;
                break;
        }
    }
    
    return cp;
}

