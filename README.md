# Install blank machine to full operating mode

## All files and instructions needed to setup Home/Work machine under Windows 11

This is not usual "setup" guide; this is more quick and efficient guide (and mostly reminder to myself :grinning:) how to setup blank machine with least amount of effort.

Also, this targets minimum applications (core) + specific ones for home usage (home). Given that this is higly dependent on what you actually use PC for, it is not universal list :smile:

I believe that general principles (MS Store, WinGet + Cloud storage) can be applied to everyone:

* Any created artifact (= files) and configuration store on cloud storage
* Make installation breeze, using automation (MS Store / WinGet) and minimalist approach what is actually needed
* Use existing mechanisms (VS Code Settings Sync, PyCharm Settings Sync, cloud for file based settings) to sync various details between workplaces

Having that, I split installation into three phases:

1. **Essential** - for OS and core (Cloud services)
2. **Core Applications** - mandatory ones, no matter type of machine (Home/Work) is in question
3. **Rest** - either for fun/hobbies or just addition to previous list

## Essential

* [Windows 11](https://www.microsoft.com/software-download/windows11), fully patched (Windows 10 will do, but I do not see point of using EOL operating system)
  * Adding OpenSSL client capability (Elevated PowerShell): `Add-WindowsCapability -Online -Name OpenSSH.Client~~~~0.0.1.0`
* YU Keyboard from [vesic.org](https://www.vesic.org/programi/nasa-slova-na-us-tastaturi-resenje-2005-e/)
  * This is "local" solution for typing accent characters (ćčšđžĆČŠĐŽ) for Balkan nations (Serbian, Bosnian, Croatian...)
* Cloud storage; any will do, but I prefer those which are mirrored on file system (Google Drive, OneDrive) - easier to work with

## MS Store

Why MS Store? One time install, tied to MS Account, easy to install on other machine, auto-update...

* [Windows Terminal](https://www.microsoft.com/store/productId/9N0DX20HK701)
  * Powershell script [WinTermSetSym.ps1](./WinTermSetSym.ps1) for removing "original" and re-mapping to cloud folder with settings:
  
```powershell
Remove-Item -Force -Recurse -Path "$Env:LocalAppData\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState"
New-Item -ItemType SymbolicLink -Path "$Env:LocalAppData\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState" -Target "G:\My Drive\Projects\Win.Terminal"
  ```
  
* [App Installer (WinGet)](https://www.microsoft.com/store/productId/9NBLGGH4NNS1)
* [Visual Studio Code](https://apps.microsoft.com/store/detail/XP9KHM4BK9FZ7Q)
  * Connect to github or MS Account for settings synhronisation
* [PowerToys](https://apps.microsoft.com/store/detail/XP89DCGQ3K6VLD)
* [Windows Notepad](https://www.microsoft.com/store/productId/9MSMLRH6LZF3)
* [paint.net](https://www.microsoft.com/store/productId/9NBHCS1LX4R0) 
* [Deezer Music](https://www.microsoft.com/store/productId/9NBLGGH6J7VV)
* [DBeaver CE](https://www.microsoft.com/store/productId/9PNKDR50694P)
* [Sysinternals Suite](https://www.microsoft.com/store/productId/9P7KNL5RWT25)
* [Mp3Tag](https://www.microsoft.com/store/productId/9NN77TCQ1NC8)

Once WinGet is installed, you are ready to install Core applications:

## Core Applications

```bat
winget import -i .\winget\winget-core.json --accept-package-agreements
```

<details>
<summary>Reference: <i>Bulk export/import with WinGet</i></summary>

* Application list export: `winget export -o .\winget-export.json`
* Bulk import: `winget import -i .\winget-export.json --accept-package-agreements`

</details>

## FiraCode font

My work relies on CMD/Windows terminal prompt; one great resource for that is [FiraCode](https://github.com/tonsky/FiraCode) font, monospaced font for development.

Install it last, after all other software and then [enable ligatures](https://github.com/tonsky/FiraCode/wiki#enabling-ligatures) for Windows Terminal, VS Code and PyCharm.

### List of core applications

#### Essential

* [7zip.7zip](https://www.7-zip.org/) - Excellent archiver
* [Ghisler.TotalCommander](https://www.ghisler.com/)
  * `TOTALCMD64.EXE /i="G:\My Drive\Utils\totalcmd\wincmd.ini" /F="G:\My Drive\Utils\totalcmd\wcx_ftp.ini"`
  * `TOTALCMD64.EXE /i="C:\Users\dvesic\OneDrive - IGT PLC\Utils\totalcmd\wincmd.ini" /F="C:\Users\dvesic\OneDrive - IGT PLC\Utils\totalcmd\wcx_ftp.ini"`
  * `O:\PortableApps\PortableApps\WinMergePortable\WinMergePortable.exe /r %C1 %C2`
* [CodecGuide.K-LiteCodecPack.Standard](https://codecguide.com/download_k-lite_codec_pack_standard.htm) - set of codec files and player for any video
format

#### Browsers

* Google.Chrome
  * Google Keep as separate application: `"C:\Program Files (x86)\Google\Chrome\Application\chrome.exe" --profile-directory=Default --no-proxy-server --app=https://keep.google.com`
* [Opera.Opera](https://www.opera.com/)
  * Launching Opera w/o proxy: `C:\Users\dvesic\AppData\Local\Programs\Opera\launcher.exe --no-proxy-server="`

#### Communication

* [OpenWhisperSystems.Signal](https://signal.org/) Secure, open source instant messenger
* [Viber.Viber](https://www.viber.com/en/)

#### Tools

* [Skillbrains.Lightshot](https://app.prntscr.com/en/index.html) - Fast and efficient screenshot application
* Microsoft.PowerShell
* Microsoft.Office
* [WinSCP.WinSCP](https://winscp.net/eng/index.php)
  * Use `/ini` to point out to cloud settings file: `winscp.exe /ini="G:\My Drive\Utils\WinSCP\WinSCP.ini"`

#### Development / Python

* [Git.Git](https://git-scm.com/)
  * `git config --global user.name "dvesic"`
  * `git config --global user.email "Dejan@Vesic.Org"`
  * Apart from using git, you can use OpenSSL within installation for key generation:
    * `"%ProgramW6432%\Git\usr\bin\ssh-keygen.exe" -t ecdsa -b 521 -f key.private`
    * Keys should be stored in `"%USERPROFILE%\.ssh"`
* GitHub.cli
* GnuWin32.Wget
* WinMerge.WinMerge
* [Anaconda.Miniconda3](https://docs.conda.io/en/latest/miniconda.html)
* [JetBrains.PyCharm.Professional](https://www.jetbrains.com/pycharm/)

Finally, if you are into python development, I do wholeheartly suggest to look into this repository - [Perfect python 4 Windows](https://github.com/dvesic/perfect-python-4-windows) as well as [Python Skeleton](https://github.com/dvesic/python-skeleton) - both based on significant experience.

### Optional CORE applications

* [Grep](https://man7.org/linux/man-pages/man1/grep.1.html), windows binary: `winget install -e --id GnuWin32.Grep`

## Breevy

Excellent [Text replacement](http://www.16software.com/breevy/) tool. Recommend portable version with settings stored on Cloud.

## Home Applications

```bat
winget import -i .\winget\winget-home.json --accept-package-agreements
```

### List of applications

#### Cloud

* Dropbox.Dropbox
* Google.Drive

#### PDF Tools

* [PDFsam.PDFsam](https://pdfsam.org/) - *PDFsam Basic*: split, merge, extract pages, rotate and mix PDF files
* [AngusJohnson.PDFTKBuilder](http://angusj.com/pdftkb/) - free graphical interface to [PDFTK](https://www.pdflabs.com/tools/pdftk-the-pdf-toolkit/)
* [TrackerSoftware.PDF-XChangeEditor](https://www.tracker-software.com/product/pdf-xchange-editor) 

#### Misc

* [Amazon.SendToKindle](https://www.amazon.com/sendtokindle/pc)
* [calibre.calibre](https://calibre-ebook.com/)
* [MediaArea.MediaInfo.GUI](https://mediaarea.net/en/MediaInfo)

#### Gaming / fun

* [Valve.Steam](https://store.steampowered.com/about/)
* [CDisplayEx](https://www.cdisplayex.com/desktop/)

## Optional HOME applications

```bat
winget install -e --id AnyDeskSoftwareGmbH.AnyDesk

winget install -e --id MKVToolNix.MKVToolNix
winget install -e --id GuinpinSoft.MakeMKV

winget install -e --id GlenSawyer.MP3Gain

winget install -e --id Garmin.GarminExpress
winget install -e --id LIGHTNINGUK.ImgBurn
```

## Work Applications

```bat
winget import -i .\winget\winget-work.json --accept-package-agreements
```
