# Install blank machine to full operating mode

## All files and instructions needed to setup Home/Work machine under Windows 11

This is not usual "setup" guide; this is more quick and efficient guide (and mostly reminder to myself :grinning:)
how to setup blank machine with least amount of effort.

Also, this targets minimum applications (core) + specific ones for home usage/development (home). Given that this is higly dependent
on what you actually use PC for, it is not universal list :smile:

I believe that general principles (MS Store, WinGet + Cloud storage) can be applied to everyone:

* Any created artifact (= files) and configuration store on cloud storage/GitHub
* Make installation breeze, using automation (MS Store / WinGet) and minimalist approach what is actually needed
* Use existing mechanisms (VS Code Settings Sync, PyCharm Settings Sync, cloud for file based settings) to sync various details between workplaces
* Finally, I suggest that for testing and fine tuning you use [Windows Sandbox](https://learn.microsoft.com/en-us/windows/security/application-security/application-isolation/windows-sandbox/), excellent low profile Win instance. You can install _winget_ in Sandbox via Windows PowerShell, details [here](https://learn.microsoft.com/en-us/windows/package-manager/winget/#install-winget-on-windows-sandbox). 
Do not forget to add `-Scope AllUsers` given that bunch of applications are system ones. Here is that script, but "verbose" version:

```powershell
Install-PackageProvider -Name NuGet -Force
Install-Module -Name Microsoft.WinGet.Client -Force -Repository PSGallery -Scope AllUsers
Repair-WinGetPackageManager
```

> [!NOTE]  
> Last command often fails for first time, so expect to repeat it.
> For some strange reason, if your Sandbox have "Region" (System / Time & language / Language & region ) set to **World** some installations (Windows Terminal, for example) _will fail_. Just set proper Region before running first WinGet installation.

Having that, I split installation into three phases:

1. **Essential** - for OS and core (Cloud services)
2. **Core Applications** - mandatory ones, no matter type of machine (Home/Work) is in question
3. **Rest** - either for fun/hobbies or just addition to previous list

## Essential

* [Windows 11](https://www.microsoft.com/software-download/windows11), fully patched (Windows 10 will do, but I do not see point of using EOL operating system)
* Cloud storage; any will do, but I prefer those which are mirrored on file system (Google Drive, OneDrive) - easier to work with
* YU Keyboard from [vesic.org](https://www.vesic.org/programi/nasa-slova-na-us-tastaturi-resenje-2005-e/)
  * This is "local" solution for typing accent characters (ćčšđžĆČŠĐŽ) for Balkan nations (Serbian, Bosnian, Croatian, Slovenian...) on non-YU keyboards.

## MS Store

Why MS Store? One time install, tied to MS Account, easy to install on other machine, auto-update...Also, some of applications simply can't be installed over _winget_, at least for now.

UPDATE: got couple of comments that this installation is "Store heavy", offering less flexibility than "pure" _winget_ installation. Having that in mind,
this version of installation is moved toward that goal - only actual _winget_ and _Windows Notepad_ should be installed over MS store - everything else can be done over
_winget_ itself:

* [App Installer (WinGet)](https://www.microsoft.com/store/productId/9NBLGGH4NNS1)
* [Windows Notepad](https://www.microsoft.com/store/productId/9MSMLRH6LZF3)
* [Windows Terminal](https://www.microsoft.com/store/productId/9N0DX20HK701) - actual installation is over _winget_. Here are just details how can you keep your configuration on cloud storage.
  * Currently, there is no option to change Setting folder of Windows Terminal. In order to correct that (and store it on cloud storage), here is Powershell script:
  [WinTermSetSym.ps1](./WinTermSetSym.ps1) for removing "original" and re-mapping to cloud folder with settings (run _elevated_):
  
```powershell
Remove-Item -Force -Recurse -Path "$Env:LocalAppData\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState"
New-Item -ItemType SymbolicLink -Path "$Env:LocalAppData\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState" -Target "$env:OneDriveConsumer\Utils\WindowsTerminal\LocalState"
  ```

Once WinGet is installed, you are ready to install Core applications:

## Core Applications

```powershell
winget import -i .\winget\winget-core.json --accept-package-agreements
```

<details>
<summary>Reference: <i>Bulk export/import with WinGet</i></summary>

* Application list export: `winget export -o .\winget-export.json`
* Bulk import: `winget import -i .\winget-export.json --accept-package-agreements`

</details>

## FiraCode font

My work relies on CMD/Windows terminal prompt; one great resource for that is [FiraCode](https://github.com/tonsky/FiraCode) font, monospaced font for development.

Install it last, after all other software and then [enable ligatures](https://github.com/tonsky/FiraCode/wiki#enabling-ligatures) for Windows Terminal, VS Code and PyCharm. If you use **Oh My Posh**, instructions for installation are below.

### List of core applications

#### Essentials

* [Microsoft Visual C++ Redistributable](https://learn.microsoft.com/en-us/cpp/windows/latest-supported-vc-redist?view=msvc-170) - sooner or later (usually sooner), one of applications will require this.
* [Microsoft.WindowsTerminal](https://learn.microsoft.com/en-us/cpp/windows/latest-supported-vc-redist?view=msvc-170)
* [Microsoft.PowerShell](https://learn.microsoft.com/en-us/powershell/)
* [Microsoft.PowerToys](https://learn.microsoft.com/en-us/windows/powertoys/)
* ~~Microsoft.OpenSSH.Beta~~ Not needed anymore. Windows 11 has built in SSH. Here is PowerShell script to check / enable (elevation needed):
[SSHCheckAndInstall.ps1](./SSHCheckAndInstall.ps1)
* [Microsoft.VisualStudioCode](https://code.visualstudio.com/) Visual Studio Code
* [Microsoft.Edit](https://github.com/microsoft/edit) - Nostalgia :-) Very simple editor from MS-DOS times
* [chmln.sd](https://github.com/chmln/sd) Efficient search & replace CLI tool.

* [7zip.7zip](https://www.7-zip.org/) - Excellent archiver
* [Ghisler.TotalCommander](https://www.ghisler.com/). Settings for shortcut, to use cloud based ini files:
  * `TOTALCMD64.EXE /i="G:\My Drive\Utils\totalcmd\wincmd.ini" /F="G:\My Drive\Utils\totalcmd\wcx_ftp.ini"`

* [Espanso.Espanso](https://espanso.org/) Open Source text expander
* [BurntSushi.ripgrep.MSVC](https://github.com/BurntSushi/ripgrep) - **rg** - line-oriented search tool that recursively searches the current directory for a regex pattern.
* [gerardog.gsudo](https://github.com/gerardog/gsudo) - **sudo** for Windows
* [ajeetdsouza.zoxide](https://github.com/ajeetdsouza/zoxide) - **zoxide** is a smarter cd command, inspired by z and autojump. Installation details [here](https://github.com/ajeetdsouza/zoxide?tab=readme-ov-file#installation); add this to your PowerShell profile:
  
  ```powershell
  Invoke-Expression (& { (zoxide init powershell | Out-String) })
  ```

* [JanDeDobbeleer.OhMyPosh](https://github.com/JanDeDobbeleer/oh-my-posh) - The **most** configurable prompt utility for any shell.
  * Install fonts directly using Oh My Posh:

  ```powershell
  oh-my-posh font install meslo
  oh-my-posh font install FiraCode
  ```
For both tools, **oh-my-posh** and **zoxide** I recommend to keep PowerShell profile on cloud drive and use it to SymLink local profile to it. Script for that is [PowerShellProfileSym.ps1](./PowerShellProfileSym.ps1) and minimal PowerShell profile is here: [Microsoft.PowerShell_profile.ps1](./Microsoft.PowerShell_profile.ps1)


#### Media (video/image)

* [clsid2.mpc-hc](https://github.com/clsid2/mpc-hc/) - Excellent video player of all media.
  * [VideoLAN.VLC](https://www.videolan.org/) This is great alternative to MPC-HC (clsid2 fork)
* [nomacs.nomacs](https://nomacs.org/) - Open Source Image Viewer
* [dotPDN.PaintDotNet](https://getpaint.net/) - Great free image and photo editing software

#### Browsers

* [Opera.Opera](https://www.opera.com/)
  * Launching Opera w/o proxy: `C:\Users\dvesic\AppData\Local\Programs\Opera\launcher.exe --no-proxy-server="`
* [Mozilla.Firefox.DeveloperEdition](https://www.firefox.com/en-US/channel/desktop/developer/) FireFox Developer Edition, as complement to Chromium based browsers.

#### Tools

* [ShareX.ShareX](https://getsharex.com/) - ShareX - Excellent open source screenshot software
* [JernejSimoncic.Wget](https://eternallybored.org/misc/wget/) - GNU Wget
* [PDFsam.PDFsam](https://pdfsam.org/) - _PDFsam Basic_: split, merge, extract pages, rotate and mix PDF files
* [WinsiderSS.SystemInformer](https://github.com/winsiderss/systeminformer) - A free, powerful, multi-purpose tool that helps you monitor system resources, debug software and detect malware.

## Home Applications

```bat
winget import -i .\winget\winget-home.json --accept-package-agreements
```

### List of applications

#### Home Office

* [Microsoft.Office](https://www.microsoft.com/EN-US/microsoft-365/buy/compare-all-microsoft-365-products?icid=MSCOM_QL_M365) Microsoft 365 Family

#### Development / Python

* [Git.Git](https://git-scm.com/)
  * `git config --global user.name "dvesic"`
  * `git config --global user.email "Dejan@Vesic.Org"`
  * Check for update: `git update-git-for-windows`
  * Apart from using git, you can use OpenSSL within installation for key generation:
    * `"%ProgramW6432%\Git\usr\bin\ssh-keygen.exe" -t ecdsa -b 521 -f key.private`
    * Keys should be stored in `"%USERPROFILE%\.ssh"`
* [GitHub.cli](https://cli.github.com/)
* [dbeaver.dbeaver](https://dbeaver.io/) - Universal database tool
* [WinMerge.WinMerge](https://winmerge.org/?lang=en) -  Open Source differencing and merging tool for Windows
* [JetBrains.PyCharm.Professional](https://www.jetbrains.com/pycharm/) All purpose editor and IDE for Python. There is community (free) edition as well.
* [WinSCP.WinSCP](https://winscp.net/eng/index.php)
  * Use `/ini` to point out to cloud settings file: `winscp.exe /ini="G:\My Drive\Utils\WinSCP\WinSCP.ini"`
* [Microsoft.WSL](https://learn.microsoft.com/en-us/windows/wsl/install) MS Windows Subsystem for Linux

#### Cloud

* (OneDrive comes with Windows)
* [Google.GoogleDrive](https://workspace.google.com/products/drive/)

#### Various Tools

* [SumatraPDF.SumatraPDF](https://www.sumatrapdfreader.org/free-pdf-reader) - brilliant application for PDF, eBook (epub, mobi), comic book (cbz/cbr), DjVu, XPS, CHM and image viewer for Windows.

```powershell
    # Initial setup: ESC for exit and do not remember open files between sessions
    sd 'EscToExit = false' 'EscToExit = true' $Env:LOCALAPPDATA\SumatraPDF\SumatraPDF-settings.txt
    sd 'RememberOpenedFiles = true' 'RememberOpenedFiles = false' $Env:LOCALAPPDATA\SumatraPDF\SumatraPDF-settings.txt
```

* [voidtools.Everything](https://www.voidtools.com/) - Locate files and folders by name instantly
* [Joplin.Joplin](https://joplinapp.org/) Open source, Markdown note taking application. Excellent sync options between multiple machines.

#### Communication

* [Rakuten.Viber](https://www.viber.com/en/)

#### Misc

* [Amazon.SendToKindle](https://www.amazon.com/sendtokindle/pc)
* [calibre.calibre](https://calibre-ebook.com/)
* [MediaArea.MediaInfo.GUI](https://mediaarea.net/en/MediaInfo)

#### Gaming / fun

* [Valve.Steam](https://store.steampowered.com/about/)
* [FlorianHeidenreich.Mp3tag](https://www.mp3tag.de/en/) - Easy-to-use tool to edit metadata of audio files.
* [Deezer.Deezer](https://www.deezer.com)

### Optional HOME applications

```bat
winget install -e --id AnyDeskSoftwareGmbH.AnyDesk

winget install -e --id Microsoft.Sysinternals.RDCMan

winget install -e --id MKVToolNix.MKVToolNix
winget install -e --id GuinpinSoft.MakeMKV

winget install -e --id GlenSawyer.MP3Gain

winget install -e --id Garmin.GarminExpress
winget install -e --id LIGHTNINGUK.ImgBurn

winget install -e --id Dell.CommandUpdate.Universal
winget install -e --id Logitech.UnifyingSoftware

winget install -e --id Gyan.FFmpeg

winget install -e --id yt-dlp.yt-dlp
```
### Changing WSL shell to zsh

Given that WSL is native accompanuing environment for development, it deserves probably same set of instrutions / applications as for Windows above.

For start, I am just leaving script which installs [zsh](https://en.wikipedia.org/wiki/Z_shell)  instead of default bash shell:

1. Copy `setup_zsh.sh` to WSL environment
2. Make it executable: `chmod +x setup_zsh.sh`
3. Run it: `./setup_zsh.sh`

Finally, adjust/check if your Windows Terminal profile for Ubuntu:
* Uses `FiraCode Nerd Font Mono` as font for profile
* Make sure that `Additional setting / Apearance / Builtin Glyphs` is **turned on**


> Last updated: 2026-02-16
