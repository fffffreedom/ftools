# golang-env
```
# 如果没有被墙
wget https://dl.google.com/go/go1.8.5.linux-amd64.tar.gz  

tar -C /usr/local/ -xzvf go*.tar.gz

vim ~/.bash_profile

export GOROOT=/usr/local/go1.8.5
export PATH=$PATH:$GOROOT/bin
export GOPATH=$HOME/go

mkdir -p ~/go/src/

cd ~/go/src/
mkdir influxdata
cd ~/go/src/influxdata
git clone https://github.com/influxdata/telegraf.git

```
