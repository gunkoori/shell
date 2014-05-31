./allget.sh
echo 'リンク取得の完了'

sleep 1s
./auctopi.sh
echo 'ファイルへの書き出し完了'

sleep 1s
./import_db.sh
echo 'インポート完了'
