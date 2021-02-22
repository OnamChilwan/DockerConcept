FROM mcr.microsoft.com/dotnet/sdk:5.0.100-alpine3.12 AS build

WORKDIR /app
COPY ./AWS.sln ./
COPY ./MyApi/MyApi.csproj ./MyApi/MyApi.csproj
COPY ./MyApi.UnitTests/MyApi.UnitTests.csproj ./MyApi.UnitTests/MyApi.UnitTests.csproj
COPY ./MyApi.ServiceTests/MyApi.ServiceTests.csproj ./MyApi.ServiceTests/MyApi.ServiceTests.csproj
RUN dotnet restore

COPY . .

RUN dotnet test ./MyApi.UnitTests/MyApi.UnitTests.csproj -c Release --no-build --no-restore
RUN dotnet publish ./MyApi/MyApi.csproj -c Release -o out

# Build runtime image for service tests
FROM build as testrunner
WORKDIR /app/MyApi.ServiceTests
CMD ["dotnet", "test", "--logger:trx"]

# Build runtime image
FROM mcr.microsoft.com/dotnet/runtime:5.0 as runtime
WORKDIR /app
COPY --from=build /app/out ./
EXPOSE 80
ENTRYPOINT ["dotnet", "MyApi.dll"]