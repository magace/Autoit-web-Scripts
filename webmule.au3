#include <ImageSearch.au3>
#include <GDIPlus.au3>
#include <File.au3>
#include <Array.au3>
#include <FTP.au3>
#include <Date.au3>
#include <FileConstants.au3>

Global $sDir, $hSearch, $sFilename, $sNewestFilename, $sNewestDate, $sDir2
$mfile = "" ;gives a var to mfile mulelog items
$mfilea = ""
$mfileb = ""
$File1 = "C:\Users\default.default-PC\Desktop\d2bot-with-kolbot-CORE15\d2bs\kolbot\libs\AutoMule.js"
$File2 = (@ScriptDir &"\logs\log.txt")
$File3 = (@ScriptDir &"\logs\count.txt")
$File4 = (@ScriptDir &"\logs\account.txt")
$File5 = (@ScriptDir &"\logs\archive.txt")
$website = 'http://ofchant.com/forum/posting.php?mode=post&f=11'   ;new post link
$website1 = 'http://ofchant.com/forum/posting.php?mode=edit&f=11&p=11' ;edit post link
$websiteLoaded = @ScriptDir & "\Loaded.png"  ;PAGE LOADED

ReadFtpINI()
Local $hTimer = TimerInit()
Local $pTimer = TimerInit()

While 1
   Local $rtime = $ptime * 86400000
   Local $fDiff = TimerDiff($hTimer)
   Local $ctime = $rtime - $fDiff
	  if $fDiff > $rtime Then
		 GetnPost()
		 ToolTip("posting!!!!",100,100)
		 Sleep(1000)
		 updateTime($ctime)
		 Local $hTimer = TimerInit()
	  Else
		 Local $pDiff = TimerDiff($pTimer)
		 If $pDiff > 3600000 Then
			ToolTip("DO WHATEVER HERE",100,100)
			updateTime($ctime)
			Local $pTimer = TimerInit()
		 EndIf


		 ToolTip("TIMELEFT: " & _Convert($ctime) & ".", 100, 100)
		 sleep(1000)
	  EndIf
   WEnd

Func updateTime($time)
   ShellExecute($website1)
   LoadPage()
   Sleep(1000)
   Send("{tab}")
   Sleep(100)
   Send("{tab}")
   Sleep(1000)
   Send("{End}")
   Sleep(500)
   Send("{backspace 100}")
   Sleep(500)
   Send("[b]TIME LEFT: [/b] [color=red]" &  _Convert($time) & "[/color]")
   Send("{tab}")
   Sleep(1000)
   Send("{tab}")
    Sleep(1000)
   Send("{ENTER}")
   Sleep(3000)
   LoadPage()
   Send("!{f4}")
EndFunc


Func GetnPost()
   UpdateCount()
   $line = FileReadLine($file1,5)
   $string1 = StringInStr($line,'"')+1
   $string2 = StringInStr($line,'",')
   $stringcount = $string2 - $string1
   $string3 = StringMid($line,$string1,$stringcount)
   ToolTip($string3 & "1")
   $tcount = FileReadLine($file3,1)
   Logs("Posting Account :" & $string3 & "1")
   $postmsg1 = ("[b]" & @MON & "/" & @MDAY & "/" & @YEAR & ": Free Account #" & $tcount & " Account Name:[/b] [color=red]" & $string3 & "1[/color]")
   Local Const $sFilePath = $File4
   Local $hFileOpen = FileOpen($sFilePath, $FO_OVERWRITE)
   FileWriteLine($hFileOpen, $postmsg1)
   FileClose($hFileOpen)
   Local Const $sFilePath5 = $File5
   Local $hFileOpen5 = FileOpen($sFilePath5, $FO_APPEND)
   FileWriteLine($hFileOpen5, $postmsg1 & @CRLF )
   FileClose($hFileOpen5)
   ClipPut($postmsg1)
   ShellExecute($website)
   LoadPage()
   Send("{TAB}")
   Send("Ofchant Free Account # " & $tcount)
   Sleep(1000)
   Send("{TAB}")
   Sleep(1000)
   Send("^v")
   Send("{enter}")
   Send("[b]Password:[/b]   [color=red]asd1234[/color]")
   Send("{enter}")
   Send('Todays Items:')
   Send("{enter}")
   Send("{enter}")
   ReadMule()
   Send("^V")
   Sleep(1000)
   Send("{TAB}")
   Sleep(500)
   Send("{TAB}")
    Sleep(1000)
   Send("{ENTER}")
    Sleep(1000)
   LoadPage()
   Sleep(1000)
   Send("{TAB}")
   Send("!{f4}")
   NewMule()
EndFunc

Func ReadMule()
   $mfile = "C:\Users\default.default-PC\Desktop\d2bot-with-kolbot-CORE15\d2bs\kolbot\forumules\mulelog.txt"
   $mfileo = "C:\Users\default.default-PC\Desktop\d2bot-with-kolbot-CORE15\d2bs\kolbot\forumules\old\mulelog.txt"
   $rmfile = FileRead($mfile)
   ClipPut($rmfile)
   FileDelete($mfile)
   FileCopy($mfileo,$mfile)
EndFunc


Func UpdateCount()
   $lines = FileReadLine($file3,1)
   $newlines = $lines + 1
   ToolTip($newlines)
   Sleep(1000)
   $TextFileName = $File3
   $FindText = $lines
   $ReplaceText = $newlines
   $FileContents = FileRead($TextFileName)
   $FileContents = StringRegExpReplace($FileContents,$FindText,$ReplaceText, 1)
   $hFile = FileOpen($TextFileName, 2)
   FileWrite($hFile, $FileContents)
   FileClose($hFile)
EndFunc

Func _Convert($ms)
   Local $day, $hour, $min, $sec
   _TicksToTime($ms, $hour, $min, $sec)
   If $hour > 24 Then
       $day = $hour/24
       $hour = Mod($hour, 24)
   EndIf
   Return StringFormat("%02iD/%02iH/%02iM/%02iS", $day, $hour, $min, $sec)
EndFunc

Func NewMule()
Global $aFile
   $line = FileReadLine($file1,5)
   $string1 = StringInStr($line,'"')+1
   $string2 = StringInStr($line,'",')
   $stringcount = $string2 - $string1
   $string3 = StringMid($line,$string1,$stringcount)
   $pwd = ""
   Dim $aSpace[3]
   $digits = 10
   For $i = 1 To $digits
	   $aSpace[0] = Chr(Random(65, 90, 1)) ;A-Z
	   $aSpace[1] = Chr(Random(97, 122, 1)) ;a-z
	   $aSpace[2] = Chr(Random(48, 57, 1)) ;0-9
	   $pwd &= $aSpace[Random(0, 2, 1)]
   Next
   ConsoleWrite("New Account (" & $digits & " digits): " & $pwd & @CRLF)
   Logs("Creatjng Account :" & $pwd & "1")
   $TextFileName = $File1
   $FindText = $string3
   $ReplaceText = $pwd
   $FileContents = FileRead($TextFileName)
   $FileContents = StringRegExpReplace($FileContents,$FindText,$ReplaceText, 1)
   $hFile = FileOpen($TextFileName, 2)
   FileWrite($hFile, $FileContents)
   FileClose($hFile)
EndFunc

Func LoadPage()
    $go = 1
	  while $go = 1
			_GDIPlus_Startup()
			$hImageA =_GDIPlus_ImageLoadFromFile($websiteLoaded) ;this is the PAGE LOADED
			$hBitmapA = _GDIPlus_BitmapCreateHBITMAPFromBitmap($hImageA)
			$x = 0
			$y = 0
			$result = _ImageSearch($hBitmapA, 1, $x, $y, 20, 0) ;Zero will search against your active screen
			   If $result > 0 Then
				   ToolTip("PAGE IS LOADED",0,0)
					  $go = 0
					  _GDIPlus_ImageDispose($hImageA)
			_GDIPlus_Shutdown()
				   Else
					  ToolTip("WAITING FOR PAGE TO LOAD",0,0)
					  SLEEP(1000)
					  _GDIPlus_ImageDispose($hImageA)
			_GDIPlus_Shutdown()
			   EndIf
   WEnd
EndFunc

Func Logs($dat)
Local $hFileOpen = FileOpen($File2, $FO_APPEND)
FileWriteLine($hFileOpen, @MON & "/" & @MDAY & "/" & @YEAR & ": " & $dat & @CRLF)
FileClose($hFileOpen)
EndFunc

Func ToFtp($source,$destination)
   $Open = _FTPOpen('MyFTP Control')
   $Conn = _FTPConnect($Open, $server, $username, $pass)
   $Ftpp = _FtpPutFile($Conn,$source , $destination)
   $Ftpc = _FTPClose($Open)
EndFunc


Func ReadFtpINI()
   Global $server = IniRead(@ScriptDir & "\Config.ini", "FTP", "Server", "Default Value")
   Global $username = IniRead(@ScriptDir & "\Config.ini", "FTP", "UserName", "Default Value")
   Global $pass = IniRead(@ScriptDir & "\Config.ini", "FTP", "Password", "Default Value")
   Global $ptime = IniRead(@ScriptDir & "\Config.ini", "FTP", "PostTime", "Default Value") ;post evert 2 days?
EndFunc
