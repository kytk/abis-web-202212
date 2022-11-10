#!/bin/bash

# 2022年12月開催ABiSチュートリアル macOS native環境セットアップスクリプト

# xcode-select
echo "xcode-select のインストール"
chk_xcodeselect=$(which xcode-select | awk -F/ '{ print $NF }')
if [ ${chk_xcodeselect} != "xcode-select" ]; then
  echo "   xcode-select needs to be installed"
  echo "   Please follow the dialogue"
  xcode-select --install
else
  echo "   xcode-select is installed"
fi


# Homebrew
echo "Homebrewのインストール"
chk_homebrew=$(which brew | awk -F/ '{ print $NF }')
if [ "${chk_homebrew}" = "brew" ]; then
  echo "   Homebrew is installed"
else
  echo "   Homebrew is to be installed"
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

echo '# Homebrew' >> ~/.bash_profile
echo ‘eval “$(/opt/homebrew/bin/brew shellenv)”‘ >> ~/.bash_profile
eval "$(/opt/homebrew/bin/brew shellenv)"

# octave and python3
echo "octave と python3 のインストール"
brew install octave python3 

# Jupyter notebook
echo "Jupyter notebook のインストール"
pip3 install jupyter notebook
pip3 install bash_kernel
python3 -m bash_kernel.install
pip3 install octave_kernel

# AlizaMS
echo "AlizaMS のダウンロード"
cd ~/Downloads
curl -OL https://github.com/AlizaMedicalImaging/AlizaMS/releases/download/v1.8.3/AlizaMS-1.8.3.dmg


# MRIcroGL
echo "MRIcroGL のダウンロード"
curl -OL https://github.com/rordenlab/MRIcroGL/releases/download/v1.2.20220720/MRIcroGL_macOS.dmg

echo "#MRIcroGL" >> ~/.bash_profile
echo '' >> ~/.bash_profile
echo '#MRIcroGL' >> ~/.bash_profile
echo 'PATH=$PATH:/Applications/MRIcroGL.app/Contents/Resources' >> ~/.bash_profile


# Heudiconv
echo "Heudiconv のインストール"
pip3 install heudiconv


# tree 
echo "tree のインストール"
brew install tree


# XQuartz
echo "XQuartz のインストール"
brew install --cask xquartz


# FSL
echo "FSL のインストール"
cd ~/Downloads
curl -O https://fsl.fmrib.ox.ac.uk/fsldownloads/fslinstaller.py
python3 fslinstaller.py


# MRtrix3
echo "MRtrix3 のインストール"
sudo bash -c "$(curl -fsSL https://raw.githubusercontent.com/MRtrix3/macos-installer/master/install)"


# ANTs
echo "ANTs のインストール"
cd ~/Downloads
curl -O https://gitlab.com/kytk/shell-scripts/-/raw/master/ANTs_installer_macOS.sh
bash ANTs_installer_macOS.sh


# FreeSurfer 7.3.2
echo "FreeSurfer のインストール"
cd ~/Downloads
curl -O https://gitlab.com/kytk/fs-scripts/-/raw/master/fs_setup_7.3.2_mac.sh
bash fs_setup_7.3.2_mac.sh

[ ! -d ~/git ] && mkdir ~/git
cd ~/git
git clone https://gitlab.com/kytk/fs-scripts.git
cd fs-scripts
echo '' >> ~/.bash_profile
echo '#PATH for fs-scripts' >> ~/.bash_profile
echo "export PATH=\$PATH:$PWD" >> ~/.bash_profile

~/git/fs-scripts/fs7_dl_mcr2019b.sh

# Slicer
echo "Slicer のダウンロード"
cd ~/Downloads
curl -O https://www.nemotos.net/l4n-abis/macOS/Slicer-5.0.3-macosx-amd64.dmg


# SPM12
echo "SPM12 のインストール"
cd
git clone https://github.com/spm/spm12.git

sudo xattr -r -d com.apple.quarantine ~/spm12
sudo find ~/spm12 -name '*.mexmaci64' -exec spctl --add {} \;


# CONN 21.a
echo "CONN 21a のインストール"
cd ~/Downloads
curl -O https://www.nitrc.org/frs/download.php/12426/conn21a.zip
mkdir conn21a
unzip conn21a.zip -d conn21a
cd conn21a
mv conn conn21a
[ ! -d ~/conn ] && mkdir ~/conn
cp -r conn21a ~/conn


echo "AlizaMS, MRIcroGL, Slicer はダウンロードフォルダにあるインストーラーを実行してください"
echo "Matlabから、/Users/$USER/spm12 と /Users/$USER/conn/conn21a をパスに追加してください"

echo "終了します"

