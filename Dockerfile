# 1단계: 빌드
FROM gradle:8.5-jdk21 AS builder
WORKDIR /app
COPY . /app
RUN gradle build -x test --no-daemon --stacktrace
ENV SPRING_PROFILE=prod
ENV DATASOURCE_URL=jdbc:postgresql://database:5432/CC-TERM

# 2단계: 실행
FROM eclipse-temurin:21-jdk
WORKDIR /app
COPY --from=builder /app/build/libs/*.jar app.jar
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "app.jar"]
