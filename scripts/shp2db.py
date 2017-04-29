# -*- coding: utf-8 -*-
import psycopg2
import os
import traceback
import sys
import ConfigParser
from PyQt4 import QtGui, QtCore
import logging as log
import glob
import ogr
import osr
os.environ['PGCLIENTENCODING'] = 'UTF8'
os.environ['SHAPE_ENCODING'] = 'SJIS'


def get_path(path):
    dir_path = os.path.abspath('./')
    target = os.path.abspath(os.path.join(dir_path, path))
    if not os.path.isdir(target):
        target = os.path.abspath(path)
    return target


class txtToPostgres(object):
    def __init__(self):
        self.connecter = None
        self.cursor = None
        self.error_flag = None
        log.basicConfig(
            level=log.DEBUG,
            filename='./error_log.txt',
            format=u'%(asctime)s %(levelname)s %(message)s')

    def db_connect(self, name, user, host, password, port):
        try:
            self.connect_txt = 'dbname={0} host={1} user={2} password={3} port={4}'.format(
                name, host, user, password, port)
            self.connecter = psycopg2.connect(self.connect_txt)
            self.cursor = self.connecter.cursor()
        except:
            print self.connect_txt
            QtGui.QMessageBox.information(QtGui.QDialog(),
                                          'shp2db',
                                          'db can not connect')
            sys.exit()

    def db_disconnect(self):
        self.connecter.commit()
        self.cursor.close()
        self.connecter.close()

    def get_layer(self, driver_name, file_name):
        driver = ogr.GetDriverByName(driver_name)
        data_source = driver.Open(file_name, 0)
        layer = data_source.GetLayer()
        return layer

    def shp2db(self, shp_name):
        srs = osr.SpatialReference()
        srs.ImportFromEPSG(2447)

        shp_layer = self.get_layer('ESRI Shapefile', shp_name)
        ogr_connect = ogr.Open('PG: {}'.format(self.connect_txt))
        db_layer = ogr_connect.CreateLayer(shp_layer.GetName(),
                                           shp_layer.GetGeomType())

        db_layer.StartTransaction()
        for i in range(shp_layer.GetFeatureCount()):
            feature = shp_layer.GetFeature(i)
            db_layer.CreateFeature(feature)
        db_layer.CommitTransaction()

if __name__ == '__main__':
    app = QtGui.QApplication(sys.argv)
    config = ConfigParser.SafeConfigParser()
    config_file = 'config.ini'
    if not os.path.isfile(config_file):
        QtGui.QMessageBox.information(QtGui.QDialog(), 'shp2db',
                                      'no find config file')
        sys.exit()
    print 'load config'
    config.read(config_file)
    db_host = config.get('db_connect', 'host_name')
    db_name = config.get('db_connect', 'db_name')
    db_user = config.get('db_connect', 'db_user_name')
    db_password = config.get('db_connect', 'db_password')
    db_port = config.get('db_connect', 'db_port')

    shp_dir = './'
    shp_files = [glob.glob(os.path.join(shp_dir, '*.shp'))]

    if not shp_files:
        QtGui.QMessageBox.information(QtGui.QDialog(),
                                      'shp2db',
                                      'please select table')
        sys.exit()

    convert = txtToPostgres()
    convert.db_connect(db_name, db_user, db_host, db_password, db_port)

    for shp in shp_files:
        convert.shp2db(shp)
    convert.db_disconnect()

    if convert.error_flag is None:
        QtGui.QMessageBox.information(QtGui.QDialog(), 'shp2db',
                                      'exit')
    else:
        QtGui.QMessageBox.information(QtGui.QDialog(), 'shp2db',
                                      'output_shp get error\n watch error_log')
    sys.exit()
