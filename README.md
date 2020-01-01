CEDICT-SQLITE3
==============

Sqlite3 database based on the ce-dict Chinese-English dictionary and
accompanying bash ETL script.

Bash `read` is extremely slow. If I did this again I would load the entire
cedict_1_0_ts_utf-8_mdbg.txt file into memory and iterate over it.
