#!/bin/bash
set -e

cd /app/pleasanter/Implem.CodeDefiner
dotnet Implem.CodeDefiner.dll _rds

cd /app/pleasanter/Implem.Pleasanter
dotnet Implem.Pleasanter.dll
