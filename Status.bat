@echo off
echo Windows OS Status
echo -----------------

:: Get system information
systeminfo | findstr /C:"OS Name" /C:"OS Version" /C:"System Manufacturer" /C:"System Model"

:: Get processor information
wmic cpu get Name, NumberOfCores, MaxClockSpeed

:: Get memory information
wmic memorychip get Capacity, Speed, MemoryType

:: Get disk information
wmic diskdrive get Caption, Size, InterfaceType

:: Get network information
ipconfig /all

:: Get user information
whoami

:: Prompt user to create a report
setlocal enabledelayedexpansion
choice /C YN /M "Do you want to create a report of this information? (Y/N) "
if "!errorlevel!"=="1" (
    echo Creating report...
    (
        echo Windows OS Status
        echo -----------------
        systeminfo | findstr /C:"OS Name" /C:"OS Version" /C:"System Manufacturer" /C:"System Model"
        wmic cpu get Name, NumberOfCores, MaxClockSpeed
        wmic memorychip get Capacity, Speed, MemoryType
        wmic diskdrive get Caption, Size, InterfaceType
        ipconfig /all
        whoami
    ) > "%userprofile%\Desktop\OS Information Report.txt"

    echo Creating file progress:
    set "progress=0"
    for /l %%A in (0,1,100) do (
        cls
        echo Creating file progress: %%A%%
        set /a "progress=%%A"
        timeout /t 0 > nul
    )

    echo File created successfully on the desktop!
) else (
    echo Exiting without creating a report.
)

:: Pause to keep the window open
pause
