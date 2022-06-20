#include <stdlib.h>

int g = 100;

int main(){
    char * p = (char*) malloc(10000);
    *(p+100009) = 1;
    return 0;
}
