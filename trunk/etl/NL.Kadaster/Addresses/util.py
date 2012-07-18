#!/usr/bin/env python
# -*- coding: utf-8 -*-
# Author:Just van den Broecke

import os
import logging
from ConfigParser import ConfigParser
logging.basicConfig(level=logging.INFO,
                     format='%(asctime)s %(name)s %(levelname)s %(message)s')

class Util:
    @staticmethod
    def get_log(name):
        log = logging.getLogger(name)
        log.setLevel(logging.DEBUG)
        return log

log = Util.get_log("Util")

# GDAL/OGR Python Bindings not needed for now...
#import sys
#try:
#    from osgeo import ogr #apt-get install python-gdal
#except ImportError:
#    print("FATAAL: GDAL Python bindings not available, install e.g. with  'apt-get install python-gdal'")
#    sys.exit(-1)

try:
  from lxml import etree
  log.info("running with lxml.etree")
except ImportError:
  try:
    # Python 2.5
    import xml.etree.cElementTree as etree
    log.warning("running with cElementTree on Python 2.5+")
  except ImportError:
    try:
      # Python 2.5
      import xml.etree.ElementTree as etree
      log.warning("running with ElementTree on Python 2.5+")
    except ImportError:
      try:
        # normal cElementTree install
        import cElementTree as etree
        log.warning("running with cElementTree")
      except ImportError:
        try:
          # normal ElementTree install
          import elementtree.ElementTree as etree
          log.warning("running with ElementTree")
        except ImportError:
          log.warning("Failed to import ElementTree from any known place")


try:
    from cStringIO import StringIO
    log.info("running with cStringIO")
except:
    from StringIO import StringIO
    log.warning("running with StringIO (this is suboptimal, try cStringIO")


class ConfigSection():

    def __init__(self, config_section):
        self.config_dict = dict(config_section)

    def get_dict(self):
        return self.config_dict

    def get(self, name, default=None):
        result = self.config_dict[name]
        if result is None:
            result = default
        return result

    def to_string(self):
        return repr(self.config_dict)

class XsltTransformer:
    # Constructor
    def __init__(self, configdict):
        self.cfg = ConfigSection(configdict.items('transformer'))

        self.xslt_file = self.cfg.get('parameters')
        xsltF=open(self.xslt_file, 'r')
        xsltDoc=etree.parse(xsltF)
        self.xslt=etree.XSLT(xsltDoc)
        xsltF.close()

    def transform(self):
        return self.xslt.xslt()
