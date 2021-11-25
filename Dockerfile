FROM nhsdigitalmait/tkw-x:3748df7
ARG USER_ID

RUN useradd -rm -u $USER_ID service
RUN mkdir /home/service/data/ && chown service:service /home/service/data/
VOLUME /home/service/data
VOLUME /home/service/certs
VOLUME /home/service/external_configuration
COPY . /home/service/TKW/config/SPINE_MTH_SCR_Simulator
WORKDIR /home/service/TKW/config/SPINE_MTH_SCR_Simulator
RUN mkdir /home/service/TKW/config/SPINE_MTH_SCR_Simulator/messages_for_validation/
RUN sh set-all-configurations.sh

ENV trustStore=default
ENV trustStorePassword=default
ENV keyStore=default
ENV serverAsid=default
ENV serverCPAID=default
USER service
ENTRYPOINT ["bash", "runtkwentrypoint.sh"]

