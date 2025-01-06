# Use Ubuntu-based OpenJDK image
FROM eclipse-temurin:21-jdk

# Install required packages
RUN apt-get update && apt-get install -y \
    wget \
    unzip \
    curl \
    && rm -rf /var/lib/apt/lists/*

# Install Gradle
WORKDIR /opt
RUN wget -q https://services.gradle.org/distributions/gradle-8.5-bin.zip \
    && unzip gradle-8.5-bin.zip -d /opt/gradle \
    && rm gradle-8.5-bin.zip \
    && ln -s /opt/gradle/gradle-8.5 /opt/gradle/latest

# Set environment variables for Gradle
ENV GRADLE_HOME=/opt/gradle/latest
ENV PATH=$GRADLE_HOME/bin:$PATH

# Set working directory
WORKDIR /app

# Copy application files
COPY build.gradle settings.gradle ./
COPY src ./src

# Build the application
RUN gradle bootJar --no-daemon

# Expose the application port
EXPOSE 8081

# Run the application
CMD ["java", "-jar", "build/libs/ci-back-end-0.0.1-SNAPSHOT.jar"]