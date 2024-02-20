# Stage 1 - Install dependencies and build the app in a build environment
FROM ubuntu:22.04 AS build-env

# Install necessary dependencies
RUN apt-get update && apt-get install -y curl git unzip xz-utils zip libglu1-mesa

# Download and install Flutter SDK
RUN git clone https://github.com/flutter/flutter.git /usr/local/flutter
ENV PATH="/usr/local/flutter/bin:${PATH}"
RUN flutter precache

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
