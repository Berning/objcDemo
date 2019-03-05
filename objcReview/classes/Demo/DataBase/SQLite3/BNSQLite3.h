//
//  BNSQLite3.h
//  Xcode8
//
//  Created by uBerning on 2017/3/16.
//  Copyright © 2017年 BN. All rights reserved.
//

#ifndef BNSQLite3_h
#define BNSQLite3_h

SQLITE_API int SQLITE_STDCALL sqlite3_open(
                                           const char *filename,   /* Database filename (UTF-8) */
                                           sqlite3 **ppDb          /* OUT: SQLite db handle */
                                           );

SQLITE_API int SQLITE_STDCALL sqlite3_exec(
                                sqlite3*,                                  /* An open database */
                                const char *sql,                           /* SQL to be evaluated */
                                int (*callback)(void*,int,char**,char**),  /* Callback function */
                                void *,                                    /* 1st argument to callback */
                                char **errmsg                              /* Error msg written here */
                                );


SQLITE_API int SQLITE_STDCALL sqlite3_close(sqlite3*);
SQLITE_API int SQLITE_STDCALL sqlite3_close_v2(sqlite3*);
    


#endif /* BNSQLite3_h */
