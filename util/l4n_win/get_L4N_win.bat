@echo off

echo Lin4Neuro�̃_�E�����[�h���J�n���܂�
echo �����t�@�C�����_�E�����[�h���܂�
echo.

aria2c -i uris.txt

echo �����t�@�C�����������܂�
copy /B L4N-2204-ABiS-split-?? L4N-2204-ABiS-20221022.ova

echo �������܂����BL4N-2204-ABiS-20221022.ova ��VirtualBox�ɃC���|�[�g���Ă�������
echo �����t�@�C�����폜���܂�

del L4N-2204-abis-split*

echo �I�����܂�
exit
