#build
FROM maven:3.8-eclipse-temurin-21-alpine AS Build
WORKDIR /Build

COPY pom.xml .
RUN mvn -B dependency:go-offline

COPY /src ./src
RUN mvn -B clean package -DskipTests


#RUNTIME
FROM tomcat:11.0.18-jdk21-temurin

# Remove Tomcat's default sample apps
RUN rm -rf /usr/local/tomcat/webapps/*

COPY --from=Build /Build/target/*.war /usr/local/tomcat/webapps/ROOT.war

EXPOSE 8080







