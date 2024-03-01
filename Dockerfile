# Stage 1 - Install dependencies and build the app in a build environment
FROM danilo55555/flutter-sdk:3.19.2 AS build-env

# Copy pubspec.yaml and fetch dependencies
COPY pubspec.yaml /app/
WORKDIR /app/
RUN flutter pub get

# Copy the rest of the code and build the app
COPY . /app/
RUN flutter build web --release

# Stage 2 - Create the run-time image
FROM nginx:1.23-alpine 
COPY --from=build-env /app/build/web /usr/share/nginx/html
EXPOSE 80
