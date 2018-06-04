import re
from sys import argv
import os
import sys

IGNORE_FOLDERS = ['git']
FILE_EXTENSIONS = ['.pas','.inc','.simba'] 

rootdir = sys.argv[1]
commentregex = re.compile('\(\*.+?\*\)', re.DOTALL)

def getPaths(root): 
    lst = os.listdir(root)
    result = []
    
    for name in lst:
      if os.path.isdir(root+os.sep+name):
        if not name in IGNORE_FOLDERS:
          result.extend(getPaths(root+os.sep+name))
        continue

      _,ext = os.path.splitext(name)
      if ext.lower() in FILE_EXTENSIONS:
        result.append(root+os.sep+name)
    
    return result
  
paths = getPaths(rootdir)
TOC = []

for filename in paths:
    name, ext = os.path.splitext(filename);
    name = os.path.basename(name)
    
    print filename
    TOC.append(name)
    
    with open(filename, 'r') as f:
      contents = f.read()
    
    o = open('source/%s.rst' % name, 'w+')
    res = commentregex.findall(contents)
    for y in res:
        o.write(y[2:][:-2])
    o.close()


index = '''
Welcome to SRL's documentation!
===============================

.. toctree::
   :maxdepth: 2
   :caption: Contents:

'''

for name in TOC:
  print 'Linking '+name
  index += '   '+name+'\n'

index += '''
Indices and tables
==================

* :ref:`genindex`
* :ref:`modindex`
* :ref:`search`
'''

i = open('source/index.rst', 'w+')
i.write(index)
i.close()