@ECHO OFF
@title Stable Diffusion WebUI �������ϰ���ѹ���ð�
@COLOR A
if exist %cd%\Python310 (
goto QAQ
) else (
echo ��⵱ǰ�汾Ϊһ������汾����ʹ��"�������ϰ�һ������.bat"������
pause
exit
)

:QAQ
ECHO ========================================
ECHO	    https://pd.qq.com/s/jrnm0f
ECHO	QQƵ���ѽ�����Ϊ������������Ƶ���������⡣
ECHO  NovelAI�ɻ������ɰɢ�Ⱥ��622540553�������� 
ECHO  NovelAI�ɻ������ɰɢ�Ⱥ��766973619�������� 
ECHO  NovelAI�ɻ������ɰɢ�Ⱥ��863917464��������
ECHO  NovelAI���ɻ������ɢ�Ⱥ: 752404915
ECHO  NovelAI�ɳ�Ʒͼ������Ⱥ��565321412�������� 
ECHO  NovelAI�ɳ�Ʒͼ������Ⱥ��789546203��������
ECHO  NovelAI�ɳ�Ʒͼ������Ⱥ��607051417 
ECHO  NovelAI�����ż�����������Ⱥ��680958149��������
ECHO  NovelAI�����ż�����������Ⱥ��662063867
ECHO ========================================
ECHO	 	  ��������һ�����������
echo  �������C�̻�ʹ�ô��ո�/����/������ŵ�·��
echo  �������C�̻�ʹ�ô��ո�/����/������ŵ�·��
echo  �������C�̻�ʹ�ô��ո�/����/������ŵ�·��
echo  �������C�̻�ʹ�ô��ո�/����/������ŵ�·��
echo  �������C�̻�ʹ�ô��ո�/����/������ŵ�·��
echo  �������C�̻�ʹ�ô��ո�/����/������ŵ�·��
echo  �������C�̻�ʹ�ô��ո�/����/������ŵ�·��
echo  �������C�̻�ʹ�ô��ո�/����/������ŵ�·��
echo  �������C�̻�ʹ�ô��ո�/����/������ŵ�·��
echo  �������C�̻�ʹ�ô��ո�/����/������ŵ�·��
echo  �������C�̻�ʹ�ô��ո�/����/������ŵ�·��
echo  �ᱨ���ᱨ���ᱨ���ᱨ���ᱨ���ᱨ��
@for  /f  "skip=4 delims="  %%x  in  (webui-user.bat)  do ^
set txt=%%x
if "%txt%" == "call webui.bat" (
goto I
) else (
ECHO ========================================
start https://pd.qq.com/s/jrnm0f
echo ���δ��ɲ������ڸ���Ϊ����ģʽ...
goto D
)

:I
set /p tb=��⵽��������ɣ���ѡ������ģʽ [1.ֱ������  2.�ٴβ���  3.������]:
if /i "%tb%"=="1" goto G
if /i "%tb%"=="2" goto D
if /i "%tb%"=="3" goto XF
echo ����ȷ����! & goto I

:D
ECHO ========================================
echo ��ʼ����Stable Diffusion WebUI
ECHO �뱣֤C��Ԥ��5G���Ͽռ�
ECHO �����п��ܳ��ּ�����������ʱ���޷�Ӧ�����س�������
echo ========================================
ECHO ���������У��˴���ʾ�Ҳ���XXXΪ��������
@del /s /q "%cd%\venv\Scripts" >nul
@rd /s /q "%cd%\venv\Scripts" >nul
@del /s /q "%cd%\venv\pyvenv.cfg" >nul
echo ========================================
echo ���˴���ʾ"��XCOPY�������ڲ����ⲿ���Ҳ���ǿ����еĳ�����������ļ�"
echo ����ʾ"�����⵽�ܾ�"������������ʧ��
echo ���ֶ�ǰ��"%cd%\deploy\"
echo ��".cache"�ļ����Ƶ�"C:\Users\%username%\"��
echo ========================================
xcopy "%cd%\deploy" "C:\Users\%username%\" /y /e >nul && echo ����ɹ��� || echo ����ʧ�ܣ����ֶ����ƣ� & pause

echo @echo off > webui-user.bat
ECHO title Stable Diffusion WebUI >> webui-user.bat
ECHO ECHO �����п��ܳ��ּ�����������ʱ���޷�Ӧ�����س������� >> webui-user.bat
echo set PYTHON=%CD%\Python310\python.exe>> webui-user.bat
echo set GIT=%cd%\GIT\git.exe>> webui-user.bat
echo set VENV_DIR=>> webui-user.bat
ECHO ========================================
ECHO ����Կ��ͺ���...
ECHO ========================================
@for /f "tokens=1" %%n in ('wmic path Win32_VideoController get AdapterCompatibility ^|findstr "NVIDIA"') do ^
set GPU=%%n
if "%GPU%" == "NVIDIA" (
echo ���ΪNVIDIA�Կ���������ʹ��GPUģʽ...
set ARGS=--autolaunch & goto E
) else (
goto T
)
ECHO ========================================

:T
echo ���Ϊ��NVIDIA�Կ�...
echo ========================================
set /p WQE=Ϊ�����������ȷ�������Ƿ�ΪN�� [1.��N��  2.����N��]:
if /i "%WQE%"=="1" set ARGS=--autolaunch & goto E
if /i "%WQE%"=="2" set ARGS=--skip-torch-cuda-test --lowvram --always-batch-cond-uncond --no-half --autolaunch & goto I
echo ����ȷ���� & goto T

:E
echo ========================================
echo �밴ʵ���Դ�ѡ��
echo ����ѵ��ģ�ͣ���ѡ��8G�������ұ�֤ʵ���Դ���8G������
set /p best=��ѡ���Դ�(1��3G����   2��4G�Դ�   3��6G�Դ�   4��16XXϵ���Կ�[��16ϵ���Կ�����] 5��8G������[���Ż�]):
if /i "%best%"=="1" set ARGS=%ARGS%--lowvram --always-batch-cond-uncond --no-half & goto R
if /i "%best%"=="2" set ARGS=%ARGS%--precision full --no-half --lowvram --always-batch-cond-uncond & goto R
if /i "%best%"=="3" set ARGS=%ARGS%--precision full --no-half --medvram & goto R
if /i "%best%"=="4" set ARGS=%ARGS%--lowvram --precision full --no-half & goto R
if /i "%best%"=="5" set ARGS=%ARGS%  & goto R

echo ����ȷ����! & goto E

:R
ECHO ========================================
ECHO �Ƿ���Ҫ����xformers,��ģʽ���Ż�"30%"����
set /p XF=����6G�������Դ�ѡ��,4G�����¿��ܵ��¸��Ż�(y/n):
if /i "%XF%"=="y" set ARGS=%ARGS%--xformers & goto I
if /i "%XF%"=="n" goto I
echo ����ȷ����! & goto R

:I
ECHO ========================================
ECHO �Ƿ���Ҫ����DeepDanBooru
set /p DD=�����ܸ�����AIѵ��(y/n):
if /i "%DD%"=="y" set ARGS=%ARGS%--deepdanbooru & goto P
if /i "%DD%"=="n" goto P
echo ����ȷ����! & goto I

:P
ECHO ========================================
set /p LL=��ѡ������ģʽ [1����������  2����������  3����������]:
if /i "%LL%"=="1" goto F
if /i "%LL%"=="2" set ARGS=%ARGS%--listen && goto TH
if /i "%LL%"=="3" goto SH
echo ����ȷ����! & goto P

:TH
ECHO ========================================
set /p PT=��������˿�[����(��Ҫ��ո�)Ĭ��Ϊ7860,��С��1024������Ҫ����Ȩ��]:
if /i "%PT%"=="" goto SH
set ARGS=%ARGS%--port %PT% && goto SH

:SH
ECHO ========================================
set /p share=���� "�û���:����" �ĸ�ʽ�����˺ţ����ö��Ŵ�������˺� [����(��Ҫ��ո�)Ĭ�ϲ�����]:
if /i "%share%"=="" set ARGS=%ARGS%--share && goto F
set ARGS=%ARGS%--share --gradio-auth %share% 

:F
echo set COMMANDLINE_ARGS=%ARGS%>> webui-user.bat
echo call webui.bat>> webui-user.bat

:M
ECHO ========================================
echo ��������ɣ���������!
goto G

:G
ECHO ========================================
echo �������ӣ�
echo Ԫ�ط���:https://docs.qq.com/doc/DWHl3am5Zb05QbGVs
echo Tagħ����:https://thereisnospon.github.io/NovelAITag/
echo Curry��Դվ�������У�:http://xart.top:44803/#/up
echo NovelAI������Դվ:https://g.h5gd.com/p/yuvwitqh
echo ħ��������by.���������� BվUID:6537379
echo ħ������Ƶ:BV1YG4y1n7By
echo ========================================
echo �������������������򲢽��롰��������ģʽ
echo �������������������򲢽��롰��������ģʽ
echo �������������������򲢽��롰��������ģʽ
echo �������������������򲢽��롰��������ģʽ
ECHO ========================================
call webui-user.bat



pause
exit


:XF
ECHO ========================================
echo + 		�˴�Ϊ�����޸��
echo + ��webui����ʱ����֣���δ��������������
ECHO ========================================
echo + ����ݱ������һ������ǰ�����ж��޸�����
ECHO ========================================
echo + 1.Typeerror:expected str,bytes or os.PathlLike object, not oneType
echo + ������C�̻��棬��Ԥ��5G���Ͽռ�
echo +
echo + 2.RuntimeError:CUDA out of memory
echo + �Դ治�㣬�벿��ʱѡ������Ż���������ͼƬ�ֱ���
echo + ��Ϊ10��22��֮ǰ���ص�7g latestģ�Ͱ�����ǰ��
echo + %cd%\models\stable-diffusion��ɾ��model.yaml�ļ�
echo +
echo + 3.OSError: [Errno 22] Invalid argument: 'outputs\txt2img-images
echo + ����1.ͼƬ����·�������������������߿��и���ͼ������ģʽ��
echo + �ĳ����ⵥ����ĸ/����Ȼ��Ӧ�����á�
echo +
echo + ����2.�޸���������ļ���λ�������ƣ�����·��
echo +
echo + 4.TypeError: argument of Type NoneType is not iterable
echo + �˴治�㣬�뱣֤ʵ���˴��8G
echo + ����������˴棬ʹ��ʵ���˴棫�����˴��16G
echo + ��ӷ�����ٶȣ�ʮ�ּ�
echo ========================================
echo + ������ʾ��û����ʾ���볢�����½�ѹ
echo + ���Ծ��޷��������ǰ��Ƶ����QȺѯ��
echo + ѯ��ʱ�뷢������Bat�����ͼ�����ӿ�ͷ����β�������ݣ�
echo + ��ͼ��������˿�
echo ========================================
pause