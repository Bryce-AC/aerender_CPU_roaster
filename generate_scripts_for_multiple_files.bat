<# : generate_scripts_for_multiple_files.bat
@ECHO OFF
color A

echo Welcome to BryceAC's core roaster
echo It is time for your CPU to die
echo.

timeout /t 1 > nul

echo 1. Please select your After Effects project file:

for /f "delims=" %%I in ('powershell -noprofile "iex (${%~f0} | out-string)"') do (
	echo ... loading %%I
	echo.
	set "file_path=%%I"

	set "project_dir=%%~dpI"
)

IF "%file_path%" == "" (
	echo No file selected. Exiting...
	timeout /t 3 > nul
	exit
)

set /p frames="2. How many frames is your 'render' composition? "
echo.
set /p instances="3. How many instances of aerender.exe would you like? "
echo.
set /A segment_length=%frames%/%instances%

if not exist "%project_dir%core_roaster_render_output" (
	mkdir "%project_dir%core_roaster_render_output"
	echo "%project_dir%core_roaster_render_output" not found... creating directory
)

if not exist "%project_dir%core_roaster_render_scripts" (
	mkdir "%project_dir%core_roaster_render_scripts" 
	echo "%project_dir%core_roaster_render_scripts" directory not found... creating directory
)

FOR /F "tokens=2,*" %%A IN ('reg.exe query "HKLM\SOFTWARE\Adobe\After Effects\17.0" /v "InstallPath"') DO set "AE_path=%%B"
echo aerender.exe in %AE_path%
echo.

set /A end_flag = 1

:loop
	if %instances% LEQ 0 goto exitloop
	set /a instances=instances-1
	set /A start=%instances%*%segment_length%
	set /A end=%start%+%segment_length%-1
	
	if %end_flag%==1 (
		set /A end=%frames%-1
		set /A end_flag = 0
	)

	echo "%AE_path%aerender.exe" -project "%file_path%" -s %start% -e %end% -comp "render" -rqindex 1 -sound ON -output "%project_dir%core_roaster_render_output\out%instances%.mov" > "%project_dir%core_roaster_render_scripts\render_%instances%.bat"
	echo pause >> "%project_dir%core_roaster_render_scripts\render_%instances%.bat"
	goto loop
:exitloop

echo Complete

pause

: end Batch portion / begin PowerShell hybrid chimera #>

Add-Type -AssemblyName System.Windows.Forms
$f = new-object Windows.Forms.OpenFileDialog
$f.InitialDirectory = pwd

$f.Filter = "AE Project Files (*.aep)|*.aep|All Files (*.*)|*.*"
$f.ShowHelp = $true
$f.Multiselect = $false
[void]$f.ShowDialog()
if ($f.Multiselect) { $f.FileNames } else { $f.FileName }