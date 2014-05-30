#!/bin/bash
DATE=`date +'%Y%m%d'`
FILEPATH='./crawl_data/*'

for file in ${FILEPATH}
do
    echo $file

    FILE=$file/auctopi_link.txt
#日付を配列で取得
while read line
do
    PUBDATE=`curl $line | grep 'sep">*'| grep -o ".*<\/span" |sed -e 's/<[^>]*>//g' | sed -e 's/日.*//' | sed -e 's/年/-/' | sed -e 's/月/-/' | sed -e 's/日//' | head -n 1 | xargs date +%Y%m%d -d` 

    #ディレクトリがないときは作成
    if [ ! -d "tsv_data/$PUBDATE" ]; then
        mkdir tsv_data/$PUBDATE
    fi

    #エンターのみを区切り文字として認識させる↲
    PRE_IFS=$IFS↲
    IFS=$'\n'↲

    #タイトルを配列で取得
    TITLE=`curl $line | grep "\<h1\>.*" | sed -e 's/<[^>]*>//g' | sed -e 's/^\s*//g'`

    #書き出し
    echo -e $PUBDATE\\t$TITLE\\t$line >> tsv_data/$PUBDATE/$PUBDATE.tsv

done<$FILE
IFS=$PRE_IFS

done