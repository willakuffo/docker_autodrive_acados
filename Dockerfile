FROM autodriveecosystem/autodrive_f1tenth_api:2024-cdc-practice

RUN git clone https://github.com/acados/acados.git
WORKDIR acados 
RUN git submodule update --recursive --init 

RUN apt-get update && apt-get install -y cmake

RUN  mkdir -p build
WORKDIR build 
RUN  cmake -DACADOS_WITH_QPOASES=ON .. 
RUN  make install -j4

WORKDIR ../.. 
RUN   pip install -e acados/interfaces/acados_template  
RUN echo 'export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:"/home/autodrive_devkit/acados/lib"' >> ~/.bashrc
RUN echo 'export ACADOS_SOURCE_DIR="/home/autodrive_devkit/acados"' >> ~/.bashrc



WORKDIR /home/autodrive_devkit/acados/bin
RUN curl -L https://github.com/acados/tera_renderer/releases/download/v0.0.34/t_renderer-v0.0.34-linux -o t_renderer
RUN chmod +x t_renderer

WORKDIR /home/autodrive_devkit


#CMD [ "/bin/bash","source ~/.bashrc" ]
