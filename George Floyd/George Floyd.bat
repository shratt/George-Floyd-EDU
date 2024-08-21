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
    window.resizeTo(374,200);
</SCRIPT>
</HEAD>
<BODY>
    <h1>George Floyd EDU</h1>
    <style>
        body {
            background: black;
            color: white;
        }
    </style>
    <FORM>
        <INPUT TYPE="Button" NAME="Fullbright" VALUE="fullbright" style="background-color: grey; color: white; border: none; padding: 10px 20px; text-align: center; text-decoration: none; display: inline-block; font-size: 16px; cursor: pointer;">
        <SCRIPT FOR="Fullbright" EVENT="onClick" LANGUAGE="VBScript">
            Set WshShell = CreateObject("WScript.Shell")
            WshShell.Run ".\Modules\fullbright.bat"
        </SCRIPT>
    </FORM>
</BODY>
</HTML>