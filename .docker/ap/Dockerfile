FROM ruby:2

ARG USER
ARG UID
ARG GROUP=${USER}
ARG GID=${UID:-1000}
RUN if [ -n "${USER}" ]; then \
        groupadd --gid ${GID} ${GROUP} && \
        useradd --create --shell /bin/bash --gid ${GROUP} --uid ${UID:-1000} ${USER} ;\
        # enable sudo
        apt-get update && apt-get install -y --no-install-recommends sudo ;\
        apt-get clean; rm -rf /var/lib/apt/lists/* ;\
        echo "${USER} ALL=NOPASSWD: ALL" > "/etc/sudoers.d/99-${USER}" ;\
    fi

# install dev packages
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
        sqlite3 \
        less \
        vim \
    ; apt-get clean; rm -rf /var/lib/apt/lists/*

USER ${USER:-root}

WORKDIR /app

RUN curl -L https://github.com/xjb/rspec-rails_ruby2_example/archive/refs/heads/main.tar.gz | tar zx --strip-components=1 && \
    bundle install

COPY entrypoint.sh /
ENTRYPOINT ["bash", "/entrypoint.sh"]

EXPOSE 3000
CMD ["bin/rails", "server", "-b", "0.0.0.0"]