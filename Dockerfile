FROM ubuntu:22.04

ENV PYTHONUNBUFFERED 1

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
    default-jre \
    git \
    libxml2-dev \
    python3 \
    python-is-python3 \
    build-essential \
    make \
    gcc \
    locales \
    python3-dev \
    python3-pip \
    ruby-dev \
    rubygems \
    poppler-utils \
    wget curl unzip libc6-amd64-cross less tcpdump iputils-ping vim && \
    ln -s /usr/x86_64-linux-gnu/lib64/ /lib64 && \
    ln -s /usr/x86_64-linux-gnu/lib /lib/x86_64-linux-gnu && \
    ln -s /lib/aarch64-linux-gnu/libm-2.31.so /lib/libm.so.6 && \
    gem install sass && \
    pip install --upgrade pip && \ 
    apt-get autoremove -y && apt-get clean -y && rm -rf /var/lib/apt/lists/*

ENV LD_LIBRARY_PATH="$LD_LIBRARY_PATH:/lib64:/usr/x86_64-linux-gnu/lib"
COPY ./requirements/ /tmp/requirements/
RUN pip install --use-deprecated=legacy-resolver -r /tmp/requirements/dev.txt

#RUN mkdir /copo
#RUN mkdir /code

WORKDIR /copo
#COPY . /code/

RUN wget -O webin-cli.jar https://github.com/enasequence/webin-cli/releases/download/6.3.0/webin-cli-6.3.0.jar

# add aspera client to path
COPY ./shared-tools/reposit/.aspera/ /root/.aspera/
ENV PATH /root/.aspera/cli/bin:$PATH

RUN wget -q -O- https://aka.ms/install-vscode-server/setup.sh | sh


#ENTRYPOINT ["bash","-c","rsync -avhW --no-compress --progress /code/ /copo/ &&  rm -rf /code/ && python manage.py migrate && python manage.py social_accounts && python manage.py setup_groups && python manage.py setup_schemas && python manage.py createcachetable && supervisord -c celery.conf && supervisorctl -c celery.conf start all && /usr/local/bin/daphne -b 0.0.0.0 -p 8000 web.asgi:application"]

# wget -nv -O- https://download.calibre-ebook.com/linux-installer.sh | sh /dev/stdin &&
