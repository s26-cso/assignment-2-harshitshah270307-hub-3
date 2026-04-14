#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <dlfcn.h>

#define MAX 128
#define OP 5

typedef int (*fnptr)(int, int);

int main() {
    char line[MAX];
    char op[OP + 1];

    int x, y;

    while (fgets(line, sizeof(line), stdin) != NULL) {

        int n = sscanf(line, "%5s %d %d", op, &x, &y);
        if (n != 3) {
            continue;
        }

        char lib[32];
        char p[] = "./lib";
        char s[] = ".so";

        snprintf(lib, sizeof(lib), "%s%s%s", p, op, s);

        void *h = dlopen(lib, RTLD_LAZY);
        if (h == NULL) {
            fprintf(stderr, "Failed to load %s\n", lib);
            continue;
        }

        dlerror();  

        fnptr f = (fnptr)dlsym(h, op);

        char *e = dlerror();
        if (e != NULL) {
            fprintf(stderr, "Failed to find symbol %s\n", op);
            dlclose(h);
            continue;
        }

        int ans = f(x, y);
        printf("%d\n", ans);

        dlclose(h);
    }

    return 0;
}
