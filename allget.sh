#!/bin/bash

###############
#Directory作成
###############
BASEPATH=$(pwd)
DATE=`date +'%Y%m%d'`
#ディレクトリが無いときは作成する
if [ ! -d "$BASEPATH/crawl_data" ]; then
   # mkdir $BASEPATH/crawl_data
    mkdir -p $BASEPATH/crawl_data/$DATE
    cd $BASEPATH/crawl_data/$DATE
fi

#paginationの最大数取得
PAGE_NUMBER=(`curl http://aucfan.com/article/ | grep "page-number num" | grep -o "paged=.*" | grep -o ">.*" | grep -o ".*</a" | sed -e s'/^>//' | sed -e s'/<\/a$//'`)
MAX_PAGE_NUMBER=${PAGE_NUMBER[`expr ${#PAGE_NUMBER[@]} - 1`]}
i=1
while [ $i -lt $MAX_PAGE_NUMBER ]
do
    echo $iページ目
    #オクトピの記事リンク
    curl http://aucfan.com/article/?paged=$i | grep "box_link" | grep -o "http://.*" | grep -o ".*\"" | grep -o ".*/" > auctopi_link.txt
    sleep 1s
    i=`expr $i + 1`
done;
