#!/bin/bash

BASEPATH=$(cd $(dirname $0) && pwd)
echo $BASEPATH
FILEPATH="$BASEPATH/tsv_data/*"

#tsvファイルをDBにインポート
for files in ${FILEPATH}
do
    for tsv_file in $(ls ${files})
    do
        echo $tsv_file
        if [ -f "$BASEPATH/imported/$tsv_file" ]; then
            echo すでに登録されてるデータは登録できません
        else
            echo $tsv_fileインポート中
            mysql -ucalendar -pcalendar cal_koori -e "LOAD DATA LOCAL INFILE '${files}/$tsv_file' INTO  TABLE auctopi (@date, @title, @link) SET date=@date, title=@title, link=@link, update_at=NOW(), created_at=NOW();"
            mkdir  -p $BASEPATH/imported 
            cp ${files}/$tsv_file $BASEPATH/imported/
        fi
    done
done
