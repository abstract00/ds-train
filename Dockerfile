FROM ubuntu:20.04
 
RUN apt-get -y update && apt-get install -y \
	sudo \
	unzip \	
	wget \
	libsm6 \
	libxext6 \
	libxrender-dev \
	libglib2.0-0 \
	libgl1-mesa-dev
 
WORKDIR /opt

RUN wget https://repo.anaconda.com/archive/Anaconda3-2021.05-Linux-x86_64.sh && \
	sh /opt/Anaconda3-2021.05-Linux-x86_64.sh -b -p /opt/anaconda3 && \
	rm -f Anaconda3-2021.05-Linux-x86_64.sh

ENV PATH /opt/anaconda3/bin:$PATH

RUN wget https://moji.or.jp/wp-content/ipafont/IPAexfont/ipaexg00401.zip && \
	unzip ipaexg00401.zip && \
	rm -r -f ipaexg00401.zip && \
	mv ipaexg00401/ipaexg.ttf \
		/opt/anaconda3/lib/python3.8/site-packages/matplotlib/mpl-data/fonts/ttf/ && \
	rm -r -f ipaexg00401

RUN pip install --upgrade pip && \
    pip install opencv-python && \
    pip install nibabel

WORKDIR /work
 
CMD ["jupyter", "lab", "--ip=0.0.0.0", "--allow-root", "--LabApp.token=''"]