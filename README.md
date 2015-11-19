Vagrant Bootstrap Tool
===================================

Simple interactive guide script which crete new Vagrant bootstrap project.

Features
--------

You can customize these Vagrant parameters:

+ chose Vagrant box from [prepared boxes by Packer](https://github.com/tomaskubat/packer-templates)
+ number of vCPUs cores
+ amount of RAM Memory
+ Vagrant box name
+ enable/disable Virtualbox GUI

Requirements
------------

- bash (>= 3.0)

Usage
------------------------------
Creating new Vagrant Bootstrap:

```
$ ./create-project.sh
```

Your new Boostrap for Vagrant project will appear at directory `new-project`.

You should rename this folder a move it to your project directory. 