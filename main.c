#include <stdio.h>

#include "socket_helper.h"
#include "config.h"



int main(void) {
    
    ///Loading configuration
    DatabaseConfig cfg;
    if(load_config("database.conf", &cfg) != 0)
        return 1;

    printf("[SUCCESS]: Config loaded:\n host = %s \n port = %u \n user = %s \n database = %s \n", 
            cfg.host, cfg.port, cfg.user, cfg.dbname);

    return 0;
}