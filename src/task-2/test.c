#include<stdio.h>

int main() {
    int v[] = {3, 2, 8, 19, 36, 1, 4, 9};
    int len = 8;
    int i, j, aux;
    for(i = 0; i < len - 1; i++) {
        for(j = 0; j < len - i - 1; j++) {
            if(v[j]> v[j +1]) {
                aux = v[j];
                v[j] = v[j+1];
                v[j+1] = aux;
            }
        }
    }

    for(i = len - 1; i > 0; i--) {
        for(j = len -1; j > len - 1 - i; j--) {
            if(v[j]< v[j -1]) {
                aux = v[j];
                v[j] = v[j-1];
                v[j-1] = aux;
            }
        }
    }

    for (i = 0; i < len; i++){
        printf("%d ", v[i]);
    }
        printf("\n");
    return 0;

}