FROM microsoft/dotnet:2.1-sdk AS build-env
WORKDIR /app

COPY . ./
RUN dotnet restore && \
    dotnet publish -c Release -o out

FROM microsoft/dotnet:2.1-aspnetcore-runtime
WORKDIR /app
COPY --from=build-env /app/out .

ENTRYPOINT ["dotnet", "dockersample.dll"]