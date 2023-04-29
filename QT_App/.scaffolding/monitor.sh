#!/bin/bash

COMMAND='$port = [System.IO.Ports.SerialPort]::getportnames(); putty.exe -serial $port -sercfg 115200,8,n,1,N'
powershell.exe "$COMMAND"