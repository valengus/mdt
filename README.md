Role Name : MDT
=========

```powershell
net use U: \\mdt\DeploymentShare /user:mdt\mdt 'pa$$w0rd' /persistent:yes
cscript.exe //Nologo //B "\\mdt\DeploymentShare\Scripts\LiteTouch.vbs"

```
