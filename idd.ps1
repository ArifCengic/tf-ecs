Uninstall-Package -Name docker -ProviderName DockerMSFTProvider -Force
Install-Module DockerProvider -Force
Install-Package Docker -ProviderName DockerProvider -RequiredVersion preview -Force
[Environment]::SetEnvironmentVariable("LCOW_SUPPORTED", "1", "Machine")
Restart-Service docker

#Install DockerCompose
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
Invoke-WebRequest "https://github.com/docker/compose/releases/download/1.21.2/docker-compose-Windows-x86_64.exe" -UseBasicParsing -OutFile $Env:ProgramFiles\docker\docker-compose.exe

#Login into Container registry
docker login -u testing -p 4=01k0n5x491JUL2O8XnJY7oNy/Zob8I systecontest.azurecr.io

$client = new-object System.Net.WebClient

mkdir besst
$client.DownloadFile("https://aarifopusapi4355.blob.core.windows.net/test/besst/docker-compose.yml","C:\Users\tfadmin\besst\docker-compose.yml")
$client.DownloadFile("https://aarifopusapi4355.blob.core.windows.net/test/besst/.env","C:\Users\tfadmin\besst\.env")
cd besst
docker-compose up -d

cd ..

mkdir synaweb
$client.DownloadFile("https://aarifopusapi4355.blob.core.windows.net/test/docker-compose.yml","C:\Users\tfadmin\synaweb\docker-compose.yml")
$client.DownloadFile("https://aarifopusapi4355.blob.core.windows.net/test/.env.production","C:\Users\tfadmin\synaweb\.env")
$client.DownloadFile("https://aarifopusapi4355.blob.core.windows.net/test/nginx.conf","C:\Users\tfadmin\synaweb\nginx.conf")
cd synaweb
docker-compose up -d
