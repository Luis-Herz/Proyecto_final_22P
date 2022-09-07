// Este programa invierte cada elemento del arreglo 'a'
// Creado por: Luis Enrique Hernandez Hernandez 
# define N 10
int a[N] = {468, 665, 922, 581, 401, 199, 213, 853, 782, 158};

int invierte(int a, int div, int x){
    int resul;
    if (div/10 >= 1){
        resul = a / div;
        a = a - (resul * div);
        a = invierte(a, div/10, x*10);
    } else {
        resul = a;
        a = 0;
    }
    a = (resul*x) + a;
    return a;
}

void inv(int *a, int n){
    int divisor = 100;
    int r;
    for (int i = 0; i < n; i++){
        r = invierte(a[i], divisor, 1);
        a[i] = r;
    }
    return;
}

int main () {
    inv(a, N);
    return 0;
}