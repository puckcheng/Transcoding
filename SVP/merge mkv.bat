@ECHO OFF

"C:\Program Files (x86)\MeGUI_2715_x86\tools\mkvmerge\mkvmerge.exe" -o "%~dpn1_muxed.mkv" "%~dpn1.hevc" "%~dpn1.aac"

pause