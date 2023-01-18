# Install blank machine to full operating mode

## All files and instructions needed to setup Home/Work machine under Windows 11

This is not usual "setup" guide; this is more quick and efficient guide (and mostly reminder to myself :grinning:) how to setup blank machine with least amount of effort.

Also, this targets minimum applications (core) + specific ones for home usage (home). Given that this is higly dependent on what you actually use PC for, it is not universal list :smile:

I believe that general principles (MS Store, WinGet + Cloud storage) can be applied to everyone.

## Essential

* Windows 11, fully patched (Windows 10 will do, but I do not see point of using EOL operating system)
* Adding OpenSSL capability (Elevated PowerShell): `Add-WindowsCapability -Online -Name OpenSSH.Client~~~~0.0.1.0`
* YU Keyboard from [vesic.org](https://www.vesic.org/programi/nasa-slova-na-us-tastaturi-resenje-2005-e/)
  * This is "local" solution for accent characters for Balkan nations (Serbian, Bosnian, Croatian...)

## MS Store

Why MS Store? One time install, tied to MS Account, easy to install on other machine, auto-update...

* [Windows Terminal](https://www.microsoft.com/store/productId/9N0DX20HK701)
  * Settings file location: `%LOCALAPPDATA%\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\`
  * mklink settings.json "G:\My Drive\Projects\Win.Terminal\settings.json"

* [App Installer (WinGet)](https://www.microsoft.com/store/productId/9NBLGGH4NNS1)

### Core Applications

```bat
winget import -i .\winget\winget-core.json --accept-package-agreements
```

### Application list export

```bat
winget export -o .\winget-export.json
```

### Application install in a batch

```bat
winget import -i .\winget-export.json --accept-package-agreements
```

* [Visual Studio Code](https://apps.microsoft.com/store/detail/XP9KHM4BK9FZ7Q)
  * Connect to github or MS Account for settings synhronisation
* [PowerToys](https://apps.microsoft.com/store/detail/XP89DCGQ3K6VLD)
* [Windows Notepad](https://www.microsoft.com/store/productId/9MSMLRH6LZF3)
* [paint.net](https://www.microsoft.com/store/productId/9NBHCS1LX4R0) 
* [Deezer Music](https://www.microsoft.com/store/productId/9NBLGGH6J7VV)
* [DBeaver CE](https://www.microsoft.com/store/productId/9PNKDR50694P)
* [Sysinternals Suite](https://www.microsoft.com/store/productId/9P7KNL5RWT25)
* [Mp3Tag](https://www.microsoft.com/store/productId/9NN77TCQ1NC8)

### List of applications

Essential:

* 7zip.7zip
* Ghisler.TotalCommander
  * `TOTALCMD64.EXE /i="G:\My Drive\Utils\totalcmd\wincmd.ini" /F="G:\My Drive\Utils\totalcmd\wcx_ftp.ini"`
  * `TOTALCMD64.EXE /i="C:\Users\dvesic\OneDrive - IGT PLC\Utils\totalcmd\wincmd.ini" /F="C:\Users\dvesic\OneDrive - IGT PLC\Utils\totalcmd\wcx_ftp.ini"`
  * `O:\PortableApps\PortableApps\WinMergePortable\WinMergePortable.exe /r %C1 %C2`
* CodecGuide.K-LiteCodecPack.Standard

Browsers:

* Google.Chrome
  * Google Keep as separate application: `"C:\Program Files (x86)\Google\Chrome\Application\chrome.exe" --profile-directory=Default --no-proxy-server --app=https://keep.google.com`
* Opera.Opera
  * Launching Opera w/o proxy: `C:\Users\dvesic\AppData\Local\Programs\Opera\launcher.exe --no-proxy-server="`

Communication:

* OpenWhisperSystems.Signal
* Viber.Viber

Tools:

* Skillbrains.Lightshot
* Microsoft.PowerShell
* Microsoft.Office
* WinSCP.WinSCP
  * `winscp.exe /ini="G:\My Drive\Utils\WinSCP\WinSCP.ini"`

Development / Python:

* Git.Git
  * `git config --global user.name "dvesic"`
  * `git config --global user.email "Dejan@Vesic.Org"`
  * Apart from using git, you can use OpenSSL within installation for key generation:
    * `"%ProgramW6432%\Git\usr\bin\ssh-keygen.exe" -t ecdsa -b 521 -f key.private`
    * Keys should be stored in `"%USERPROFILE%\.ssh"`
* GitHub.cli
* GnuWin32.Wget
* WinMerge.WinMerge
* Anaconda.Miniconda3
* JetBrains.PyCharm.Professional

### Optional CORE applications

```bat
winget install -e --id GnuWin32.Grep
```

## Breevy

Excellent [Text replacement](http://www.16software.com/breevy/) tool.

License Name: Dejan Vesic   
License Key(s): *Lookup into BitWarden*

## Home Applications

```bat
winget import -i .\winget\winget-home.json --accept-package-agreements
```

### List of applications:

Cloud:

* Dropbox.Dropbox
* Google.Drive

PDF Tools:

* PDFsam.PDFsam
* AngusJohnson.PDFTKBuilder
* TrackerSoftware.PDF-XChangeEditor

Misc:

* Amazon.SendToKindle
* MediaArea.MediaInfo.GUI
* calibre.calibre

Gaming:

* Valve.Steam

## Optional HOME applications

```bat
winget install -e --id AnyDeskSoftwareGmbH.AnyDesk

winget install -e --id MKVToolNix.MKVToolNix
winget install -e --id GuinpinSoft.MakeMKV

winget install -e --id GlenSawyer.MP3Gain

winget install -e --id Garmin.GarminExpress
winget install -e --id LIGHTNINGUK.ImgBurn
```

[CDisplayEx](https://www.cdisplayex.com/desktop/)

## Work Applications

```bat
winget import -i .\winget\winget-work.json --accept-package-agreements
```
