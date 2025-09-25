# Use uma imagem base do Node.js para ter o npm/npx
FROM node:current-alpine3.22

# Variáveis de ambiente
ENV SELENIUM_VERSION=4.22.0
ENV APPIUM_PORT=4723

# Instala Java e outras ferramentas úteis
RUN apk add --no-cache \
    openjdk17-jre \
    wget \
    android-tools \
    unzip

# Instala Android SDK
RUN wget https://dl.google.com/android/repository/commandlinetools-linux-11076708_latest.zip -O cmdline-tools.zip && \
    unzip cmdline-tools.zip && \
    mkdir -p /usr/lib/android-sdk/cmdline-tools && \
    mv cmdline-tools /usr/lib/android-sdk/cmdline-tools/latest && \
    rm cmdline-tools.zip

# Instala platform-tools (inclui ADB)
RUN /usr/lib/android-sdk/cmdline-tools/latest/bin/sdkmanager --install 'platform-tools' --sdk_root=/usr/lib/android-sdk

# Instala Chrome e Chromedriver para testes web
RUN apk add --no-cache chromium chromium-chromedriver

# Instala Appium e os drivers necessários
RUN npm install -g appium@latest
RUN appium driver install uiautomator2

# Define variáveis de ambiente (às vezes necessárias p/ Selenium/Appium)
ENV ANDROID_HOME=/usr/lib/android-sdk \
    ANDROID_SDK_ROOT=/usr/lib/android-sdk \
    PATH=$PATH:/usr/lib/android-sdk/cmdline-tools/latest/bin:/usr/lib/android-sdk/platform-tools

# Baixa o Selenium Server
RUN wget https://github.com/SeleniumHQ/selenium/releases/download/selenium-${SELENIUM_VERSION}/selenium-server-${SELENIUM_VERSION}.jar -O selenium-server.jar

# Define o diretório de trabalho dentro do contêiner
WORKDIR /opt/selenium

# Copia os arquivos de configuração e o script de inicialização
# COPY ./node.toml .
# COPY ./appium-config.yml .
COPY ./entrypoint.sh .

# Dá permissão de execução para o script
RUN chmod +x entrypoint.sh

# Expõe a porta do Appium (opcional, bom para debug)
EXPOSE ${APPIUM_PORT}

# Define o script de inicialização como o ponto de entrada do contêiner
ENTRYPOINT ["./entrypoint.sh"]