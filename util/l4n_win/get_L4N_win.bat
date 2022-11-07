@echo off

echo Lin4Neuroのダウンロードを開始します
echo 分割ファイルをダウンロードします
echo.

aria2c -i uris.txt

echo 分割ファイルを結合します
copy /B L4N-2004-ABIS-split-?? L4N-2004-ABIS-20221107.ova

echo 完了しました。L4N-2004-ABIS-20221107.ova をVirtualBoxにインポートしてください
echo 分割ファイルを削除します

del L4N-2004-ABIS-split*

echo 終了します
exit
