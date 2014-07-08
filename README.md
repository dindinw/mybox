MYBOX
=====

The MYBOX toolset is command-line tool to help developer to build, manage, custimoze and preversion VMs, It provide both of file deployment way like [Vagrant][1], and fine-grained control commands to the single VM. 

It's support Oralce VirtualBox for local virtualization provider now. It will support VMware vSphere and OpenStack in the future version.

The MYBOX toolset is very similar to [Vagrant][1]. Actually The idear of MYBOX is just learn from the Vagarnt. So why we need another tool if here is vagrant already? 

One simple answer to the question is : It's just for fun. I create the tool as my owned version of Vagrant to satisfy my little desire of controling :-)

Another more serious answer is , I would like that:

  *  **It should be small in size**

  MYBOX is very light-weight, the main part is just a single BASH script. The size is just 100KB+ (Although in Windows Platform, the package is 11MB+, most because some mingw binary is shipped, such as bash, sed, awk etc.)

  *  **It should provide more fine-grained commmand-lines**

  The Vagrant is very good on discribe your deployemnt of VMs in a single config file ([_Vagrantfile_][2]), and share the file to re-build a entrire same enviorment for developer. the Idea is just awesome! But I would like to add some more fine-grained control under single Node/VM in a programming-friendly way, so that user can control his or her own Nodes/VMs either by a config file or by command line directly.

  *  **The VMware and OpenStack should be supported (free:-))**

  It seems that The Vagrant's [vmware provider][3] is need to pay a license. Unfortunately, I readly want the Vagrant-like mechanics can also work for vsphere. and even-more, the OpenStack. (The support of Vmware and Openstack will be consider in MYBOX V2. becuase I would like to rewrite the MYBOX V2 by using an higher level language than BASH.)


[1]:http://www.vagrantup.com
[2]:https://docs.vagrantup.com/v2/vagrantfile/
[3]:https://www.vagrantup.com/vmware#learn-more

Usage
-----

~~~
Usage: mybox.sh [-v] [-h] command [<args>]

    -v, --version           Print the version and exit.
    -h, --help              Print this help.

User subcommands : The commands target for the MYBOX environment which defined
                   by a Mybox configration file. ".boxconfig"  by default.
    init           initializes a new MYBOX environment by creating a ".boxconfig"
    config         show/edit the MYBOX environment by ".boxconfig"
    up             starts and provisions the MYBOX environment by ".boxconfig"
    down           stops the MYBOX nodes in the MYBOX environment.
    clean          stops and deletes all MYBOX nodes in the MYBOX environment.
    provision      provisions the MYBOX nodes
    ssh            connects to node via SSH
    status         show status of the MYBOX nodes in the MYBOX environment
    box            manages MYBOX boxes.

For help on any individual command run "mybox.sh COMMAND -h"
~~~


More fine-grained command to handle MYBOX node and VMs

~~~
C:\test-mybox>mybox -H
MYBOX Internal Commands help
    -H                      Print this help (more internal commands).
    -T command [<args]      report the elapsed time.

Box subcommands : The commads to manage MYBOX boxes.
    box add           download a pre-build box into user's local box repository
    box list          list boxes in user's local box repository.
    box detail        show a box's detail.
    box remove        remove a box from user's local box repository
    box pkgvbox       create a box from VirtualBox VM
    box impvbox       import a box into VirtualBox VM

Node subcommands : The commands to manage MYBOX nodes.
    node list         list MYBOX nodes in the MYBOX environment
    node import       import a MYBOX Box as a MYBox node
    node start        start a MYBOX node by node name
    node stop         stop a MYBOX node by node name
    node remove       remove a MYBOX node from the MYBOX environment
    node provision    pervision on a MYBOX node.
    node ssh          connects to a MYBOX node.
    node info         show detail information of a MYBOX node.

VBOX subcommands : The commands to manage VirtualBox VM
    vbox list         list user's VirtualBox environment
    vbox start        start a VirtualBox VM.
    vbox stop         stop a VirtualBox VM.
    vbox modify       modify a VirtualBox VM
    vbox remove       remove a VM from the User's VirtualBox environment
    vbox ssh          connects to a VirtualBox VM.
    vbox ssh-setup    setup geust ssh to a VirtualBox VM.
    vbox info         show detail information of a VirtualBox VM.
    vbox migrate      migrate a Vagrant VM into a MYBOX VM.
    vbox status       show the vm state (on/off) of a VirtualBox VM.


!!! NOTE: Some Node/VM command is for internal test only. please use carefully
    improperly usage may result a corrupted  MYBOX environment.
For help on any individual command run "mybox.sh COMMAND -h"
~~~

Cook Book
---------

### Set up MYBOX Enviorment

~~~
C:\>mkdir test2

C:\>cd test2

C:\test2>mybox init
Init a box config under /c/test2/.boxconfig successfully!

C:\test2>cat .boxconfig
'cat' is not recognized as an internal or external command,
operable program or batch file.

C:\test2>type .boxconfig
# MYBOX box config file
[box]
    box.name=Trusty64
    vbox.modify.memory=512
# node
[node 1 ]
    node.provision=<<INLINE_SCRIPT
        echo "exected provision script in $(hostname)"
    INLINE_SCRIPT
~~~

### Config .boxconfig

~~~
C:\test-mybox>mybox config -p
# MYBOX box config file
[box]
    box.name="Trusty64"
    vbox.modify.memory="512"
# node
[node 1 ]
    node.name="master"
    vbox.modify.nictype1="82540EM"
    node.provision="c:\test.sh"

[node 2 ]
    box.name="REHL64"
    vbox.modify.memory="1024"

[node 3 ]
    box.name="CentOS65-64"
    node.provision="<<INLINE_SCRIPT"
echo "exected provision script in $(hostname)"
INLINE_SCRIPT
[node 4 ]
    box.name="precise64"
    vbox.modify.memory="1024"

C:\test-mybox>mybox config -a node 2 box.name precise32

C:\test-mybox>mybox config -p
# MYBOX box config file
[box]
    box.name="Trusty64"
    vbox.modify.memory="512"
# node
[node 1 ]
    node.name="master"
    vbox.modify.nictype1="82540EM"
    node.provision="c:\test.sh"

[node 2 ]
    box.name="precise32"
    vbox.modify.memory="1024"

[node 3 ]
    box.name="CentOS65-64"
    node.provision="<<INLINE_SCRIPT"
echo "exected provision script in $(hostname)"
INLINE_SCRIPT
[node 4 ]
    box.name="precise64"
    vbox.modify.memory="1024"

~~~

### Add a Box 

~~~
$ mybox.sh box add https://files.vagrantup.com/lucid32.box
Downloading hTTps://files.vagrantup.com/lucid32.box ...
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100    71  100    71    0     0     51      0  0:00:01  0:00:01 --:--:--    51
  0  249M    0   843    0     0    353      0   8d 13h  0:00:02   8d 13h   353
~~~


### Box Managment

~~~
C:\test-mybox>mybox box list
CentOS65-64
precise32
precise64
RHEL64
test
Trusty64
wheezy32

C:\test-mybox>mybox box list -d

=====================================================================
BOX NAME: CentOS65-64
---------------------------------------------------------------------
    <vbox:Machine ovf:required="false" version="1.12-windows" uuid="{20a93e66-af31-47eb-9642-4b02254fb80b}" name="centos
65-x86_64" OSType="RedHat_64" snapshotFolder="Snapshots" lastStateChange="2014-06-25T04:56:39Z">
    </vbox:Machine>

=====================================================================
BOX NAME: precise32
---------------------------------------------------------------------
    <vbox:Machine ovf:required="false" version="1.12-macosx" uuid="{1e7b4e32-2093-4b4c-955c-9418499319d3}" name="precise
32" OSType="Ubuntu" snapshotFolder="Snapshots" lastStateChange="2012-09-14T06:22:32Z">
    </vbox:Machine>

=====================================================================
BOX NAME: precise64
---------------------------------------------------------------------
    <vbox:Machine ovf:required="false" version="1.12-macosx" uuid="{25bf6e0f-cbf2-4395-b083-0179d05f521b}" name="precise
64" OSType="Ubuntu_64" snapshotFolder="Snapshots" lastStateChange="2012-09-14T06:23:19Z">
    </vbox:Machine>

=====================================================================
BOX NAME: RHEL64
---------------------------------------------------------------------
    <vbox:Machine ovf:required="false" version="1.12-windows" uuid="{15f8ac61-f851-4b50-a3ac-cd7a92357404}" name="RHEL-6
.4-x86_64 (rdo-release-havana7)" OSType="RedHat_64" snapshotFolder="Snapshots" lastStateChange="2014-01-29T06:23:16Z">
    </vbox:Machine>

=====================================================================
BOX NAME: test
---------------------------------------------------------------------
    <vbox:Machine ovf:required="false" version="1.12-macosx" uuid="{1e7b4e32-2093-4b4c-955c-9418499319d3}" name="precise
32" OSType="Ubuntu" snapshotFolder="Snapshots" lastStateChange="2012-09-14T06:22:32Z">
    </vbox:Machine>

=====================================================================
BOX NAME: Trusty64
---------------------------------------------------------------------
    <vbox:Machine ovf:required="false" version="1.12-windows" uuid="{f4eb14ab-afaa-430f-ae6d-bb4aefe0fe27}" name="ubuntu
-14.04-server-amd64" OSType="Ubuntu_64" snapshotFolder="Snapshots" lastStateChange="2014-06-23T09:39:13Z">
    </vbox:Machine>

=====================================================================
BOX NAME: wheezy32
---------------------------------------------------------------------
    <vbox:Machine ovf:required="false" version="1.12-macosx" uuid="{4eff4fc6-2d19-41ca-9e9d-80b4e0e8a302}" name="vagrant
-wheezy" OSType="Debian" snapshotFolder="Snapshots" lastStateChange="2013-10-24T16:47:34Z">
    </vbox:Machine>
~~~


### MYBOX UP

~~~
C:\test-mybox>mybox up

UP MYBOX environment by using ".boxconfig" ...
The base box name is Trusty64 , memory is

Try to start MYBOX Node [ 1 ] : master, box=Trusty64, provider=vbox ...
0%...10%...20%...30%...40%...50%...60%...70%...80%...90%...100%
Interpreting d:\Boxes\Trusty64\Trusty64.ovf...
OK.
0%...10%...20%...30%...40%...50%...60%...70%...80%...90%...100%
Import "Trusty64" to MYBOX Node "master" under VBOX VM "mybox_master_d60c9d61-ffc4-4abc-95d6-b33b99fca994" successfully!


Try to provision MYBOX Node [ 1 ] : master ...
Preparing provision MYBOX Node "master" ...
test.sh                                                                               100%   18     0.0KB/s   00:00
Do the provision of MYBOX Node "master" ...
Welcome to Ubuntu 14.04 LTS (GNU/Linux 3.13.0-24-generic x86_64)

 * Documentation:  https://help.ubuntu.com/
mybox-ubuntu-precise
eth0      Link encap:Ethernet  HWaddr 08:00:27:c0:2d:c5
          inet addr:10.0.2.15  Bcast:10.0.2.255  Mask:255.255.255.0
          inet6 addr: fe80::a00:27ff:fec0:2dc5/64 Scope:Link
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:111 errors:0 dropped:0 overruns:0 frame:0
          TX packets:88 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:1000
          RX bytes:20472 (20.4 KB)  TX bytes:14536 (14.5 KB)

lo        Link encap:Local Loopback
          inet addr:127.0.0.1  Mask:255.0.0.0
          inet6 addr: ::1/128 Scope:Host
          UP LOOPBACK RUNNING  MTU:65536  Metric:1
          RX packets:0 errors:0 dropped:0 overruns:0 frame:0
          TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:0
          RX bytes:0 (0.0 B)  TX bytes:0 (0.0 B)

Provision MYBOX Node "master" done successfully!
Start MYBOX Node "master" with VBOX vm_id {9e819f31-2cd0-4a65-8fe4-d5924f0abc74} ...
MYBOX Node "master" started successfully!

Try to start MYBOX Node [ 2 ] : node2, box=precise32, provider=vbox ...
0%...10%...20%...30%...40%...50%...60%...70%...80%...90%...100%
Interpreting d:\Boxes\precise32\box.ovf...
OK.
0%...10%...20%...30%...40%...50%...60%...70%...80%...90%...100%
Setup ssh service to VM "mybox_node2_0055550a-2550-4050-956f-cbfa7560a1a0" ...
VBOX VM "mybox_node2_0055550a-2550-4050-956f-cbfa7560a1a0" neet to be started...
Try to start VBox VM "mybox_node2_0055550a-2550-4050-956f-cbfa7560a1a0" in "headless" mode ...
Waiting for VM "mybox_node2_0055550a-2550-4050-956f-cbfa7560a1a0" to power on...
VM "mybox_node2_0055550a-2550-4050-956f-cbfa7560a1a0" has been successfully started.
Checking if "mybox_node2_0055550a-2550-4050-956f-cbfa7560a1a0" is a Vagrant VM ...
vagrant
Vagrent VM check OK, try to do migration ...
_migrate_to_mybox_script.sh                                                           100%  821     0.8KB/s   00:00
VBOX VM "mybox_node2_0055550a-2550-4050-956f-cbfa7560a1a0" migrate to MYBOX VM OK!
.
Remove guest ssh service to VM "mybox_node2_0055550a-2550-4050-956f-cbfa7560a1a0" ...
Import "precise32" to MYBOX Node "node2" under VBOX VM "mybox_node2_0055550a-2550-4050-956f-cbfa7560a1a0" successfully!

Try to provision MYBOX Node [ 2 ] : node2 ...
No provision task found. passed-by.
Start MYBOX Node "node2" with VBOX vm_id {58d6a343-ee20-4201-b68f-f76519b6329f} ...
Try to start VBox VM "58d6a343-ee20-4201-b68f-f76519b6329f" in "headless" mode ...
Waiting for VM "58d6a343-ee20-4201-b68f-f76519b6329f" to power on...
VM "58d6a343-ee20-4201-b68f-f76519b6329f" has been successfully started.

MYBOX Node "node2" started OK!
MYBOX Node "node2" started successfully!

Try to start MYBOX Node [ 3 ] : node3, box=CentOS65-64, provider=vbox ...
0%...10%...20%...30%...40%...50%...60%...70%...80%...90%...100%
Interpreting d:\Boxes\CentOS65-64\CentOS65-64.ovf...
OK.
0%...10%...20%...30%...40%...50%...60%...70%...80%...90%...100%
Import "CentOS65-64" to MYBOX Node "node3" under VBOX VM "mybox_node3_fe419e0c-b130-434e-95a9-cf4c9f5845e2" successfully
!

Try to provision MYBOX Node [ 3 ] : node3 ...
Preparing provision MYBOX Node "node3" ...
mybox_inline_provision_script.sh                                                      100%   55     0.1KB/s   00:00
Do the provision of MYBOX Node "node3" ...
exected provision script in mybox-centos65.mybox.com
Provision MYBOX Node "node3" done successfully!
Start MYBOX Node "node3" with VBOX vm_id {d243f384-8191-4428-a614-e7beb7a97dc9} ...
MYBOX Node "node3" started successfully!

Try to start MYBOX Node [ 4 ] : node4, box=precise64, provider=vbox ...
0%...10%...20%...30%...40%...50%...60%...70%...80%...90%...100%
Interpreting d:\Boxes\precise64\box.ovf...
OK.
0%...10%...20%...30%...40%...50%...60%...70%...80%...90%...100%
Setup ssh service to VM "mybox_node4_c9c1e937-7640-433d-ace0-f898ece62c26" ...
VBOX VM "mybox_node4_c9c1e937-7640-433d-ace0-f898ece62c26" neet to be started...
Try to start VBox VM "mybox_node4_c9c1e937-7640-433d-ace0-f898ece62c26" in "headless" mode ...
Waiting for VM "mybox_node4_c9c1e937-7640-433d-ace0-f898ece62c26" to power on...
VM "mybox_node4_c9c1e937-7640-433d-ace0-f898ece62c26" has been successfully started.
Checking if "mybox_node4_c9c1e937-7640-433d-ace0-f898ece62c26" is a Vagrant VM ...
vagrant
Vagrent VM check OK, try to do migration ...
_migrate_to_mybox_script.sh                                                           100%  821     0.8KB/s   00:00
VBOX VM "mybox_node4_c9c1e937-7640-433d-ace0-f898ece62c26" migrate to MYBOX VM OK!
.
Remove guest ssh service to VM "mybox_node4_c9c1e937-7640-433d-ace0-f898ece62c26" ...
Import "precise64" to MYBOX Node "node4" under VBOX VM "mybox_node4_c9c1e937-7640-433d-ace0-f898ece62c26" successfully!

Try to provision MYBOX Node [ 4 ] : node4 ...
No provision task found. passed-by.
Start MYBOX Node "node4" with VBOX vm_id {4ef683be-fa96-4d90-918e-f6b7775ac848} ...
Try to start VBox VM "4ef683be-fa96-4d90-918e-f6b7775ac848" in "headless" mode ...
Waiting for VM "4ef683be-fa96-4d90-918e-f6b7775ac848" to power on...
VM "4ef683be-fa96-4d90-918e-f6b7775ac848" has been successfully started.

MYBOX Node "node4" started OK!
MYBOX Node "node4" started successfully!
~~~

### Provision

### SSH
~~~
C:\test-mybox>mybox ssh
1) master
2) node2
3) node3
4) node4
Type a number or 'q' to quit: 1
Welcome to Ubuntu 14.04 LTS (GNU/Linux 3.13.0-24-generic x86_64)

 * Documentation:  https://help.ubuntu.com/
mybox@mybox-ubuntu-precise:~$ cat /etc/lsb-release
DISTRIB_ID=Ubuntu
DISTRIB_RELEASE=14.04
DISTRIB_CODENAME=trusty
DISTRIB_DESCRIPTION="Ubuntu 14.04 LTS"
mybox@mybox-ubuntu-precise:~$ exit
logout

C:\test-mybox>mybox ssh
1) master
2) node2
3) node3
4) node4
Type a number or 'q' to quit: 2
Stopping VBOX VM "58d6a343-ee20-4201-b68f-f76519b6329f" ...
0%...10%...20%...30%...40%...50%...60%...70%...80%...90%...100%
VM "58d6a343-ee20-4201-b68f-f76519b6329f" has been successfully stopped.
Setup ssh service to VM "58d6a343-ee20-4201-b68f-f76519b6329f" ...
Try to start VBox VM "58d6a343-ee20-4201-b68f-f76519b6329f" in "headless" mode ...
Waiting for VM "58d6a343-ee20-4201-b68f-f76519b6329f" to power on...
VM "58d6a343-ee20-4201-b68f-f76519b6329f" has been successfully started.

Welcome to Ubuntu 12.04 LTS (GNU/Linux 3.2.0-23-generic-pae i686)

 * Documentation:  https://help.ubuntu.com/
Welcome to your Vagrant-built virtual machine.

The programs included with the Ubuntu system are free software;
the exact distribution terms for each program are described in the
individual files in /usr/share/doc/*/copyright.

Ubuntu comes with ABSOLUTELY NO WARRANTY, to the extent permitted by
applicable law.

To run a command as administrator (user "root"), use "sudo <command>".
See "man sudo_root" for details.

mybox@precise32:~$ cat /etc/lsb-release
DISTRIB_ID=Ubuntu
DISTRIB_RELEASE=12.04
DISTRIB_CODENAME=precise
DISTRIB_DESCRIPTION="Ubuntu 12.04 LTS"
mybox@precise32:~$ exit
logout

C:\test-mybox>mybox ssh node3
[mybox@mybox-centos65 ~]$ cat /etc/re
redhat-release    request-key.conf  request-key.d/    resolv.conf
[mybox@mybox-centos65 ~]$ cat /etc/re
redhat-release    request-key.conf  request-key.d/    resolv.conf
[mybox@mybox-centos65 ~]$ cat /etc/redhat-release
CentOS release 6.5 (Final)
[mybox@mybox-centos65 ~]$ exit
logout

C:\test-mybox>mybox ssh node4
Stopping VBOX VM "4ef683be-fa96-4d90-918e-f6b7775ac848" ...
0%...10%...20%...30%...40%...50%...60%...70%...80%...90%...100%
VM "4ef683be-fa96-4d90-918e-f6b7775ac848" has been successfully stopped.
Setup ssh service to VM "4ef683be-fa96-4d90-918e-f6b7775ac848" ...
Try to start VBox VM "4ef683be-fa96-4d90-918e-f6b7775ac848" in "headless" mode ...
Waiting for VM "4ef683be-fa96-4d90-918e-f6b7775ac848" to power on...
VM "4ef683be-fa96-4d90-918e-f6b7775ac848" has been successfully started.

Welcome to Ubuntu 12.04 LTS (GNU/Linux 3.2.0-23-generic x86_64)

 * Documentation:  https://help.ubuntu.com/
Welcome to your Vagrant-built virtual machine.

The programs included with the Ubuntu system are free software;
the exact distribution terms for each program are described in the
individual files in /usr/share/doc/*/copyright.

Ubuntu comes with ABSOLUTELY NO WARRANTY, to the extent permitted by
applicable law.

To run a command as administrator (user "root"), use "sudo <command>".
See "man sudo_root" for details.

mybox@precise64:~$ cat /etc/lsb-release
DISTRIB_ID=Ubuntu
DISTRIB_RELEASE=12.04
DISTRIB_CODENAME=precise
DISTRIB_DESCRIPTION="Ubuntu 12.04 LTS"
mybox@precise64:~$ uname -a
Linux precise64 3.2.0-23-generic #36-Ubuntu SMP Tue Apr 10 20:39:51 UTC 2012 x86_64 x86_64 x86_64 GNU/Linux
mybox@precise64:~$ exit
logout

C:\test-mybox>mybox ssh node2
Welcome to Ubuntu 12.04 LTS (GNU/Linux 3.2.0-23-generic-pae i686)

 * Documentation:  https://help.ubuntu.com/
Welcome to your Vagrant-built virtual machine.
Last login: Mon Jul  7 10:16:49 2014 from 10.0.2.2
To run a command as administrator (user "root"), use "sudo <command>".
See "man sudo_root" for details.

mybox@precise32:~$ uname -a
Linux precise32 3.2.0-23-generic-pae #36-Ubuntu SMP Tue Apr 10 22:19:09 UTC 2012 i686 i686 i386 GNU/Linux
mybox@precise32:~$ cat /etc/lsb-release
DISTRIB_ID=Ubuntu
DISTRIB_RELEASE=12.04
DISTRIB_CODENAME=precise
DISTRIB_DESCRIPTION="Ubuntu 12.04 LTS"
~~~


### CleanUP

~~~
C:\test-mybox>mybox clean -f
Removing MYBOX Node "master" with VBOX VM "{9e819f31-2cd0-4a65-8fe4-d5924f0abc74}" ...
stop VBOX VM "9e819f31-2cd0-4a65-8fe4-d5924f0abc74" ...
Stopping VBOX VM "9e819f31-2cd0-4a65-8fe4-d5924f0abc74" ...
0%...10%...20%...30%...40%...50%...60%...70%...80%...90%...100%
VM "9e819f31-2cd0-4a65-8fe4-d5924f0abc74" has been successfully stopped.
Delete VBOX VM "9e819f31-2cd0-4a65-8fe4-d5924f0abc74" ...
0%...10%...20%...30%...40%...50%...60%...70%...80%...90%...100%
VM "9e819f31-2cd0-4a65-8fe4-d5924f0abc74" has been successfully deleted.
Removing MYBOX Node "master" done!
Removing MYBOX Node "node2" with VBOX VM "{58d6a343-ee20-4201-b68f-f76519b6329f}" ...
stop VBOX VM "58d6a343-ee20-4201-b68f-f76519b6329f" ...
Stopping VBOX VM "58d6a343-ee20-4201-b68f-f76519b6329f" ...
0%...10%...20%...30%...40%...50%...60%...70%...80%...90%...100%
VM "58d6a343-ee20-4201-b68f-f76519b6329f" has been successfully stopped.
Delete VBOX VM "58d6a343-ee20-4201-b68f-f76519b6329f" ...
0%...10%...20%...30%...40%...50%...60%...70%...80%...90%...100%
VM "58d6a343-ee20-4201-b68f-f76519b6329f" has been successfully deleted.
Removing MYBOX Node "node2" done!
Removing MYBOX Node "node3" with VBOX VM "{d243f384-8191-4428-a614-e7beb7a97dc9}" ...
stop VBOX VM "d243f384-8191-4428-a614-e7beb7a97dc9" ...
Stopping VBOX VM "d243f384-8191-4428-a614-e7beb7a97dc9" ...
0%...10%...20%...30%...40%...50%...60%...70%...80%...90%...100%
VM "d243f384-8191-4428-a614-e7beb7a97dc9" has been successfully stopped.
Delete VBOX VM "d243f384-8191-4428-a614-e7beb7a97dc9" ...
0%...10%...20%...30%...40%...50%...60%...70%...80%...90%...100%
VM "d243f384-8191-4428-a614-e7beb7a97dc9" has been successfully deleted.
Removing MYBOX Node "node3" done!
Removing MYBOX Node "node4" with VBOX VM "{4ef683be-fa96-4d90-918e-f6b7775ac848}" ...
stop VBOX VM "4ef683be-fa96-4d90-918e-f6b7775ac848" ...
Stopping VBOX VM "4ef683be-fa96-4d90-918e-f6b7775ac848" ...
0%...10%...20%...30%...40%...50%...60%...70%...80%...90%...100%
VM "4ef683be-fa96-4d90-918e-f6b7775ac848" has been successfully stopped.
Delete VBOX VM "4ef683be-fa96-4d90-918e-f6b7775ac848" ...
0%...10%...20%...30%...40%...50%...60%...70%...80%...90%...100%
VM "4ef683be-fa96-4d90-918e-f6b7775ac848" has been successfully deleted.
Removing MYBOX Node "node4" done!
~~~


