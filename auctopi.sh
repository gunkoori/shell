#!/bin/bash
BASEPATH=$(cd $(dirname $0) && pwd)
FILEPATH="$BASEPATH/crawl_data/*"

for file in ${FILEPATH}
do
    echo $file読み込み中

    FILE=$file/auctopi_link.txt
#日付を配列で取得
while read line
do
    PUBDATE=`curl -s $line | grep 'sep">*'| grep -o ".*<\/span" |sed -e 's/<[^>]*>//g' | sed -e 's/日.*//' | sed -e 's/年/-/' | sed -e 's/月/-/' | sed -e 's/日//' | head -n 1 | xargs date +%Y%m%d -d`
echo ${PUBDATE[@]}
    #ディレクトリがないときは作成
    if [ ! -d "$BASEPATH/tsv_data/$PUBDATE" ]; then
       # if [ ! -d "$BASEPATH/tsv_data" ]; then
       #     mkdir  $BASEPATH/tsv_data
       # fi
        mkdir -p $BASEPATH/tsv_data/$PUBDATE
    fi

    #エンターのみを区切り文字として認識させる↲
    PRE_IFS=$IFS
    IFS=$'\n'

    #タイトルを配列で取得
    TITLE=`curl -s $line | grep "\<h1\>.*" | sed -e 's/<[^>]*>//g' | sed -e 's/^\s*//g' -e 's/\t//g'`

    function parameter () {
       pram=`curl -s  $line | grep 'canonical' | grep -o 'href="http://aucfan.com/article/.*' | grep -o 'article\/.*' | grep -o '.*\/\"' | sed -e 's/^article\///' | sed -e  's/\/\"//'`
       echo $pram
    }

    URL=`echo $line | sed -e 's/\t//g'`
    echo $URL
    PARAMETER=`parameter ${1}`
    #書き出し
    if [ ! -f "$BASEPATH/tsv_data/$PUBDATE/$PARAMETER.tsv" ]; then
        echo -e $PUBDATE\\t$TITLE\\t$URL >> $BASEPATH/tsv_data/$PUBDATE/$PARAMETER.tsv
    else
        echo 'すでにtsv形式で保存してあるデータです'
    fi
done<$FILE
IFS=$PRE_IFS

done;
