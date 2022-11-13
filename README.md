# ABiS脳画像解析チュートリアル22.12

ここは、2022年12月11日、および17-18日に開催予定である **『先端バイオイメージング支援プラットフォーム・ABiSチュートリアル』** の受講者を対象とした情報提供サイトです。新しい情報があれば、随時このサイトへ追加していきますので、定期的にアクセスするようにして下さい

## 目次

- [新着情報](#anchor0)
- [チュートリアルのスケジュール](#anchor1)
- [受講のための準備](#anchor2)
    - [パソコンのスペック](#anchor2_0)
    - 解析環境のセットアップ
        - [チュートリアル用Lin4Neuroのセットアップ](#anchor2_1)
        - [macOSネイティブ環境でのソフトウェアセットアップ](#anchor2_2)
    - [チュートリアルテキストの入手](#anchor2_3)
    - [データの入手](#anchor2_4)
    - [受講のためのスクリプト実行](#anchor2_5)
- [問い合わせ](#anchor3)


<a id="anchor0"></a>

## 新着情報

- 2022.11.08 Lin4Neuroおよびmac native環境のセットアップについて記載しました
- 2022.10.28 タイムスケジュールについて記載しました
- 2022.10.09 チュートリアル用ウェブサイトを立ち上げました


<a id="anchor1"></a>

## チュートリアルのスケジュール (予定)

| 日程 | 内容
| :-- | :--
| 12月11日(日) | 脳画像解析入門（脳画像解析初心者は受講をお勧めします)
| 08:30 | Zoomオープン
| 09:00-09:05 | 開会
| 09:05-09:20 | オリエンテーション
| 午前 | 脳画像解析ソフトの紹介、DICOM画像の取り扱い、NIFTI画像への変換
| 午後 | 画像統計解析の基礎、コマンドライン入門、スクリプト入門
| |
| 12月17日(土) | FreeSurferチュートリアル
| 08:30 | Zoomオープン
| 09:00-09:05 | 開会
| 09:05-09:20 | オリエンテーション
| 午前 | 前処理、前処理後の画像の見方、トラブルシューティング
| 午後 | ROI解析、グループ解析など
| |
| 12月18日(日) | 拡散MRIチュートリアル
| 08:30 | Zoomオープン
| 09:00-09:05 | 開会
| 09:05-09:20 | オリエンテーション
| 午前 | 前処理、TBSS、器質的異常がある場合の解析など
| 午後 | TBSS後の結果表示と追加解析

<a id="anchor2"></a>

## 受講のための準備

- チュートリアルはご自身の環境で受講していただきます。そのために事前準備が必須となっております。講師と同じ環境で解析をするため、仮想化ソフト VirtualBox を使用し、そのうえで、脳画像解析に特化したLinux, Lin4Neuro を使いながらチュートリアルは進めていきます。(なお、Apple M1/M2 CPUをお使いの方は VirtualBox が正式に対応していないので、個別にソフトウェアをセットアップしていただくことになります。) 事前準備を済ませたうえで、受講のためのスクリプトを実行し、それが正しい結果を出した方にZoomおよびSlackのアドレスをお示しします。早めにご準備のほどよろしくお願いします。なお、今回お配りするLin4Neuroは2022年12月および2023年1月用に最適化されています。2022年1月以前のLin4Neuroにはソフトが入っていないものがいくつもありますので、改めてセットアップをお願いします

<a id="anchor2_0"></a>

### パソコンのスペック

- チュートリアルでは、受講者にご自身でPCを準備して頂き、実際に操作しながらコマンドラインについて学んでいきます。PCのスペックについては、以下の **推奨条件** を参考にして下さい

    - OS: Windows 10/11 64bit版 または macOS 11.x (Big Sur) - 12.x (Monterey)
    - CPU: Intel Core i7/i9、Intel Core i5（クロック周波数2.0GHz以上）、または AMD Ryzen 5以上の性能を有するもの 
        - **注意: 現在、Apple M1/M2はVirtualBoxでLin4Neuroを動作できないため、チュートリアルで使用するソフトは個別にインストールしていただく必要があります。完全なサポートができないことをご承知おきください**
    - メモリ：8GB以上 (可能ならば16GB以上を推奨します)
    - ハードディスク：250GB以上の空き容量 (外付けハードディスクも可)
    - 2ボタン以上のUSBマウス (必須ではありませんが、持っていると便利です)
    - 2画面のディスプレイ (自身の作業用とZoomの画面をうつすために2画面を推奨します。2画面が準備できない方は、Zoomの画面をうつすためだけのPCやタブレットを準備してください)

### 解析環境のセットアップ

<a id="anchor2_1"></a>

#### チュートリアル用Lin4Neuroのセットアップ (所要時間約2-3時間) 

- チュートリアル用Lin4Neuroのセットアップは[こちらのインストラクション](./setup_l4n_2022.md){:target="_blank"} に従って準備を進めてください。

<a id="anchor2_2"></a>
#### macOS ネイティブ環境でのソフトウェアセットアップ (所要時間約3-4時間)

- Apple M1/M2 の方は、各自でソフトウェアをインストールしていただく必要があります。また、Intel Mac をお使いの方で、ネイティブ環境で構築したい場合もあるかと思います。その場合は[こちらのインストラクション](./setup_macnative_2022.md){:target="_blank"} に従って準備を進めてください。

<a id="anchor2_3"></a>
### チュートリアルテキストの入手 (所要時間約3分) 

- チュートリアルで使用するテキストは、GitLabというデータ共有サービスを通して配布します。ここで配布されるものは、チュートリアルの1週間前まで更新される可能性がありますので、こまめに（特に参加直前に）アップデートするようにして下さい

- macOS ネイティブ環境で参加される方は、以下のコマンドにより、ホームディレクトリの下に abis フォルダを作成します。このようにすることで、iCloud の管理外になりますので、iCloudが問題になることを防ぐことができます

   ```
   mkdir ~/abis
   ```

1. 初めてセットアップする時: ターミナルから以下を実行してください。なお、ターミナルは、Lin4Neuro では左下のスタートアイコンの隣にあるアイコンから起動できます。macOSの方はユーティリティからターミナルを実行してくだい

    ```
    cd ~/abis
    受講者仮決定メールに記されているコマンドをここにタイプします
    (セキュリティの都合でここには記しません)
    ```

2. 更新する時: ターミナルから以下を実行してください

    ```
    cd ~/abis/abis-202212
    git pull
    ```

- こうすると、`~/git/abis/abis-202212` の下に `beginner`, `dti`, `dti2`, `freesurfer`, `textbook` のフォルダが生成されます

<a id="anchor2_4"></a>
### データの入手 (所要時間約1時間)

- チュートリアルに使うデータは大きいため、GitLabではなく、別にダウンロードしていただきます

- 上記のテキストの入手を行った後、ターミナルから以下をタイプしてください

    ```
    cd ~/abis/abis-202212
    ./get_data.sh
    ```

- データが10GB程度ありますので、約1時間程度見込んでください。環境によってはさらに時間がかかってしまうことがあるため、電源を必ずつなぎ、パソコンがスリープしないようにしてください

- こうすると、`abis-202212` の `beginner`, `dti`, `dti2`, `freesurfer` の中にそれぞれデータが準備されます

<a id="anchor2_5"></a>
### 受講のためのスクリプト実行 (所要時間約45分) 

- 環境がすべて整っているかを確認するために、確認スクリプトを実行していただきます

- ターミナルから以下をタイプしてください

    ```
    cd ~/abis/abis-202212
    ./abis_test.sh
    ```

- そうすると以下が表示されます

    ```
    FreeSurfer, FSL, MRtrix3 の動作確認を行います
    はじめて実行する場合は、45分程度かかります
    最後に出力される数値を報告してください
    yesまたはnoを入力してください
    ```

- `yes` をタイプすると、FreeSurferのコマンド 及び MRtrix と FSL の トラクトグラ
フィー作成のための準備コマンド が走りはじめます

- コマンドの実行が完了すると、ターミナルに以下が表示されます。

    ```
    ------------------------------------------------
    以下の数値を報告してください
    XXX
    ------------------------------------------------
    ```

- さらに、続いて以下が表示されます

    ```
  　数値報告用のフォームを開いてよろしいですか? 
  　yesまたはnoを入力してください
    ```

- `yes` をタイプすると、webブラウザー が立ち上がり、数値入力用の Googleフォーム が開きます

- Googleフォーム に必要項目をご入力ください
    
- 入力した数値が正しい場合には、その次の画面に受講者専用のSlackのリンクが表示されます。こちらからSlackに登録してください

    ![googleフォーム](img/google_form_1.png)

- もし、解析が途中で失敗した場合は、以下が表示されます

    ```
    なんらかの問題が起こっているようです
    問い合わせフォームからお問い合わせください
    ```

- 問い合わせフォームが立ち上がりますので、そこからトラブルシューティングを依頼してください

<a id="anchor3"></a>
## 問い合わせ

- 準備がうまくいかない時のために、問い合わせフォームを準備しています。こちらからご質問ください。数日以内に担当者から返信させていただきます

- [問い合わせフォーム](https://forms.gle/NNCjrKn4uQJeYKdg6){:target="_blank"} 



