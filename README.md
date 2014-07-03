mybox
=====

The MYBOX toolset is a developer tool to help to build, manage, custimoze and preversion VMs, It's support VirtualBox now.


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


