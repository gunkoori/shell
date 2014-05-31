#!/bin/bash
FILEPATH='./tsv_data/*'
#tsvファイルをDBにインポート
for files in ${FILEPATH}
do
    for tsv_file in $files/*
    do
        echo $tsv_fileインポート中
    mysql -ucalendar -pcalendar cal_koori -e "LOAD DATA LOCAL INFILE '$tsv_file' INTO  TABLE auctopi (@date, @title, @link)
SET  date=@date, title=@title, link=@link, update_at=NOW(), created_at=NOW();"
    done
done
