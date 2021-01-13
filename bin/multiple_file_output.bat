<# : multiple_file_output.bat
@ECHO ON
color A
echo Welcome to Bryce's core roaster
echo It is time for your CPU to die
echo Please select your After Effects project file:

for /f "delims=" %%I in ('powershell -noprofile "iex (${%~f0} | out-string)"') do (
    echo ... loading %%I
	set "file=%%I"
)

set /p frames="How many frames is your project? "
set /p instances="How many instances of aerender.exe would you like? "
set /A segment_length=%frames%/%instances%

mkdir "render_output" 

:loop
	if %instances% LEQ 0 goto exitloop
	set /a instances=instances-1
	set /A start=%instances%*%segment_length%
	set /A end=%start%+%segment_length%-1
	Start "Core roaster #%instances%" "C:\Program Files\Adobe\Adobe After Effects CC 2019\Support Files\aerender.exe" -project "%file%" -s %start% -e %end% -comp "render" -rqindex 1 -sound ON -output "%~d0%~p0\render_output\out%instances%.mov"
	goto loop
:exitloop
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