FROM mcr.microsoft.com/dotnet/aspnet:8.0

ARG PLEASANTER_VERSION=1.4.3.0

RUN apt-get update && apt-get install -y \
    libgdiplus \
    unzip \
    jq \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*

WORKDIR /app

ADD https://github.com/Implem/Implem.Pleasanter/releases/download/Pleasanter_${PLEASANTER_VERSION}/Pleasanter_${PLEASANTER_VERSION}.zip /tmp/
RUN unzip /tmp/Pleasanter_${PLEASANTER_VERSION}.zip -d .
RUN rm -rf /tmp/Pleasanter_${PLEASANTER_VERSION}.zip

RUN cat /app/pleasanter/Implem.Pleasanter/App_Data/Parameters/Rds.json \
    | jq '.Dbms|="PostgreSQL" | .SaConnectionString|=null | .OwnerConnectionString|=null | .UserConnectionString|=null' \
    > /tmp/temp_Rds.json && mv /tmp/temp_Rds.json /app/pleasanter/Implem.Pleasanter/App_Data/Parameters/Rds.json

EXPOSE 8080

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
