<!-- :: Batch section
@echo off
setlocal

for /F "delims=" %%a in ('mshta.exe "%~F0"') do set "HTAreply=%%a"
goto :EOF
-->


<HTML>
<HEAD>
<HTA:APPLICATION SCROLL="no" SYSMENU="yes" >

<TITLE>George Floyd</TITLE>
<SCRIPT language="JavaScript">
    window.resizeTo(500,250);
</SCRIPT>
</HEAD>
<BODY>
<div class="container">
    <img class="george" src="big-george.jpg" alt="big Georg">
        <FORM>
        <INPUT TYPE="Button" NAME="Fullbright" VALUE="fullbright" style="font-size: 16px; background-color: red; top: 15%; position: absolute;">
        <h1 class="version">1.21</h1>
        <SCRIPT FOR="Fullbright" EVENT="onClick" LANGUAGE="VBScript">
            Set WshShell = CreateObject("WScript.Shell")
            WshShell.Run ".\Modules\fullbright.bat"
        </SCRIPT>
        </script>
    </FORM>
</div>

<style>
    body {
        color: black;
        margin: 0;
    }
    
    .container {
        position: relative;
        width: 100%;
        min-width: 1024px;
    }

    .version {
        color: white;
        position: absolute;
        top: 15px;
        left: 70%;
    }

    .george {
        min-height: 100%;
        min-width: 1024px;
        width: 100%;
        height: 150px;
        position: fixed;
        top: 0;
        left: 0;
        z-index: 1;
    }
</style>
</BODY>
</HTML>