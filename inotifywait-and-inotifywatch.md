# inotify

> http://man.linuxde.net/inotifywait

Inotify一种强大的、细粒度的、异步文件系统监控机制，它满足各种各样的文件监控需要，可以监控文件系统的访问属性、读写属性、权限属性、删除创建、移动等操作，
也就是可以监控文件发生的一切变化。

inotify-tools是一个C库和一组命令行的工作提供Linux下inotify的简单接口。inotify-tools安装后会得到inotifywait和inotifywatch这两条命令：

- inotifywait命令可以用来收集有关文件访问信息，Linux发行版一般没有包括这个命令，需要安装inotify-tools，
这个命令还需要将inotify支持编译入Linux内核，好在大多数Linux发行版都在内核中启用了inotify。

- inotifywatch命令用于收集关于被监视的文件系统的统计数据，包括每个 inotify 事件发生多少次。


## inotify相关参数

inotify定义了下列的接口参数，可以用来限制inotify消耗kernel memory的大小。由于这些参数都是内存参数，因此，可以根据应用需求，实时的调节其大小：

- `/proc/sys/fs/inotify/max_queued_evnets`表示调用inotify_init时分配给inotify instance中可排队的event的数目的最大值，
超出这个值的事件被丢弃，但会触发IN_Q_OVERFLOW事件。

- `/proc/sys/fs/inotify/max_user_instances`表示每一个real user id可创建的inotify instatnces的数量上限。

- `/proc/sys/fs/inotify/max_user_watches`表示每个inotify instatnces可监控的最大目录数量。如果监控的文件数目巨大，需要根据情况，适当增加此值的大小。

## 例子
inotify+rsync原理实验详解  
http://blog.csdn.net/xingkong_678/article/details/41046683  
