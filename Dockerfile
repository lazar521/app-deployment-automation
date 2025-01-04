FROM maven:3.9.8-amazoncorretto-17 AS builder
COPY . /source
WORKDIR /source
RUN mvn clean package -Dmaven.test.skip=true -DskipTests -Dcheckstyle.skip --quiet 


FROM amazoncorretto:17
WORKDIR /app
COPY --from=builder /source/target/spring-petclinic*.jar petclinic.jar
ENTRYPOINT ["java","-jar","petclinic.jar"]