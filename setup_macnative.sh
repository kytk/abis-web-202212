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

sleep 10


# xcode-select
echo "xcode-select がインストールされているか確認します"
chk_xcodeselect=$(which xcode-select | awk -F/ '{ print $NF }')
if [ ${chk_xcodeselect} = "xcode-select" ]; then
  echo "   xcode-select はすでにインストールされています"
else
  echo "   xcode-select のインストールが必要です"
  echo "   ダイアログに従ってください"
  xcode-select --install
fi

sleep 10


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

sleep 10


# octave
echo "Octave がインストールされているか確認します"
chk_octave=$(which octave | awk -F/ '{ print $NF }')
if [ ${chk_octave} = "octave" ]; then
  echo "   Octave はすでにインストールされています"
else
  echo "   Octave をインストールします"
  brew install octave
fi

sleep 10


# python3
echo "Python3 がインストールされているか確認します"
chk_python3=$(which python3 | awk -F/ '{ print $NF }')
if [ ${chk_python3} = "python3" ]; then
  echo "   Python3 はすでにインストールされています"
else
  echo "   Python3 をインストールします"
  brew install python3
fi

echo "python に対してパスが通っているか確認します"
which python > /dev/null
if [ $? -eq 1 ]; then
  echo "python を python3 にリンクします"
  py3path=$(which python3)
  pypath=${py3path%3}
  sudo ln -s -f $py3path $pypath
else
  echo "python で パスが通っています"
fi

sleep 10


# Jupyter notebook
echo "Jupyter notebook 及び bash_kernel と octave_kernel をインストールします"
pip3 install jupyter notebook
pip3 install bash_kernel
python3 -m bash_kernel.install
python3 -m octave_kernel install --user

sleep 10


# AlizaMS
echo "AlizaMS がインストールされているか確認します"
if [ -e /Applications/AlizaMS.app/Contents/MacOS/AlizaMS ]; then
  echo "   AlizaMS はすでにインストールされています"
else
  echo "   AlizaMS をインストールします"
  cd ~/Downloads
  [ ! -e AlizaMS-1.8.3.dmg ] && curl -OL https://github.com/AlizaMedicalImaging/AlizaMS/releases/download/v1.8.3/AlizaMS-1.8.3.dmg
  hdiutil attach AlizaMS-1.8.3.dmg
  cd /Volumes/AlizaMS-1.8.3
  cp -r AlizaMS.app Applications
  sleep 10
  hdiutil detach /Volumes/AlizaMS-1.8.3
fi

sleep 10


# MRIcroGL

function install_mricrogl () {
  echo "   MRIcroGL をダウンロードします"
  cd ~/Downloads
  if [ ! -e MRIcroGL_macOS.dmg ]; then
    curl -OL https://github.com/rordenlab/MRIcroGL/releases/download/v1.2.20220720/MRIcroGL_macOS.dmg
  fi
  hdiutil attach MRIcroGL_macOS.dmg
  cd /Volumes/MRIcroGL
  cp -r MRIcroGL.app Applications
  sleep 10
  hdiutil detach /Volumes/MRIcroGL
}

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

  echo "   .bashrc に記載がない場合、設定を記載します"
  grep MRIcroGL ~/.bash_profile > /dev/null
  if [ $? -eq 1 ]; then 
    echo '' >> ~/.bash_profile
    echo '#MRIcroGL' >> ~/.bash_profile
    echo 'PATH=$PATH:/Applications/MRIcroGL.app/Contents/Resources' >> ~/.bash_profile
  fi
fi

sleep 10


# Heudiconv and pydicom
echo "Heudiconv と Pydicom をインストールします"
pip3 install heudiconv pydicom

sleep 10


# tree 
echo "treeがインストールされているか確認します"
chk_tree=$(which tree | awk -F/ '{ print $NF }')
if [ ${chk_python3} = "tree" ]; then
  echo "   tree はすでにインストールされています"
else
  echo "   tree をインストールします"
  brew install tree
fi

sleep 10


# XQuartz
echo "XQuartz がインストールされているか確認します"
chk_xquartz=$(which xquartz | awk -F/ '{ print $NF }')
if [ ${chk_xquartz} = "xquartz" ]; then
  echo "   Xquartz はすでにインストールされています"
else
  echo "   Xquartz をインストールします"
  brew install --cask xquartz
fi

sleep 10


# FSL

function install_fsl () {
  cd ~/Downloads
  curl -O https://fsl.fmrib.ox.ac.uk/fsldownloads/fslinstaller.py
  python3 fslinstaller.py
}

echo "FSL がインストールされているか確認します"
chk_fsl=$(which fsl | awk -F/ '{ print $NF }')
if [ ${chk_fsl} = "fsl" ]; then
  echo "   FSL のバージョンを確認します"
  fslversion=$(cat /usr/local/fsl/etc/fslversion)
  if [ $fslversion = 6.0.5.2:dc6f4207 ]; then
    echo "   FSLは最新です"
  else
    echo "   FSLをアップデートします"
    install_fsl
  fi
else
  echo "   FSL をインストールします"
  install_fsl
fi

sleep 10


# MRtrix3
echo "MRtrix3 がインストールされているか確認します"
chk_mrtrix3=$(which mrconvert | awk -F/ '{ print $NF }')
if [ ${chk_mrtrix3} = "mrconvert" ]; then
  echo "   MRtrix3 はすでにインストールされています"
else
  echo "   MRtrix3 をインストールします"
  sudo bash -c "$(curl -fsSL https://raw.githubusercontent.com/MRtrix3/macos-installer/master/install)"
fi

sleep 10


# ANTs
echo "ANTs がインストールされているか確認します"
chk_ants=$(which ANTs | awk -F/ '{ print $NF }')
if [ ${chk_ants} = "ANTs" ]; then
  echo "   ANTs はすでにインストールされています"
else
  echo "   ANTs をインストールします"
  cd ~/Downloads
  curl -O https://gitlab.com/kytk/shell-scripts/-/raw/master/ANTs_installer_macOS.sh
  bash ANTs_installer_macOS.sh
fi

sleep 10


# FreeSurfer 7.3.2
echo "FreeSurfer 7.3.2 がインストールされているか確認します"
chk_fs=$(recon-all --version)
if [ ${chk_fs} = "freesurfer-darwin-macOS-7.3.2-20220804-6354275" ]; then
  echo "   FreeSurfer 7.3.2 はインストールされています"
else
  echo "   FreeSurfer 7.3.2 をインストールします"
  cd ~/Downloads
  curl -O https://gitlab.com/kytk/fs-scripts/-/raw/master/fs_setup_7.3.2_mac.sh
  bash fs_setup_7.3.2_mac.sh
fi

sleep 10


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

# Reload ~/.bash_profile
source ~/.bash_profile

# FS7 MCRv97
echo "MCR R2019b が FreeSurferにインストールされているか確認します"
if [ -d $FREESURFER_HOME/MCRv97 ]; then
  echo "   MCRv97はインストールされています"
else 
  echo "   MCR R2019b をFS7のためにインストールします"
  ~/git/fs-scripts/fs7_dl_mcr2019b.sh
fi

sleep 10


# Slicer

function install_slicer () {
  cd ~/Downloads
  if [ ! -e Slicer-5.0.3-macosx-amd64.dmg ]; then
    curl -O https://www.nemotos.net/l4n-abis/macOS/Slicer-5.0.3-macosx-amd64.dmg
  fi
  hdiutil attach Slicer-5.0.3-macosx-amd64.dmg
  cd /Volumes/Slicer-5.0.3-macosx-amd64/
  cp -r Slicer.app Applications
  hdiutil detach /Volumes/Slicer-5.0.3-macosx-amd64
}

echo "Slicer がインストールされているか確認します"
if [ ! -d /Applications/Slicer.app ]; then
  echo "   Slicer をインストールします"
  echo "   英語のLicense Agreementが表示されるので、最後Enterを押して"
  echo "   y をタイプしてください"
  sleep 30
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

sleep 10


#MATLAB
echo "Matlab がインストールされているか確認します"

chk_matlab=$(find / Applications/MATLAB_R*/bin -name 'matlab' 2>/dev/null | head -n 1 | awk -F/ '{ print $NF }')
if [ ${chk_matlab} = "matlab" ]; then
  echo "   Matlab はインストールされています"

  # SPM12
  echo "   SPM12 がインストールされているか確認します"
  cd
  if [ -d ~spm12 ]; then
    echo "   SPM12 はインストールされています"
  else
    git clone https://github.com/spm/spm12.git
   
  echo "セキュリティの問題を回避します。パスワードを入力してください"
  sudo xattr -r -d com.apple.quarantine ~/spm12
  sudo find ~/spm12 -name '*.mexmaci64' -exec spctl --add {} \;
  fi

  # CONN 21.a
  echo "CONN 21a がインストールされているか確認します"
  if [ -d ~/conn/conn21a ]; then
    echo "   CONN 21a はインストールされています"
  else
    echo "CONN 21a をインストールします"
    cd ~/Downloads
    if [ ! -e conn21a.zip ]; then
      curl -O https://www.nitrc.org/frs/download.php/12426/conn21a.zip
    fi
    mkdir conn21a
    unzip conn21a.zip -d conn21a
    cd conn21a
    mv conn conn21a
    [ ! -d ~/conn ] && mkdir ~/conn
    cp -r conn21a ~/conn
  fi

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
    hdiutil attach MATLAB_Runtime_R2020b_Update_8_maci64.dmg
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
  echo "CONN 21a がインストールされているか確認します"
  if [ -e /Applications/conn_standalone/conn.app ]; then
    echo "   CONN 21aはインストールされています"
  else
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
fi

echo "セットアップが完了しました"

