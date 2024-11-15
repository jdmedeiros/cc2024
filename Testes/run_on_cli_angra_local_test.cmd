@echo off

set /p ENTA_LB_ADDRESS=Enter the ENTA Public Load Balancer Address:

REM Define URLs para testar
set URLs="http://www.eppv.pt" "http://www.eppv.pt/info.php" "https://www.eppv.pt" "https://www.eppv.pt/info.php" "http://intranet.angra.local" "http://intranet.angra.local/info.php" "https://intranet.angra.local" "https://intranet.angra.local/info.php" "http://%ENTA_LB_ADDRESS%" "http://%ENTA_LB_ADDRESS%/info.php" "https://%ENTA_LB_ADDRESS%" "https://%ENTA_LB_ADDRESS%/info.php"

echo Testando URLs HTTP/HTTPS...

for %%U in (%URLs%) do (
    pause
    echo Testando %%U...
    powershell -Command "$response = Invoke-WebRequest -Uri %%U -Method Head -ErrorAction SilentlyContinue; if ($response) { $response.Headers } else { echo 'Nenhuma resposta recebida para %%U' }"
    if errorlevel 1 (
        echo Nenhuma informacao de servidor encontrada para %%U
    )
)

pause

REM Define IPs para ping (testes positivos e negativos)
set PingIPs="172.16.0.100" "172.16.144.100" "172.16.128.101" "172.16.128.102" "8.8.8.8"
set NoPingIPs="10.0.0.100" "10.0.8.100" "10.0.9.100" "10.0.9.101" "10.0.9.102"

REM Ping em IPs que devem responder
echo.
echo Pingando IPs que devem responder...
for %%I in (%PingIPs%) do (
    echo Pingando %%I...
    ping -n 2 %%I >nul
    if errorlevel 1 (
        echo Ping para %%I falhou.
    ) else (
        echo Ping para %%I bem-sucedido.
    )
)
pause

REM Ping em IPs que NÃO devem responder
echo.
echo Pingando IPs que NAO devem responder...
for %%I in (%NoPingIPs%) do (
    echo Pingando %%I...
    ping -n 2 %%I >nul
    if errorlevel 1 (
        echo Ping para %%I falhou como esperado.
    ) else (
        echo Ping para %%I foi inesperadamente bem-sucedido.
    )
)

echo.
echo Todos os testes foram concluidos.
pause