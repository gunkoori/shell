#!/bin/bash

###############
#Directory作成
###############
DATE=`date +'%Y%m%d'`
#ディレクトリが無いときは作成する
if [ ! -d "$DATE" ]; then
    cd crawl_data
    mkdir $DATE
    cd $DATE
fi

#paginationの最大数取得
PAGINATION_NUMBER=(`curl http://aucfan.com/article/ | grep "page-number num" | grep -o "paged=.*" | grep -o ">.*" | grep -o ".*</a" | sed -e s'/^>//' | sed -e s'/<\/a$//'`)
MAX_PAGINATION_NUMBER=${PAGINATION_NUMBER[`expr ${#PAGINATION_NUMBER[@]} - 1`]}
i=1
while [ $i -lt $MAX_PAGINATION_NUMBER ]
do
    echo $i
    #オクトピの記事リンク
    AUCTOPI_LINK=`curl http://aucfan.com/article/?paged=$i | grep "box_link" | grep -o "http://.*" | grep -o ".*\"" | grep -o ".*/" >> auctopi_link.txt` 
    i=`expr $i + 1`
done;
