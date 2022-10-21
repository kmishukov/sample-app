//
//  bytes.c
//  Sound
//
//  Created by Author on 25.07.2022.
//

#include "bytes.h"
#include <stdlib.h>
#include <strings.h>

void *bytes_create(size_t size) {
    if (size <= 0) {
        return NULL;
    }

    void *result = malloc(size);
    memset(result, 0, size);
    return result;
}
