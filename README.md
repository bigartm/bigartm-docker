bigartm-docker
==============

### Get the image from DockerHub
```
$ docker pull ofrei/bigartm
```

### Run CLI
```
$ docker run -t -i ofrei/bigartm bigartm
```

### Try Python API
```
$ docker run -t -i ofrei/bigartm ipython2
Python 2.7.6 (default, Jun 22 2015, 17:58:13) 
Type "copyright", "credits" or "license" for more information.

IPython 3.2.1 -- An enhanced Interactive Python.
?         -> Introduction and overview of IPython's features.
%quickref -> Quick reference.
help      -> Python's own help system.
object?   -> Details about 'object', use 'object??' for extra details.

In [1]: import artm

In [2]: model = artm.ARTM()
```
