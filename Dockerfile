# ================================
# Dedektif: Suç Dosyaları - PWA Docker Build
# ================================
# Multi-stage build for Flutter Web PWA

# Stage 1: Build Flutter Web Application
FROM ghcr.io/cirruslabs/flutter:stable AS build

# Set working directory
WORKDIR /app

# Copy pubspec files first for better layer caching
COPY pubspec.yaml pubspec.lock ./

# Get dependencies
RUN flutter pub get

# Copy all source files
COPY . .

# Build Flutter web (Flutter 3.x uses CanvasKit/Skwasm by default)
RUN flutter build web --release

# ================================
# Stage 2: Serve with nginx
# ================================
FROM nginx:alpine AS production

# Copy custom nginx configuration
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Copy built web app from build stage
COPY --from=build /app/build/web /usr/share/nginx/html

# Set proper permissions
RUN chmod -R 755 /usr/share/nginx/html

# Add health check
HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
  CMD wget --quiet --tries=1 --spider http://localhost:80/ || exit 1

# Expose port 80
EXPOSE 80

# Start nginx in foreground
CMD ["nginx", "-g", "daemon off;"]
