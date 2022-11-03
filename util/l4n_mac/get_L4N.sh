#!/bin/bash
# ABiS チュートリアル用スクリプト
# 2022年12月, 2023年1月用のLin4Neuroを入手します

#For Debug
#set -x

# variable ################
baseurl="https://www.nemotos.net/l4n-abis/L4N-2204-ABIS-20221103-split"
base="L4N-2204-ABIS-split"
L4N="L4N-2204-ABIS-20221103.ova"
L4Ndir="L4N-2204-ABIS-20221103"
L4Nmd5="MD5(L4N-2204-ABIS-20221103.ova)= e758e458cbc1e3b3be9712a43da3baa3"
nfiles=29 # n-1
###########################

cd ~/Downloads
[ ! -d ${L4Ndir} ] && mkdir ${L4Ndir}
cd ${L4Ndir}


echo "チュートリアル用のLin4Neuroをダウンロードします"
echo ""

echo "${L4N}があるか確認します"
if [ ! -e ${L4N} ]; then
  echo "L4N分割データを確認し、なければダウンロードします"
  for n in $(seq -w 00 $nfiles);
  do
    if [ ! -e ${base}-${n} ]; then
      curl -O ${baseurl}/${base}-${n}.md5
      curl -O ${baseurl}/${base}-${n}
    fi 
    echo "${base}-${n}のファイルサイズを確認します"
    openssl md5 ${base}-${n} | cmp ${base}-${n}.md5 -
    while [ $? -ne 0 ]; do
      echo "ファイルサイズが一致しません"
      echo "再度ダウンロードします"
      curl -O ${baseurl}/${base}-${n}
      openssl md5 ${base}-${n} | cmp ${base}-${n}.md5 -
    done
  echo "ファイルサイズが一致しました"
  done
    
  echo "${L4N} を生成します"
  cat ${base}-?? > ${L4N}
fi

echo "${L4N} を検証します"
echo ${L4Nmd5} > ${L4N}.md5

openssl md5 ${L4N} | cmp ${L4N}.md5 -
while [ $? -ne 0 ]; do
  echo "ファイルサイズが一致しません"
  echo "再度結合します"
  cat ${base}-?? > ${L4N}
  openssl md5 ${L4N} | cmp ${L4N}.md5 -
done
echo "正しく${L4N}が生成されました"

#Delete temporary files
[ -e ${base}-00 ] && rm ${base}-*

echo ""
echo "L4Nの準備が完了しました。"
echo "ダウンロードの${L4Ndir}フォルダの中にある${L4N}をVirtualBoxにインポートしてください"
sleep 10

exit

