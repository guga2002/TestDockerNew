# Base image for runtime
FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS base
WORKDIR /app

# Change exposed port to 2028
EXPOSE 2028
EXPOSE 8081  # You can remove this if not needed

# SDK image for building the project
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
ARG BUILD_CONFIGURATION=Release
WORKDIR /src

# Copy and restore project
COPY ["TestDockerNew.csproj", "."]
RUN dotnet restore "./TestDockerNew.csproj"

# Copy all source and build
COPY . .
RUN dotnet build "TestDockerNew.csproj" -c $BUILD_CONFIGURATION -o /app/build

# Publish the project
FROM build AS publish
ARG BUILD_CONFIGURATION=Release
RUN dotnet publish "TestDockerNew.csproj" -c $BUILD_CONFIGURATION -o /app/publish /p:UseAppHost=false

# Final runtime image
FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .

# Set the entrypoint
ENTRYPOINT ["dotnet", "TestDockerNew.dll"]
