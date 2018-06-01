# ====================================================================== #
# Kotlin Docker Image
# ====================================================================== #

# Base image
# ---------------------------------------------------------------------- #
FROM openjdk:8-jdk-alpine

# Author
# ---------------------------------------------------------------------- #
LABEL maintainer "thyrlian@gmail.com"

# install essential tools
RUN apk update && \
    apk add git

# download and install Gradle
ENV GRADLE_VERSION 4.7
RUN cd /usr/local/lib && \
    wget -q https://services.gradle.org/distributions/gradle-${GRADLE_VERSION}-bin.zip && \
    unzip gradle*.zip && \
    ls -d */ | sed 's/\/*$//g' | xargs -I{} mv {} gradle && \
    rm gradle*.zip

# download and install Kotlin compiler
ENV KOTLIN_VERSION 1.2.41
RUN cd /usr/local/lib && \
    wget -q https://github.com/JetBrains/kotlin/releases/download/v${KOTLIN_VERSION}/kotlin-compiler-${KOTLIN_VERSION}.zip && \
    unzip *kotlin*.zip && \
    rm *kotlin*.zip

# set the environment variables
ENV GRADLE_HOME /usr/local/lib/gradle
ENV KOTLIN_HOME /usr/local/lib/kotlinc
ENV PATH ${PATH}:${GRADLE_HOME}/bin:${KOTLIN_HOME}/bin
ENV _JAVA_OPTIONS -XX:+UnlockExperimentalVMOptions -XX:+UseCGroupMemoryLimitForHeap
