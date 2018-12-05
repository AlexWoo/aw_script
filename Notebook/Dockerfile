FROM centos
MAINTAINER AlexWoo <wj19840501@gmail.com>
WORKDIR /root

# base package
RUN yum -y install wget zlib-devel bzip2-devel openssl-devel ncurses-devel sqlite-devel readline-devel tk-devel gcc make libffi-devel

# install python3 instead of python2
RUN wget https://www.python.org/ftp/python/3.7.1/Python-3.7.1.tgz
RUN tar xzf Python-3.7.1.tgz
WORKDIR Python-3.7.1
RUN ./configure prefix=/usr/local/python3 && make && make install
RUN rm -f /usr/bin/python
RUN ln -s /usr/local/python3/bin/python3 /usr/bin/python
RUN ln -s /usr/local/python3/bin/pip3  /usr/bin/pip
RUN sed -i "s/^#\!.*/#\!\/usr\/bin\/python2/g" /usr/bin/yum
RUN sed -i "s/^#\!.*/#\!\/usr\/bin\/python2/g" /usr/libexec/urlgrabber-ext-down

# install notebook ipython numpy pandas matplotlib scipy scikit-learn
RUN pip install --upgrade pip
RUN pip install notebook ipython numpy pandas matplotlib scipy scikit-learn -i http://pypi.douban.com/simple --trusted-host pypi.douban.com
RUN ln -s /usr/local/python3/bin/jupyter /usr/bin/jupyter

# configured jupyter notebook
RUN useradd notebook
WORKDIR /home/notebook
USER notebook
RUN jupyter notebook --generate-config
RUN mkdir work
RUN echo "c.NotebookApp.ip = '0.0.0.0'" >> .jupyter/jupyter_notebook_config.py
RUN echo "c.NotebookApp.notebook_dir = u'work'" >> .jupyter/jupyter_notebook_config.py

CMD jupyter notebook
