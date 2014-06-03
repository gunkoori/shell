echo キャッシュフォルダの削除
if [ -d /usr/local/bin/shell/imported ]; then
    rm -rf /usr/local/bin/shell/imported/
fi
echo キャッシュフォルダの削除完了

echo 'リンクの取得開始'
/usr/local/bin/shell/allget.sh
echo 'リンク取得の完了'

sleep 1s
echo '日付、タイトルの取得、書き出し'
/usr/local/bin/shell/auctopi.sh
echo 'ファイルへの書き出し完了'

sleep 1s
echo 'インポート完了'
sh /usr/local/bin/shell/import_db.sh
echo 'インポート完了'
echo date
echo ` date +"%Y/%m/%d %p %I:%M"`↲
echo 終了
