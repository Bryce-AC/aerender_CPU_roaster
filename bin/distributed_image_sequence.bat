<# : distributed_image_sequence.bat
@ECHO OFF
color A
echo Welcome to Bryce's core roaster
echo It is time for your CPU to die
echo Please select your After Effects project file:

for /f "delims=" %%I in ('powershell -noprofile "iex (${%~f0} | out-string)"') do (
    echo ... loading %%I
	set "file=%%I"
)

set /p instances="How many instances of aerender.exe would you like? "

:loop
	if %instances% LEQ 0 goto exitloop
	Start "Core roaster #%instances%" "C:\Program Files\Adobe\Adobe After Effects 2020\Support Files\aerender.exe" -project "%file%" -sound ON -v ERRORS_AND_PROGRESS
	set /a instances=instances-1
	goto loop
:exitloop

: end Batch portion / begin PowerShell hybrid chimera #>

Add-Type -AssemblyName System.Windows.Forms
$f = new-object Windows.Forms.OpenFileDialog
$f.InitialDirectory = pwd

$f.Filter = "AE Project Files (*.aep)|*.aep|All Files (*.*)|*.*"
$f.ShowHelp = $true
$f.Multiselect = $false
[void]$f.ShowDialog()
if ($f.Multiselect) { $f.FileNames } else { $f.FileName }