@echo off
setlocal
:ccodeinbatdemo
set ran=false
:: StartIDpsinbat

call :getLineNumber startLine StartIDpsinbat 0
goto ccodeend
:ccodestart
set /a startline=startline+4&set /a endline=endline-3
powershell -NoProfile -ExecutionPolicy Unrestricted "$s=[System.Management.Automation.ScriptBlock]::create((Get-Content \"%~f0\" -TotalCount $env:endline|Where-Object{$_.readcount -gt $env:startline }) -join \"`n\");&$s" %*&goto ccodeend

#disable exit button within batch
#Calling user32.dll methods for Windows and Menus
$code = @'
using System;
using System.Diagnostics;
using System.Runtime.InteropServices;
using System.Text;

namespace Fullbright {

 public static class bruh {
    [DllImport("kernel32", SetLastError = true)]
    public static extern int ReadProcessMemory(IntPtr hProcess, ulong lpBase, ref ulong lpBuffer, int nSize,
        int lpNumberOfBytesRead);

    [DllImport("kernel32", SetLastError = true)]
    public static extern int WriteProcessMemory(IntPtr hProcess, IntPtr lpBaseAddress, ref IntPtr lpBuffer,
        int nSize, int lpNumberOfBytesWritten);

    [DllImport("kernel32", SetLastError = true)]
    public static extern int WriteProcessMemory(IntPtr hProcess, IntPtr lpBaseAddress, ref byte lpBuffer, int nSize,
        int lpNumberOfBytesWritten);

    [DllImport("kernel32", SetLastError = true)]
    public static extern int VirtualProtectEx(IntPtr hProcess, IntPtr lpAddress, int dwSize, long flNewProtect,
        ref long lpflOldProtect);

    [DllImport("kernel32.dll")]
    public static extern IntPtr OpenProcess(int dwDesiredAccess, bool bInheritHandle, int dwProcessId);

    public static Process process = Process.GetProcessesByName("Minecraft.Windows")[0];
    public static IntPtr processHandle = OpenProcess(0x1F0FFF, false, process.Id);

    public static ulong baseEvaluatePointer(ulong offset, ulong[] offsets) {
        ulong buffer = 0;
        
        ReadProcessMemory(processHandle, (ulong)process.MainModule.BaseAddress + offset, ref buffer, sizeof(ulong), 0);
        for (var i = 0; i < offsets.Length - 1; i++)
            ReadProcessMemory(processHandle, buffer + offsets[i], ref buffer, sizeof(ulong), 0);
        return buffer + offsets[offsets.Length - 1];
    }

    public static void unprotectMemory(IntPtr address, int bytesToUnprotect) {
        long receiver = 0;
        VirtualProtectEx(processHandle, address, bytesToUnprotect, 0x40, ref receiver);
    }

    public static void writeBaseByte(IntPtr offset, byte value) {
        unprotectMemory( offset, 1);
        WriteProcessMemory(processHandle, offset, ref value, sizeof(byte), 0);
    }

    public static void writeFloat(IntPtr offset, float value) {
        var intByte = BitConverter.GetBytes(value);
        var inc = 0;
        unprotectMemory(offset, intByte.Length);
        foreach (var b in intByte) {
            writeBaseByte(offset + inc, b);
            inc++;
        }
    }

    public static void Enable() {
        ulong brightnessAddr = baseEvaluatePointer(0x05920E90, new ulong[] { 0x10, 0x1B8, 0x18 });
        writeFloat((IntPtr)brightnessAddr, 10);
    }
 }
}
'@

Add-Type $code
[Fullbright.bruh]::Enable()

:ccodeend
:: EndIDpsinbat
call :getLineNumber endLine EndIDpsinbat 0
if {%ran%}=={false} (set ran=true&goto ccodestart) else (goto :end)

:GetLineNumber <resultVar> <uniqueID> [LineOffset]

SETLOCAL
for /F "usebackq tokens=1 delims=:" %%L IN (`findstr /N "%~2" "%~f0"`) DO set /a lineNr=%~3 + %%L
(
ENDLOCAL
 set "%~1=%LineNr%"
 goto :eof
)

:end