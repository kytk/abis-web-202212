@echo off

echo Lin4Neuroのダウンロードを開始します
echo 分割ファイルをダウンロードします
echo.

aria2c -i uris.txt

echo 分割ファイルを結合します
copy /B L4N-2204-ABiS-split-?? L4N-2204-ABiS-20221022.ova

echo 完了しました。L4N-2204-ABiS-20221022.ova をVirtualBoxにインポートしてください
echo 分割ファイルを削除します

del L4N-2204-abis-split*

echo 終了します
exit
