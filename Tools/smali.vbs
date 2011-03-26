Dim Ver, cd
Ver = wscript.arguments(0)
cd  = wscript.arguments(1)

Const Lecture = 1, Ecriture = 2
Dim fso, f
Set fso = CreateObject("Scripting.FileSystemObject")
Set f = fso.OpenTextFile(""& cd & "\Workdir\decompile\" & Ver & "\Updater\smali\com\android\updater\utils\Preferences.smali", Lecture)
readalltextfile = f.ReadAll
        newtextfile = Replace(readalltextfile, "http://update.miuirom.com/updates/update.json","http://miui.enterinmydream.info/update.json")
    Set f = fso.OpenTextFile(""& cd & "\Workdir\decompile\" & Ver & "\Updater\smali\com\android\updater\utils\Preferences.smali", Ecriture, True)
        f.Write newtextfile
Set f = fso.OpenTextFile(""& cd & "\Workdir\decompile\" & Ver & "\Updater\smali\com\android\updater\utils\SysUtils.smali", Lecture)
readalltextfile = f.ReadAll
        newtextfile = Replace(readalltextfile, "http://update.miuirom.com/updates/update.json","http://miui.enterinmydream.info/update.json")
    Set f = fso.OpenTextFile(""& cd & "\Workdir\decompile\" & Ver & "\Updater\smali\com\android\updater\utils\SysUtils.smali", Ecriture, True)
        f.Write newtextfile
                
Const Lecture2 = 1, Ecriture2 = 2
Dim fso2, f2
Set fso2 = CreateObject("Scripting.FileSystemObject")
Set f2 = fso2.OpenTextFile(""& cd & "\Workdir\decompile\" & Ver & "\Backup\smali\com\miui\backup\AbstractBackupListActivity.smali", Lecture)
readalltextfile = f2.ReadAll
        newtextfile = Replace(readalltextfile, "yyyy\u5e74MM\u6708dd\u65e5","dd-MM-yyyy")
    Set f2 = fso2.OpenTextFile(""& cd & "\Workdir\decompile\" & Ver & "\Backup\smali\com\miui\backup\AbstractBackupListActivity.smali", Ecriture, True)
        f2.Write newtextfile        
Set f2 = fso2.OpenTextFile(""& cd & "\Workdir\decompile\" & Ver & "\Backup\smali\com\miui\backup\AbstractBackupSelectActivity.smali", Lecture)
readalltextfile = f2.ReadAll
        newtextfile = Replace(readalltextfile, "yyyy\u5e74MM\u6708dd\u65e5","dd-MM-yyyy")
    Set f2 = fso2.OpenTextFile(""& cd & "\Workdir\decompile\" & Ver & "\Backup\smali\com\miui\backup\AbstractBackupSelectActivity.smali", Ecriture, True)
        f2.Write newtextfile        
Set f2 = fso2.OpenTextFile(""& cd & "\Workdir\decompile\" & Ver & "\Backup\smali\com\miui\backup\AbstractRestoreSelectActivity.smali", Lecture)
readalltextfile = f2.ReadAll
        newtextfile = Replace(readalltextfile, "yyyy\u5e74MM\u6708dd\u65e5","dd-MM-yyyy")
    Set f2 = fso2.OpenTextFile(""& cd & "\Workdir\decompile\" & Ver & "\Backup\smali\com\miui\backup\AbstractRestoreSelectActivity.smali", Ecriture, True)
        f2.Write newtextfile     
        
Const Lecture3 = 1, Ecriture3 = 2
Dim fso3, f3
Set fso3 = CreateObject("Scripting.FileSystemObject")
Set f3 = fso3.OpenTextFile(""& cd & "\Workdir\decompile\" & Ver & "\FileExplorer\smali\com\android\fileexplorer\Util.smali", Lecture)
readalltextfile = f3.ReadAll
        newtextfile = Replace(readalltextfile, "\u7167\u7247","Photos")
    Set f3 = fso3.OpenTextFile(""& cd & "\Workdir\decompile\" & Ver & "\FileExplorer\smali\com\android\fileexplorer\Util.smali", Ecriture, True)
        f3.Write newtextfile     
Set f3 = fso3.OpenTextFile(""& cd & "\Workdir\decompile\" & Ver & "\FileExplorer\smali\com\android\fileexplorer\Util.smali", Lecture)
readalltextfile = f3.ReadAll
        newtextfile = Replace(readalltextfile, "SD\u5361","Carte SD")
    Set f3 = fso3.OpenTextFile(""& cd & "\Workdir\decompile\" & Ver & "\FileExplorer\smali\com\android\fileexplorer\Util.smali", Ecriture, True)
        f3.Write newtextfile     
Set f3 = fso3.OpenTextFile(""& cd & "\Workdir\decompile\" & Ver & "\FileExplorer\smali\com\android\fileexplorer\Util.smali", Lecture)
readalltextfile = f3.ReadAll
        newtextfile = Replace(readalltextfile, "MIUI\u622a\u5c4f","Dossiers MIUI")
    Set f3 = fso3.OpenTextFile(""& cd & "\Workdir\decompile\" & Ver & "\FileExplorer\smali\com\android\fileexplorer\Util.smali", Ecriture, True)
        f3.Write newtextfile     
Set f3 = fso3.OpenTextFile(""& cd & "\Workdir\decompile\" & Ver & "\FileExplorer\smali\com\android\fileexplorer\Util.smali", Lecture)
readalltextfile = f3.ReadAll
        newtextfile = Replace(readalltextfile, "\u94c3\u58f0","Sonneries MIUI")
    Set f3 = fso3.OpenTextFile(""& cd & "\Workdir\decompile\" & Ver & "\FileExplorer\smali\com\android\fileexplorer\Util.smali", Ecriture, True)
        f3.Write newtextfile     
Set f3 = fso3.OpenTextFile(""& cd & "\Workdir\decompile\" & Ver & "\FileExplorer\smali\com\android\fileexplorer\InformationDialog$2.smali", Lecture)
readalltextfile = f3.ReadAll
        newtextfile = Replace(readalltextfile, "\u5b57\u8282","Octets")
    Set f3 = fso3.OpenTextFile(""& cd & "\Workdir\decompile\" & Ver & "\FileExplorer\smali\com\android\fileexplorer\InformationDialog$2.smali", Ecriture, True)
        f3.Write newtextfile 
Set f3 = fso3.OpenTextFile(""& cd & "\Workdir\decompile\" & Ver & "\FileExplorer\smali\com\android\fileexplorer\InformationDialog.smali", Lecture)
readalltextfile = f3.ReadAll
        newtextfile = Replace(readalltextfile, "\u5b57\u8282","Octets")
    Set f3 = fso3.OpenTextFile(""& cd & "\Workdir\decompile\" & Ver & "\FileExplorer\smali\com\android\fileexplorer\InformationDialog.smali", Ecriture, True)
        f3.Write newtextfile 
                
Const Lecture4 = 1, Ecriture4 = 2
Dim fso4, f4
Set fso4 = CreateObject("Scripting.FileSystemObject")
Set f4 = fso4.OpenTextFile(""& cd & "\Workdir\decompile\" & Ver & "\Monitor\smali\com\android\monitor\TrafficSmsAdapter.smali", Lecture)
readalltextfile = f4.ReadAll
        newtextfile = Replace(readalltextfile, "yyyy-MM-dd","dd-MM-yyyy")
    Set f4 = fso4.OpenTextFile(""& cd & "\Workdir\decompile\" & Ver & "\Monitor\smali\com\android\monitor\TrafficSmsAdapter.smali", Ecriture, True)
        f4.Write newtextfile     
