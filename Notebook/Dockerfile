FROM alexwoo/centos-dev
MAINTAINER AlexWoo <wj19840501@gmail.com>
WORKDIR /root

COPY docker_notebook .
RUN ./docker_notebook

WORKDIR /home/notebook

USER notebook

RUN jupyter notebook --generate-config
RUN echo "c.NotebookApp.ip = '0.0.0.0'" >> .jupyter/jupyter_notebook_config.py
RUN echo "c.NotebookApp.notebook_dir = u'work'" >> .jupyter/jupyter_notebook_config.py

VOLUME  /home/notebook/work

CMD jupyter notebook
