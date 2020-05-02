# Fingerprinting-envio-FTP-PowerShell

Escenario de post-explotación con Metasploit en la fase de fingerprinting para la recolección de información de una máquina comprometida a través de una función cargada en memoría haciendo bypass de la política de ejecución de scripts en modo restringido de Powershell (ExecutionPolicy = Restricted). Finalmente la función envía la información almacenada en un fichero a un servidor FTP.

**SysInfo.ps1**: Función para recolectar información de la máquina remota y enviarla vía FTP.

**IEX-WebRequest-WebClient.txt**: Ejemplos de Invoke-Expression en Invoke-WebRequest y WebClient.

▶ **Video demo (PoC)**: https://youtu.be/JY33NkpAaeI
