# macOS native 環境での ABiS チュートリアルの準備方法

- 本セクションでは、Lin4Neuro を使わずに、macOS native 環境でのチュートリアルのセットアップ方法を記載します。Apple M1/M2 でも対応可能です。ただし、この方法でのセットアップのサポートは限られることをご了承ください(個人個人で環境がかなり異なるためです)。このインストラクションを読んでわからないことが多い方は、ご自身でのセットアップは難しいとお考えいただき、Lin4Neuroでの受講としてください

## 前提条件

- CPUは Intel でも Apple M1/M2 でも問いません
- ターミナルはデフォルトの zsh でなく bash を使用することとします

## インストールが必要なソフトウェア
- git
- octave
- python3
- Jupyter Notebook (bashとoctaveカーネル含む)
- AlizaMS
- MRIcroGL
- XQuartz
- FSL
- MRtrix3
- 3D Slicer
- FreeSurfer
- Matlab
- SPM
- CONN


### git

#### インストール
- Command line tools for Xcode のインストールにより git を使うことが可能となります

```
xcode-select --install
```

#### 確認
- ターミナルから以下をタイプしていただき、バージョンが出力されれば大丈夫です

```
git --version
```

### Octave

#### インストール
- Homebrew 経由でインストールするのが簡単です。Homebrewのインストールは各自調べてください

```
brew install octave
```

#### 確認
- ターミナルから以下をタイプします

```
octave --version
```

- GNU Octave, version x.x.x と表示されればOKです 

### Python3

#### インストール
- https://www.python.org/ から Python 3.11.0 をダウンロードします。すでにPython3を使われている方ならあえてアップデートしなくても大丈夫です

- https://www.python.org/ftp/python/3.11.0/python-3.11.0-macos11.pkg

#### 確認
- ターミナルを起動し、以下をタイプしてください。Apple M1/M2の方は、Python 3.10.8以降であれば大丈夫です

```
python3 --version
```

### Jupyter Notebook および bash と octave のカーネル

#### インストール
- Pythonをインストールした後、以下を実行してください

```
pip3 install jupyter notebook
pip3 install bash_kernel
python3 -m bash_kernel.install
pip3 install octave_kernel
```

#### 確認
- ターミナルから以下をタイプしてください

```
jupyter-notebook
```

- WebブラウザにJupyterという画面が出ればOKです。そのページを消した後、Jupyter Notebookを起動したターミナルで、control + c を押すとJupyter Notebookのサーバーをシャットダウンできますので y を押してシャットダウンしてください

### AlizaMS

#### インストール
- AlizaMS は以下のリンクからインストーラーを入手できます
- https://github.com/AlizaMedicalImaging/AlizaMS/releases/download/v1.8.3/AlizaMS-1.8.3.dmg

#### 確認
- アプリケーションから AlizaMS を起動した後に、以下の画面になれば大丈夫です。

画面

#### 設定
- AlizaMS のデフォルトはフォントサイズが9ポイントと小さいので、調整します。見た目も明るい色にします
- 左上の"Application" -> "Settings" を選択します。
- "Application" タブで、Theme を "Cleanlooks" とします。
- 同様に、"Application" タブで、"12.0 pt" size for application font とフォントサイズを大きくします。


### MRIcroGL

#### インストール
- MRIcroGL は以下のリンクからインストーラーを入手できます
- https://github.com/rordenlab/MRIcroGL/releases/download/v1.2.20220720/MRIcroGL_macOS.dmg
- インストール後、以下のコマンドを実行し、.bash_profileに設定を書き込みます

```
echo '' >> ~/.bash_profile
echo '#MRIcroGL' >> ~/.bash_profile
echo 'PATH=$PATH:/Applications/MRIcroGL.app/Contents/Resources' >> ~/.bash_profile
```

#### 確認
- 一度ターミナルを終了し、ターミナルを再度起動した後に、以下をタイプしてください

```
dcm2niix --version
```

この結果が、v1.0.20220720 と表示されれば大丈夫です

### XQuartz
- XQuartz は FSL の実行のために必要です

#### インストール
- 以下からインストーラーを入手し、実行します
- https://github.com/XQuartz/XQuartz/releases/download/XQuartz-2.8.2/XQuartz-2.8.2.dmg

#### 確認
- FSLが実行されればXQuartzもきちんとインストールされるのでここでは確認しません

### FSL
#### インストール
- 以下をターミナルから実行し、fslinstaller.pyを入手し、実行します

```
cd ~/Downloads
curl -O https://fsl.fmrib.ox.ac.uk/fsldownloads/fslinstaller.py
cd ~/Downloads
python3 ./fslinstaller.py 
```

- インストール完了後、FSLの設定は .profile に記載されます。これが終わったら一度ターミナルを終了し、再びターミナルを起動します

#### 確認
- ターミナルから以下をタイプします
```
fsl
```

これでFSLが立ち上がればOKです

### MRtrix3
#### インストール
- ターミナルから以下を実行します

```
sudo bash -c "$(curl -fsSL https://raw.githubusercontent.com/MRtrix3/macos-installer/master/install)"
```

#### 確認
- ターミナルから以下を実行します

```
mrview
```

- MRViewが起動すれば大丈夫です

### 3D Slicer

#### インストール
- 以下のリンクからインストーラーをダウンロードし、実行します
- https://download.slicer.org/bitstream/62cc8ff3aa08d161a31c260a
- インストール後、3D Slicerを起動します


### Matlab
- Matlabは各自購入してください。Baseだけで大丈夫です。必要なバージョンは以下のリンクが参考になります
- https://jp.mathworks.com/support/requirements/previous-releases.html

### SPM
#### インストール
- GitHub経由が便利です
- ホームディレクトリの下に git というディレクトリを作成し、その下に spm12 をインストールすることとします

```
cd ~
mkdir git #なければ作成
git clone https://github.com/spm/spm12.git
```

- さらにターミナルから以下を実行します

```
sudo xattr -r -d com.apple.quarantine ~/git/spm12
sudo find ~/git/spm12 -name '*.mexmaci64' -exec spctl --add {} \;
```

- この後、Matlabのパス設定で、~/git/spm12 を指定してください

#### 確認
- Matlab から

```
spm
```

とタイプし、SPMが起動すればOKです

### CONN
#### インストール
- CONNは 21.a を使用します
- インストール方法は以下のリンクを参照してください
- https://www.nemotos.net/?p=3873

#### 確認
- Matlabから

```
conn
```

とタイプし、CONNが起動すればOKです

