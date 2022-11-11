#!/bin/bash

# 2022年12月開催ABiSチュートリアル macOS native環境セットアップスクリプト

log=$(date +%Y%m%d%H%M%S)-mac-setup.log
exec &> >(tee -a "$log")

echo "セットアップを開始します"
echo "FreeSurferのライセンスが~/Downloadsにあるかを確認します"
if [ -e ~/Downloads/license.txt ]; then
  echo "   license.txt がありましたので続けます"
else
  echo "   license.txt がありません"
  echo "   license.txt をダウンロードの下に置いてから再度実行してください"
  exit 1
fi


# xcode-select
echo "xcode-select がインストールされているか確認します"
chk_xcodeselect=$(which xcode-select | awk -F/ '{ print $NF }')
if [ ${chk_xcodeselect} != "xcode-select" ]; then
  echo "   xcode-select のインストールが必要です"
  echo "   ダイアログに従ってください"
  xcode-select --install
else
  echo "   xcode-select はすでにインストールされています"
fi


# Homebrew
echo "Homebrew がインストールされているか確認します"
chk_homebrew=$(which brew | awk -F/ '{ print $NF }')
if [ "${chk_homebrew}" = "brew" ]; then
  echo "   Homebrew はインストールされています"
  echo "   Homebrew をアップデートします"
  brew update && brew upgrade
else
  echo "   Homebrew をインストールします"
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

  if [ -e /usr/local/Homebrew/bin/brew ]; then
    brewpath='/usr/local/Homebrew/bin/brew'
  elif [ -e /opt/homebrew/bin/brew ]; then
    brewpath='/opt/homebrew/bin/brew'
  echo '# Homebrew' >> ~/.bash_profile
  echo 'eval "$("$brewpath" shellenv)"' >> ~/.bash_profile
  eval "$("$brewpath" shellenv)"
  fi
fi

# Reload ~/.bash_profile
source ~/.bash_profile

# octave
echo "Octave がインストールされているか確認します"
chk_octave=$(which octave | awk -F/ '{ print $NF }')
if [ ${chk_octave} != "octave" ]; then
  echo "   Octave をインストールします"
  brew install octave
else
  echo "   Octave はすでにインストールされています"
fi


# python3
echo "Python3 がインストールされているか確認します"
chk_python3=$(which python3 | awk -F/ '{ print $NF }')
if [ ${chk_python3} != "python3" ]; then
  echo "   Python3 をインストールします"
  brew install python3
else
  echo "   Python3 はすでにインストールされています"
fi


# Jupyter notebook
echo "Jupyter notebook 及び bash_kernel と octave_kernel をインストールします"
pip3 install jupyter notebook
pip3 install bash_kernel
python3 -m bash_kernel.install
pip3 install octave_kernel


# AlizaMS
echo "AlizaMS がインストールされているか確認します"
if [ -e /Applications/AlizaMS.app/Contents/MacOS/AlizaMS ]; then
  echo "   AlizaMS はすでにインストールされています"
else
  echo "   AlizaMS をインストールします"
  cd ~/Downloads
  [ ! -e AlizaMS-1.8.3.dmg ] && curl -OL https://github.com/AlizaMedicalImaging/AlizaMS/releases/download/v1.8.3/AlizaMS-1.8.3.dmg
  open AlizaMS-1.8.3.dmg
  cd /Volumes/AlizaMS-1.8.3
  cp -r AlizaMS.app Applications
  hdiutil eject /Volumes/AlizaMS-1.8.3
fi


# MRIcroGL
echo "MRIcroGL がインストールされているか確認します"
if [ -e /Applications/MRIcroGL.app/Contents/MacOS/MRIcroGL ]; then
  echo "   dcm2niix のバージョンを確認します"
  dcm2niix_version=$(/Applications/MRIcroGL.app/Contents/Resources/dcm2niix --version | awk '{ print $5 }')
  if [ ${dcm2niix_version} = 'v1.0.20220720' ]; then
    echo "   dcm2niix は最新です"
  else
    echo "   dcm2niix は古いため、最新版のMRIcroGL をインストールします"    
    install_mricrogl
  fi
else
  echo "   MRIcroGLをインストールします"
  install_mricrogl

  echo "   .bashrc に設定を記載します"
  echo '' >> ~/.bash_profile
  echo '#MRIcroGL' >> ~/.bash_profile
  echo 'PATH=$PATH:/Applications/MRIcroGL.app/Contents/Resources' >> ~/.bash_profile
fi

function install_mricrogl () {
  echo "   MRIcroGL をダウンロードします"
  cd ~/Downloads
  curl -OL https://github.com/rordenlab/MRIcroGL/releases/download/v1.2.20220720/MRIcroGL_macOS.dmg
  open MRIcroGL
  cd /Volumes/MRIcroGL
  cp -r MRIcroGL.app Applications
  hdiutil eject /Volumes/MRIcroGL
}


# Heudiconv and pydicom
echo "Heudiconv と Pydicom をインストールします"
pip3 install heudiconv pydicom


# tree 
echo "treeがインストールされているか確認します"
chk_tree=$(which tree | awk -F/ '{ print $NF }')
if [ ${chk_python3} != "tree" ]; then
  echo "   tree をインストールします"
  brew install tree
else
  echo "   tree はすでにインストールされています"
fi


# XQuartz
echo "XQuartz がインストールされているか確認します"
chk_xquartz=$(which xquartz | awk -F/ '{ print $NF }')
if [ ${chk_xquartz} != "xquartz" ]; then
  echo "   Xquartz をインストールします"
  brew install --cask xquartz
else
  echo "   Xquartz はすでにインストールされています"
fi


# FSL
echo "FSL がインストールされているか確認します"
chk_fsl=$(which fsl | awk -F/ '{ print $NF }')
if [ ${chk_fsl} != "fsl" ]; then
  echo "   FSL をインストールします"
  install_fsl
else
  echo "   FSL のバージョンを確認します"
  fslversion=$(cat /usr/local/fsl/etc/fslversion)
  if [ $fslversion = 6.0.5.2:dc6f4207 ]; then
    echo "   FSLは最新です"
  else
    echo "   FSLをアップデートします"
    install_fsl
  fi
fi

function install_fsl () {
  cd ~/Downloads
  curl -O https://fsl.fmrib.ox.ac.uk/fsldownloads/fslinstaller.py
  python3 fslinstaller.py
}


# MRtrix3
echo "MRtrix3 がインストールされているか確認します"
chk_mrtrix3=$(which mrconvert | awk -F/ '{ print $NF }')
if [ ${chk_mrtrix3} != "mrconvert" ]; then
  echo "   MRtrix3 をインストールします"
  sudo bash -c "$(curl -fsSL https://raw.githubusercontent.com/MRtrix3/macos-installer/master/install)"
else
  echo "   MRtrix3 はすでにインストールされています"
fi


# ANTs
echo "ANTs がインストールされているか確認します"
chk_ants=$(which ANTs | awk -F/ '{ print $NF }')
if [ ${chk_ants} != "ants" ]; then
  echo "   ANTs をインストールします"
  cd ~/Downloads
  curl -O https://gitlab.com/kytk/shell-scripts/-/raw/master/ANTs_installer_macOS.sh
  bash ANTs_installer_macOS.sh
else
  echo "   ANTs はすでにインストールされています"
fi


# FreeSurfer 7.3.2
echo "FreeSurfer 7.3.2 がインストールされているか確認します"
chk_fs=$(recon-all --version)
if [ ${chk_fs} != "freesurfer-darwin-macOS-7.3.2-20220804-6354275" ]; then
  echo "   FreeSurfer 7.3.2 をインストールします"
  cd ~/Downloads
  curl -O https://gitlab.com/kytk/fs-scripts/-/raw/master/fs_setup_7.3.2_mac.sh
  bash fs_setup_7.3.2_mac.sh
else
  echo "   FreeSurfer 7.3.2 はインストールされています"
fi


# fs-scripts
echo "fs-scriptsがあるか確認します"
if [ ! -d ~/git/fs-scripts ]; then
  echo "   fs-scriptsを準備します"
  [ ! -d ~/git ] && mkdir ~/git
  cd ~/git
  git clone https://gitlab.com/kytk/fs-scripts.git
  echo '' >> ~/.bash_profile
  echo '#PATH for fs-scripts' >> ~/.bash_profile
  echo "export PATH=\$PATH:$PWD" >> ~/.bash_profile
else
  echo "   fs-scriptsをアップデートします"
  cd ~/git/fs-scripts
  git pull
fi


# FS7 MCR R2019b
echo "MCR R2019b をFS7のためにインストールします"
~/git/fs-scripts/fs7_dl_mcr2019b.sh


# Slicer
echo "Slicer がインストールされているか確認します"
if [ ! -d /Applications/Slicer.app ]; then
  echo "   Slicer をインストールします"
  install_slicer
else
  echo "   Slicer のバージョンを確認します"
  if [ ! -d /Applications/Slicer.app/Contents/share/SLicer-5.0 ]; then
    echo "   Slicer 5.0 をインストールします"
    echo "   旧バージョンは Slicer-old.app となります"
    cd /Applications
    mv Slicer.app Slicer-old.app
    install_slicer
  fi
fi

function install_slicer () {
  cd ~/Downloads
  if [ ! -e Slicer-5.0.3-macosx-amd64.dmg ]; then
    curl -O https://www.nemotos.net/l4n-abis/macOS/Slicer-5.0.3-macosx-amd64.dmg
  fi
  cd /Volumes/Slicer-5.0.3-macosx-amd64/
  cp -r Slicer.app Applications
  hdiutil eject /Volumes/Slicer-5.0.3-macosx-amd64
}


#MATLAB
echo "Matlab がインストールされているか確認します"

chk_matlab=$(find / Applications/MATLAB=R*/bin -name 'matlab' | head -n 1 | awk -F/ '{ print $NF }')
if [ ${chk_matlab} = "matlab" ]; then
  echo "   Matlab はインストールされています"

  # SPM12
  echo "   SPM12 をインストールします"
  echo "   ホームディレクトリにspm12がある場合、spm12-oldとリネームします"
  cd
  if [ -d spm12 ]; then
    mv spm12 spm12-old
  fi
  git clone https://github.com/spm/spm12.git
   
  sudo xattr -r -d com.apple.quarantine ~/spm12
  sudo find ~/spm12 -name '*.mexmaci64' -exec spctl --add {} \;


  # CONN 21.a
  echo "CONN 21a をインストールします"
  cd ~/Downloads
  curl -O https://www.nitrc.org/frs/download.php/12426/conn21a.zip
  mkdir conn21a
  unzip conn21a.zip -d conn21a
  cd conn21a
  mv conn conn21a
  [ ! -d ~/conn ] && mkdir ~/conn
  cp -r conn21a ~/conn

  echo "Matlabから、/Users/$USER/spm12 と /Users/$USER/conn/conn21a をパスに追加してください"

else

  # Matlab Runtime
  echo "Matlab Runtime R2020b がインストールされているか確認します"
  if [ -d /Applications/MATLAB/MATLAB_Runtime/v99 ]; then
    echo "   Matlab Runtime R2020b はインストールされています"
  else
    echo "   Matlab Runtime をダウンロードします"
    cd ~/Downloads
    if [ ! -e MATLAB_Runtime_R2020b_Update_8_maci64.dmg.zip ]; then
      curl -O https://ssd.mathworks.com/supportfiles/downloads/R2020b/Release/8/deployment_files/installer/complete/maci64/MATLAB_Runtime_R2020b_Update_8_maci64.dmg.zip
    fi
    unzip MATLAB_Runtime_R2020b_Update_8_maci64.dmg.zip
    open MATLAB_Runtime_R2020b_Update_8_maci64.dmg
    echo "   インストーラーのGUIが立ち上がります"
    echo "   デフォルト通りにインストールしてください" 
    /Volumes/MATLAB_Runtime_R2020b_Update_8_maci64/InstallForMacOSX.app/Contents/MacOS/InstallForMacOSX
  fi
 
  # SPM12 standalone
  echo "SPM12 standalone をインストールします"
  cd ~/Downloads
  if [ ! -e spm12_standalone_maci64_v99.zip ]; then
    curl -O https://www.nemotos.net/l4n-abis/macOS/spm12_standalone_maci64_v99.zip
  fi
  sudo unzip spm12_standalone_maci64_v99.zip -d /opt/
  
  grep SPM12 ~/.bash_profile > /dev/null
  if [ $? -eq 1 ]; then
    echo "" >> ~/.bash_profile
    echo "# Alias for SPM12" >> ~/.bash_profile
    echo "alias spm='/opt/spm12_standalone/run_spm12.sh /Applications/MATLAB/MATLAB_Runtime/v99'" >> ~/.bash_profile
  fi  
  
  # CONN 21a 
  echo "CONN 21a standalone をインストールします"
  cd ~/Downloads
  if [ ! -e conn21a_standalone_maci64_v99.zip ]; then
    curl -O https://www.nemotos.net/l4n-abis/macOS/conn21a_standalone_maci64_v99.zip
  fi
  unzip conn21a_standalone_maci64_v99.zip -d /Applications/
  
  grep 'CONN 21.a' ~/.bash_profile > /dev/null
  if [ $? -eq 1 ]; then
    echo "" >> ~/.bash_profile
    echo "# Alias for CONN 21.a" >> ~/.bash_profile
    echo "alias conn='/Applications/conn21a_standalone/run_conn.sh /Applications/MATLAB/MATLAB_Runtime/v99'" >> ~/.bash_profile
  fi
fi

echo "セットアップが完了しました"

