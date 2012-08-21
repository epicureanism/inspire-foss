#!/usr/bin/env python
# -*- coding: utf-8 -*-
#
# PostGIS support wrapper.
#
# Author: Just van den Broecke
#
from util import Util
log = Util.get_log("postgis")

try:
    import psycopg2
    import psycopg2.extensions
except ImportError:
    log.error("cannot find packages psycopg2 for Postgres client support")
    sys.exit(-1)

class PostGIS:
    def __init__(self, config):
        # Lees de configuratie 
        self.config = config

    def initialiseer(self, bestand):
        log.info('Connecting...')
        self.connect(True)

        log.info('executing sql script...')
        try:
            script = open(bestand, 'r').read()
            self.cursor.execute(script)
            self.connection.commit()
            log.info('script executed')
        except psycopg2.DatabaseError, e:
            log.warn("error '%s' from script '%s'" % (str(e), str(bestand)))

    def connect(self, initdb=False):
        try:
            self.connection = psycopg2.connect("dbname='%s' user='%s' host='%s' password='%s'" % (self.config['database'],
                                                                                                  self.config['user'],
                                                                                                  self.config['host'],
                                                                                                 self.config['password']))
            self.cursor = self.connection.cursor()

            self.zet_schema()
            log.debug("connected to database %s" % (self.config['database']))
        except Exception, e:
            log.warn("cannot connect to database '%s'" % (self.config['database']))

    def maak_schema(self):
        # Public schema: no further action required
        if self.config['schema'] != 'public':
            # A specific schema is required create it and set the search path
            self.uitvoeren('''DROP SCHEMA IF EXISTS %s CASCADE;''' % self.config['schema'])
            self.uitvoeren('''CREATE SCHEMA %s;''' % self.config['schema'])
            self.connection.commit()

    def zet_schema(self):
        # Non-public schema set search path
        if self.config['schema'] != 'public':
            # Always set search path to our schema
            self.uitvoeren('SET search_path TO %s,public' % self.config['schema'])
            self.connection.commit()

    def log_actie(self, actie, bestand="n.v.t", bericht='geen', error=False):
        sql  = "INSERT INTO nlx_bag_log(actie, bestand, error, bericht) VALUES (%s, %s, %s, %s)"
        parameters = (actie, bestand, error, bericht)
        self.tx_uitvoeren(sql, parameters)

    def log_meta(self, sleutel, waarde):
        sql  = "INSERT INTO nlx_bag_info(sleutel, waarde) VALUES (%s, %s)"
        parameters = (sleutel, waarde)
        self.tx_uitvoeren(sql, parameters)

    def make_bytea(self, blob):
        return psycopg2.Binary(blob)

    def uitvoeren(self, sql, parameters=None):
        try:
            if parameters:
                self.cursor.execute(sql, parameters)
            else:
                self.cursor.execute(sql)

            # log.debug(self.cursor.statusmessage)
        except (Exception), e:
            log.warning("error %s in query: %s with params: %s" % (str(e), str(sql), str(parameters))  )
#            self.log_actie("uitvoeren_db", "n.v.t", "fout=%s" % str(e), True)
            raise

        return self.cursor.rowcount

    def file_uitvoeren(self, sqlfile):
        self.e = None
        try:
            log.info("SQL van file = %s uitvoeren..." % sqlfile)
            self.connect()
            f = open(sqlfile, 'r')
            sql = f.read()
            self.uitvoeren(sql)
            self.connection.commit()
            f.close()
            log.info("SQL uitgevoerd OK")
        except (Exception), e:
            self.e = e
            self.log_actie("uitvoeren_db_file", "n.v.t", "fout=%s" % str(e), True)
            log.warn("ik kan dit script niet uitvoeren vanwege deze fout: %s" % (str(e)))

    def tx_uitvoeren(self, sql, parameters=None):
        self.e = None
        try:
            self.connect()
            self.uitvoeren(sql, parameters)
            self.connection.commit()
            self.connection.close()

            # log.debug(self.cursor.statusmessage)
        except (Exception), e:
            self.e = e
            log.warning("error %s in transaction: %s with parms: %s" % (str(e), str(sql), str(parameters))  )

        return self.cursor.rowcount