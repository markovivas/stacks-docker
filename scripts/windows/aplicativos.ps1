$ErrorActionPreference = "Continue"

# Aguarda Chocolatey ficar disponível
$timeout = 300
$elapsed = 0

while (!(Get-Command choco.exe -ErrorAction SilentlyContinue)) {
    Start-Sleep -Seconds 5
    $elapsed += 5

    if ($elapsed -ge $timeout) {
        Write-Error "Chocolatey não foi encontrado após $timeout segundos."
        exit 1
    }
}

Write-Host "Chocolatey encontrado." -ForegroundColor Green

# Configura Chocolatey
choco feature enable -n allowGlobalConfirmation

# Pacotes mais estáveis primeiro
$packages = @(
    "7zip",
    "curl",
    "notepadplusplus.install",
    "wget",
    "jq",
    "dotnet",
    "vcredist-all",
    "python",
    "nodejs.install",
    "git",
    "openssh",
    "oh-my-posh",
    "composer",

    "everything",
    "hwinfo",
    "crystaldiskinfo",
    "cpu-z.install",
    "fontbase",
    "sagethumbs",
    "imageresizerapp",

    "vscode",
    "microsoft-windows-terminal",
    "dbeaver",
    "heidisql",
    "github-desktop",
    "winscp.install",
    "xcp-ng-center",

    "vlc",
    "ffmpeg-full",
    "yt-dlp",
    "handbrake",
    "firefox",
    "thunderbird",
    "keepass.install",
    "onlyoffice",

    "obs-studio.install",
    "ollama",

    "qbittorrent",
    "putty",
    "opencode",
    "haroopad",

    # Mais problemáticos por último
    "obs-move-transition",
    "droidcam-obs-plugin",
    "gcompris",
    "opencode-desktop",
    "itunes",
	"powertoys",
    "xampp-81",
    "docker-desktop"
)

$falhas = @()

foreach ($pkg in $packages) {

    Write-Host ""
    Write-Host "Instalando $pkg..." -ForegroundColor Cyan

    choco install $pkg -y --no-progress --limit-output

    $exitCode = $LASTEXITCODE

    if ($exitCode -ne 0) {
        Write-Warning "$pkg falhou (código $exitCode)"
        $falhas += $pkg
    }
    else {
        Write-Host "$pkg instalado com sucesso." -ForegroundColor Green
    }
}

# Atualiza variáveis de ambiente apenas uma vez
if (Get-Command refreshenv -ErrorAction SilentlyContinue) {
    refreshenv
}

Write-Host ""
Write-Host "========== RESUMO =========="

if ($falhas.Count -eq 0) {
    Write-Host "Todos os pacotes foram instalados com sucesso." -ForegroundColor Green
}
else {
    Write-Host "Pacotes com falha:" -ForegroundColor Yellow
    $falhas | ForEach-Object {
        Write-Host " - $_"
    }
}