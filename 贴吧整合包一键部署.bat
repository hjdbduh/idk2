@ECHO OFF
@title Stable Diffusion WebUI 贴吧整合包一键部署
@COLOR A
if exist %cd%\Python310 (
echo 检测当前版本为解压即用版本，请使用"一键启动.bat"启动！
pause
exit
) else (
goto QAQ
)

:QAQ
ECHO ========================================
ECHO	 	正在启动一键部署程序中
ECHO	    欢迎加入贴吧交流群：622540553
ECHO	    一群已满，请加二群：766973619
ECHO	请注意，配置的文件路径需要全英文且不能有空格
ECHO	部分用户遭遇卡Python问题
ECHO	请勿使用汉化版或Github下载最新版覆盖
ECHO	部分错误通过修改文件修复，覆盖后将会报错
ECHO ========================================
ECHO 正在检测Python是否正常安装...
@for /f "tokens=1" %%i in ('pip --version ^| findstr /C:"pip"') do ^
set PIPVER=%%i
@if "%PIPVER%" == "pip" (
echo Pip 安装正常!
) else (
echo Pip 未安装或安装失败!
goto A
)
@for /f "tokens=2" %%h in ('python -h ^| findstr /C:"usage:"') do ^
set PYVER2=%%h
if "%PYVER2%" == "python" (
echo Python 安装正常!
goto B
) else (
echo Python 未安装或安装失败!
goto A
)

:A
ECHO ========================================
ECHO 正在启动Python安装程序...
ECHO 开始安装Python 3.10.7...
ECHO	若重复安装无效
ECHO	请使用Unstall卸载并前往微软商店安装Python3.10
ECHO ========================================
ECHO 勾选下方两个选项后点击Install Now，随后一直点击Next，直到最后一部点击Close
ECHO ========================================
start /wait %cd%\deploy\python-3.10.7-amd64.exe /qn
ECHO ========================================
ECHO 将于5秒后退出，请手动重启部署程序!
timeout /nobreak /t 5
exit

:B
ECHO ========================================
ECHO 正在检测Git是否正常安装...
@for /f "tokens=1" %%b in ('git --version') do ^
set GITV=%%b
if "%GITV%" == "git" (
echo Git 安装正常!
goto O
) else (
echo Git 安装失败!
goto C
)

:C
ECHO ========================================
ECHO 开始安装Git-2.38.0...
ECHO ========================================
ECHO 请勿修改任何选项，一直点击Next，直到最后一步点击Finish即可
start /wait %cd%\deploy\Git-2.38.0-64-bit.exe /qn
ECHO ========================================
ECHO Git-2.38.0安装完成
ECHO ========================================
ECHO 将于5秒后退出，请手动重启部署程序!
timeout /nobreak /t 5
exit

:O
@for  /f  "skip=4 delims="  %%x  in  (webui-user.bat)  do ^
set txt=%%x
if "%txt%" == "call webui.bat" (
goto I
) else (
ECHO ========================================
start https://pd.qq.com/s/jrnm0f
echo 检测未完成部署，正在更改为部署模式...
goto D
)

:I
set /p tb=检测到部署已完成，请选择启动模式 [1.直接启动  2.再次部署  3.报错解决]:
if /i "%tb%"=="1" goto G
if /i "%tb%"=="2" goto D
if /i "%tb%"=="3" goto XF
echo 请正确输入! & goto I

:D
ECHO ========================================
echo 开始部署Stable Diffusion WebUI
ECHO 请保证C盘预留5G以上空间
ECHO 运行中可能出现假死现象，若长时间无反应请点击回车键继续
echo ========================================
ECHO 若初次运行，此处提示找不到XXX为正常现象
@del /s /q "%cd%\venv\Scripts" >nul
@rd /s /q "%cd%\venv\Scripts" >nul
@del /s /q "%cd%\venv\pyvenv.cfg" >nul
echo ========================================
echo 若此处提示"‘XCOPY‘不是内部或外部命令，也不是可运行的程序或批处理文件"
echo 或提示"访问遭到拒绝"，即表明部署失败
echo 请手动前往"%cd%\deploy\"
echo 将"transformers\"文件复制到"C:\Users\%username%\.cache\huggingface"中
echo 若无文件夹请自行创建
echo ========================================
xcopy "%cd%\deploy\transformers\*.*" "C:\Users\%username%\.cache\huggingface\transformers\" /y /e >nul && echo 部署成功！ || echo 部署失败，请手动复制！&& pause

echo @echo off > webui-user.bat
ECHO title Stable Diffusion WebUI >> webui-user.bat
ECHO ECHO 运行中可能出现假死现象，若长时间无反应请点击回车键继续 >> webui-user.bat
echo set PYTHON=>> webui-user.bat
echo set GIT=>> webui-user.bat
echo set VENV_DIR=>> webui-user.bat
ECHO ========================================
ECHO 检测显卡型号中...
ECHO ========================================
@for /f "tokens=1" %%n in ('wmic path Win32_VideoController get AdapterCompatibility ^|findstr "NVIDIA"') do ^
set GPU=%%n
if "%GPU%" == "NVIDIA" (
echo 检测为NVIDIA显卡，可正常使用GPU模式...
set ARGS=--autolaunch & goto E
) else (
goto T
)
ECHO ========================================

:T
echo 检测为非NVIDIA显卡...
echo ========================================
set /p WQE=为避免检测出错，请确认自身是否为N卡 [1.是N卡  2.不是N卡]:
if /i "%WQE%"=="1" set ARGS=--autolaunch & goto E
if /i "%WQE%"=="2" set ARGS=--skip-torch-cuda-test --lowvram --always-batch-cond-uncond --no-half --autolaunch & goto I
echo 请正确输入 & goto T

:E
echo ========================================
echo 请按实际显存选择！
echo 若想训练模型，请选择8G及以上且保证实际显存在8G及以上
set /p best=请选择显存(1、3G以下   2、4G显存   3、6G显存   4、16XX系列显卡[仅16系列显卡优先] 5、8G及以上[无优化]):
if /i "%best%"=="1" set ARGS=%ARGS%--lowvram --always-batch-cond-uncond --no-half & goto R
if /i "%best%"=="2" set ARGS=%ARGS%--precision full --no-half --lowvram --always-batch-cond-uncond & goto R
if /i "%best%"=="3" set ARGS=%ARGS%--precision full --no-half --medvram & goto R
if /i "%best%"=="4" set ARGS=%ARGS%--lowvram --precision full --no-half & goto R
if /i "%best%"=="5" set ARGS=%ARGS%  & goto R

echo 请正确输入! & goto E

:R
ECHO ========================================
ECHO 是否需要启动xformers,本模式会优化"30%"性能
set /p XF=建议6G及以上显存选择,4G及以下可能导致负优化(y/n):
if /i "%XF%"=="y" set ARGS=%ARGS%--xformers & goto I
if /i "%XF%"=="n" goto I
echo 请正确输入! & goto R

:I
ECHO ========================================
ECHO 是否需要启动DeepDanBooru
set /p DD=本功能更便于AI训练(y/n):
if /i "%DD%"=="y" set ARGS=%ARGS%--deepdanbooru & goto P
if /i "%DD%"=="n" goto P
echo 请正确输入! & goto I

:P
ECHO ========================================
set /p LL=请选择运行模式 [1、本地运行  2、线上运行  3、公网分享]:
if /i "%LL%"=="1" goto F
if /i "%LL%"=="2" set ARGS=%ARGS%--listen && goto TH
if /i "%LL%"=="3" goto SH
echo 请正确输入! & goto P

:TH
ECHO ========================================
set /p PT=请以输入端口[留空(不要打空格)默认为7860,若小于1024，则需要管理权限]:
if /i "%PT%"=="" goto SH
set ARGS=%ARGS%--port %PT% && goto SH

:SH
ECHO ========================================
set /p share=请以 "用户名:密码" 的格式输入账号，可用逗号创建多个账号 [留空(不要打空格)默认不设置]:
if /i "%share%"=="" set ARGS=%ARGS%--share && goto F
set ARGS=%ARGS%--share --gradio-auth %share% 

:F
echo set COMMANDLINE_ARGS=%ARGS%>> webui-user.bat
echo call webui.bat>> webui-user.bat

:M
ECHO ========================================
echo 部署已完成，正在启动!
goto G

:G
ECHO ========================================
echo 友情链接：
echo 元素法典:https://docs.qq.com/doc/DWHl3am5Zb05QbGVs
echo Tag魔导书:https://thereisnospon.github.io/NovelAITag/
echo Curry资源站（测试中）:http://xart.top:44803/#/up
echo NovelAI自助资源站:https://g.h5gd.com/p/yuvwitqh
echo 魔导书作者by.西红噬土豆 B站UID:6537379
echo 魔导书视频:BV1YG4y1n7By
echo ========================================
echo 遭遇报错请重启本程序并进入“报错解决”模式
echo 遭遇报错请重启本程序并进入“报错解决”模式
echo 遭遇报错请重启本程序并进入“报错解决”模式
echo 遭遇报错请重启本程序并进入“报错解决”模式
ECHO ========================================
call webui-user.bat
pause
exit


:XF
ECHO ========================================
echo + 		此处为报错修复项！
echo + 仅webui报错时会出现，若未报错即出现请无视
ECHO ========================================
echo + 请根据报错最后一段文字前几句判断修复方法
ECHO ========================================
echo + 1.Typeerror:expected str,bytes or os.PathlLike object, not oneType
echo + 请清理C盘缓存，并预留5G以上空间
echo +
echo + 2.RuntimeError:CUDA out of memory
echo + 显存不足，请部署时选择合适优化，并降低图片分辨率
echo + 若为10月22号之前下载的7g latest模型包，请前往
echo + %cd%\models\stable-diffusion中删除model.yaml文件
echo +
echo + 3.OSError: [Errno 22] Invalid argument: 'outputs\txt2img-images
echo + 方法1.图片保存路径过长，在设置里的左边框有个“图像命名模式”
echo + 改成任意单独字母/数字然后应用设置。
echo +
echo + 方法2.修改软件所在文件夹位置与名称，减短路径
echo +
echo + 4.TypeError: argument of Type NoneType is not iterable
echo + 运存不足，请保证实际运存≥8G
echo + 并添加虚拟运存，使得实际运存＋虚拟运存≥16G
echo + 添加方法请百度，十分简单
echo ========================================
echo + 若上列示例没有提示，请尝试重新解压
echo + 若仍旧无法解决，请前往频道或Q群询问
echo + 询问时请发送完整Bat界面截图（即从开头到结尾所有内容）
echo + 截图请勿包含此框！
echo ========================================
pause