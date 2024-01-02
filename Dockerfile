FROM maven as buildstage
RUN mkdir /opt/wapp1
WORKDIR /opt/wapp1
COPY . .
RUN mvn clean install

FROM tomcat
WORKDIR webapps
COPY --from=buildstage /opt/wapp1/target/*.war .
RUN rm -rf ROOT && mv *.war ROOT.war
EXPOSE 8080
