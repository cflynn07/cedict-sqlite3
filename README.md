CEDICT-SQLITE3
==============

Sqlite3 database based on the ce-dict Chinese-English dictionary and
accompanying bash ETL script.

Bash `read` is extremely slow. If I did this again I would load the entire
cedict_1_0_ts_utf-8_mdbg.txt file into memory and iterate over it.

```bash
$ echo ".schema dict | sqlite3 ce_dict.sqlite3
CREATE TABLE dict (  id          INTEGER PRIMARY KEY AUTOINCREMENT ,   simplified  VARCHAR(10),   traditional VARCHAR(10),   pinyin      VARCHAR(255),   definition  TEXT   );

$ echo ".schema dict" | sqlite3 ce_dict.sqlite3 &&  echo "SELECT * FROM dict LIMIT 10 OFFSET 1000" | sqlite3 ce_dict.sqlite3
1001|七邊形|七边形|qi1 bian1 xing2|heptagon
1002|七里河|七里河|Qi1 li3 he2|Qilihe District of Lanzhou City 蘭州市|兰州市[Lan2 zhou1 Shi4], Gansu
1003|七里河區|七里河区|Qi1 li3 he2 Qu1|Qilihe District of Lanzhou City 蘭州市|兰州市[Lan2 zhou1 Shi4], Gansu
1004|七里香|七里香|qi1 li3 xiang1|orange jasmine (Murraya paniculata)/chicken butt, popular Taiwan snack on a stick, made of marinated white cut chicken butt
1005|七零八碎|七零八碎|qi1 ling2 ba1 sui4|bits and pieces/scattered fragments
1006|七零八落|七零八落|qi1 ling2 ba1 luo4|(idiom) everything broken and in disorder
1007|七項全能|七项全能|qi1 xiang4 quan2 neng2|heptathlon
1008|七魄|七魄|qi1 po4|seven mortal forms in Daoism, representing carnal life and desires/contrasted with 三魂 three immortal souls
1009|七鰓鰻|七鳃鳗|qi1 sai1 man2|lamprey (jawless proto-fish of family Petromyzontidae)
1010|七龍珠|七龙珠|Qi1 long2 zhu1|Dragon Ball, Japanese manga and anime series
```
