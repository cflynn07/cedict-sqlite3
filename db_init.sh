#!/bin/bash
# db_init.sh

DATABASE_NAME=ce_dict.sqlite3
DB_BIN=sqlite3
DICT_FILE=cedict_1_0_ts_utf-8_mdbg.txt
NL=$'\r'
TOTAL_LINES=$(wc -l $DICT_FILE | awk '{ print $1 }')
readonly DATABASE_NAME
readonly DB_BIN
readonly DICT_FILE
readonly NL
readonly TOTAL_LINES

insert_sql_values=""
count=0

db_op() {
  if [[ $(echo "$1" | $DB_BIN $DATABASE_NAME 2>/dev/null) ]]; then
    # error
    echo "$1"
  fi
}

db_op "DROP TABLE dict"
db_op "CREATE TABLE dict (\
  id          INTEGER PRIMARY KEY AUTOINCREMENT , \
  simplified  VARCHAR(10), \
  traditional VARCHAR(10), \
  pinyin      VARCHAR(255), \
  definition  TEXT \
  )"

exec < $DICT_FILE
while read -r line
do
  line=${line%$NL}
  # ignore comment lines
  if [[ $line =~ ^\# ]]; then
    continue
  fi

  # EX:
  # 手機 手机 [shou3 ji1] /cell phone/mobile phone/CL:部[bu4],支[zhi1]/
  # CG1: traditional
  # CG2: simplified
  # CG3: pinyin
  # GG4: definition
  percent=$(echo "scale=2; ($count/$TOTAL_LINES)*100" | bc)
  if [[ $((count % 100)) -eq 0 ]]; then
    clear
    echo "$count/$TOTAL_LINES ($percent%)"
  fi
  line=${line//\"/}

  insert_sql_values=$(echo "$line" |
    perl -n -e'/(.+?) (.+?) \[(.+?)\]\ \/(.+)\//
      && print "INSERT INTO dict 
      (simplified, traditional, pinyin, definition)
      VALUES(\"$1\", \"$2\", \"$3\", \"$4\")"')

  db_op "$insert_sql_values"
  count=$(( count + 1 ))
done
