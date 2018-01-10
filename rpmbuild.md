reference to: 
http://blog.csdn.net/skdkjzz/article/details/41753379

and spec tools: 
https://github.com/linuxlefty/tar2rpm

```
# 安装软件
yum install -y rpm-build rpmdevtools

# 生成build目录
rpmdev-setuptree

# 下载生成rpmbuild所需要的spec的脚本
git clone https://github.com/linuxlefty/tar2rpm.git

# 下载rpm包，并解压，获取配置文件
rpm2cpio xxx.rpm | cpio -div

# 将修改源码后，编译好的二进制文件替换解压出来的二进制文件
# 再打包好，拷贝到rpmbuild/SOURCES目录下
# 拷贝tar2rpm.sh到rpmbuild/SPECS目录下，并生成所需要的spec
# 例如：
./tar2rpm.sh ../SOURCES/telegraf-ceph.tar --target / --print > telegraf.spec
# 对生成的spec做相应的修改
# 最后编译：
rpmbuild -bb telegraf.spec
```
