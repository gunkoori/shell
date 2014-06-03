#!/bin/bash

echo ` date +"%Y/%m/%d %p %I:%M"`
echo 'クロール開始'
###############
#Directory作成
###############
BASEPATH=$(cd $(dirname $0) && pwd)
DATE=`date +'%Y%m%d'`
#ディレクトリが無いときは作成する
if [ ! -d "$BASEPATH/crawl_data/$DATE" ]; then
    mkdir -p $BASEPATH/crawl_data/$DATE
    cd $BASEPATH/crawl_data/$DATE
fi

#paginationの最大数取得
PAGE_NUMBER=(`curl http://aucfan.com/article/ | grep "page-number num" | grep -o "paged=.*" | grep -o ">.*" | grep -o ".*</a" | sed -e s'/^>//' | sed -e s'/<\/a$//' | tail -1`)


i=1
while [ $i -le $PAGE_NUMBER ]
do
    echo $iページ目の個別リンク取得中
    #オクトピの記事リンク取得書き込み
    curl http://aucfan.com/article/?paged=$i | grep "box_link" | grep -o "http://.*" | grep -o ".*\"" | grep -o ".*/" >> $BASEPATH/crawl_data/$DATE/auctopi_link.txt
    sleep 1s
    i=`expr $i + 1`
done;
