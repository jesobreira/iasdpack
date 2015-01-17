#include <File.au3>
#include <Array.au3>
#include <Debug.au3>

; detecta Drives
$drives = DriveGetDrive("REMOVABLE")
If Not $drives[0] Then
   MsgBox(0, "Remover", "Não há dispositivos removíveis!")
   Exit
EndIf

Dim $drives_str
For $i = 1 To $drives[0] Step +1
   $drives_str &= ", " & StringLeft($drives[$i], 1)
Next

$drives_str = StringTrimLeft(StringUpper($drives_str), 2)

; pede pelo Drive
$drive = InputBox("Remover", "Bem-vindo à ferramenta de remoção de vírus de dispositivos removíveis da IASD Nova Almeida." & @CRLF & "Insira a letra da unidade (" & $drives_str & "):", StringLeft(StringUpper($drives[1]), 1)) & ":"
If $drive = ":" OR Not $drive Then Exit

_DebugSetup("Remover")

; mata processo
ProgressOn("Remover", "Removendo vírus...", "Matando processo do vírus...", @DesktopWidth/4, @DesktopHeight/4, 2+16)
If ProcessExists("wscript.exe") Then _DebugOut("Atenção: computador possivelmente infectado")
ProcessClose("wscript.exe")

; verifica
ProgressSet(10, "Verificando...")
If DriveGetType($drive) <> "Removable" Then
   ProgressOff()
   MsgBox(0, "Remover", "Drive inválido")
   Exit
EndIf

; cria diretorio temporario
ProgressSet(10, "Preparando pastas...")
$tempdir = _TempFile(@TempDir, "", "")
DirCreate($tempdir)
_DebugOut("Diretório temporário criado: " & $tempdir & "\")

; lista pastas e cria
ProgressSet(30, "Copiando pastas...")

$folders = _FileListToArray($drive, "*", 2)

For $i = 1 To $folders[0]
   _DebugOut("Copiando: """ & $drive & "\" & $folders[$i] & """ para """ & $tempdir & "\" & $folders[$i] & """")
   DirCopy($drive & "\" & $folders[$i], $tempdir & "\" & $folders[$i])
Next

; copia arquivos
ProgressSet(50, "Copiando arquivos...")
$files= _FileListToArray($drive, "*", 1)

For $i = 1 To $files[0]
   _DebugOut("Copiando: """ & $drive & "\" & $files[$i] & """ para """ & $tempdir & "\" & $files[$i] & """")
   FileCopy($drive & "\" & $files[$i], $tempdir & "\" & $files[$i])
Next

; remove atributo ocultos
ProgressSet(70, "Recuperando e removendo ameaças...")
FileSetAttrib($tempdir & "\*", "-H", 1)

; deleta atalhos e vb
FileDelete($tempdir & "\*.lnk")
FileDelete($tempdir & "\*.vbe")

MsgBox(0, "Remover", "Este programa não está pronto, ainda. Por isso, na janela que segue, copie seus arquivos para uma pasta, para copiar de volta ao pendrive posteriormente.")
ShellExecute("C:\WINDOWS\explorer.exe", $tempdir)
MsgBox(0, "Remover", "Clique em OK para continuar, após copiar todos os arquivos.")

#cs
MsgBox(0, "Remover", "Na janela a seguir, verifique se todos os arquivos foram copiados corretamente." & @CRLF & "Em seguida, feche a janela e confirme se deseja continuar o processo.")
ShellExecute("C:\WINDOWS\explorer.exe", $tempdir)
$confirm = MsgBox(4, "Remover", "Deseja prosseguir formatando o dispositivo?")
If $confirm = 7 Then Exit
#ce
; formata
ProgressSet(80, "Formatando dispositivo...")
FileDelete($drive & "\*")
For $i = 1 To $folders[0]
   _DebugOut("Excluindo: " & $folders[$i])
   DirRemove($drive & "\" & $folders[$i] & "\", 1)
Next

; copia arquivos de volta
ProgressSet(88, "Restaurando arquivos...")
; DirCopy($tempdir * "\", $drive & "\")
$files= _FileListToArray($tempdir & "\", "*", 1)

For $i = 1 To $files[0]
   _DebugSetup("Restaurando: """ & $tempdir & "\" & $files[$i] & """ para """ & $drive & "\" & $files[$i] & """")
   FileCopy($tempdir & "\" & $files[$i], $drive & "\" & $files[$i])
Next

; copia pastas de volta
ProgressSet(95, "Restaurando pastas...")
$folders = _FileListToArray($tempdir & "\", "*", 2)

For $i = 1 To $folders[0]
   _DebugSetup("Restaurando: """ & $tempdir & "\" & $folders[$i] & """ para """ & $drive & "\" & $folders[$i] & """")
   DirCopy($tempdir & "\" & $folders[$i], $drive & "\" & $folders[$i])
Next

ProgressSet(100, "Finalizando...")
DirRemove($tempdir & "\", 1)

ProgressOff()
MsgBox(0, "Remover", "Pronto!")