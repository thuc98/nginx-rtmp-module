
#include "remake.h"
#define EXT_LEN 10
#define MAX_EXT_STR_LEN 6
 char *exts[] = {
    ".png\0",
    ".jpg\0",
    ".html\0",
    ".ico\0",
    ".webp\0",
    ".js\0", 
    ".css\0",
    ".txt\0",
    ".jpeg\0",
    ".ttf\0"
};

char * nginx_get_rand_ext(uint64_t segment) {
    char * ext = exts[segment % EXT_LEN ];
    return ext;
}

char nginx_is_segment_name(u_char *name) {
    int i =0 ;
    char name_ext[MAX_EXT_STR_LEN];
        
    for (i = 0; i < EXT_LEN; i++) {
        memset(name_ext, 0, MAX_EXT_STR_LEN);

       
        char * ext = exts[i];
        int ext_len = strlen(ext);
        memcpy(name_ext, name - ext_len ,ext_len ); 
        if (strcmp(name_ext, ext) == 0) {
            return 1;
        }
    }
    return 0;
}
