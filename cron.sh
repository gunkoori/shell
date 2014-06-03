/usr/local/bin/shell/allget.sh
echo 'リンク取得の完了'

sleep 1s
/usr/local/bin/shell/auctopi.sh
echo 'ファイルへの書き出し完了'

sleep 1s
sh /usr/local/bin/shell/import_db.sh
echo 'インポート完了'
