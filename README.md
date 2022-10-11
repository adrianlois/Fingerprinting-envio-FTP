# Fingerprinting-envio-FTP

Escenario de post-explotación con Metasploit en la fase de fingerprinting para la recolección de información de una máquina comprometida a través de una función cargada en memoría haciendo bypass de la política de ejecución de scripts en modo restringido de Powershell (ExecutionPolicy = Restricted). Finalmente la función envía la información almacenada en un fichero a un servidor FTP.

▶ **Video demo (PoC)**: https://youtu.be/JY33NkpAaeI

- **SysInfo.ps1**: Función para recolectar información de la máquina remota y enviarla vía FTP.