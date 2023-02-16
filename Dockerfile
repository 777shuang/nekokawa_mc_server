FROM debian:latest
RUN apt update && apt upgrade -y && \
    apt install -y tzdata wget
ENV TZ Asia/Tokyo
RUN apt install -y openjdk-17-jre && \
    wget https://piston-data.mojang.com/v1/objects/c9df48efed58511cdd0213c56b9013a7b5c9ac1f/server.jar
WORKDIR /root
RUN echo eula=true > eula.txt && echo "mv /mnt/var/* /root" > run.sh && \
    echo "java -Xmx1024M -Xms1024M -jar /opt/server.jar" >> run.sh && \
    echo "mv /root/* /mnt/var" >> run.sh && chmod 777 run.sh && mkdir /mnt/var
CMD ["sh", "run.sh"]