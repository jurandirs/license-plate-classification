#!/usr/bin/python
import requests
import base64
import json
import cv2
import time


# ****************************************************************************
# Links:
# http://doc.openalpr.com/api.html
# https://stackoverflow.com/questions/33311153/python-extracting-and-saving-video-frames
# https://pythonexamples.org/python-opencv-cv2-capture-video-from-camera/
# ****************************************************************************

def capture():
    cap = cv2.VideoCapture(0)
    global picnameformat
    picname = picnameformat.format(time.ctime())
    ret, frame = cap.read()
    cv2.imwrite(picname, frame)
    cv2.destroyAllWindows()
    del cap
    return picname

def run_alpr(picname):
    # Sample image file is available at http://plates.openalpr.com/ea7the.jpg
    IMAGE_PATH = picname
    SECRET_KEY = 'sk_DEMODEMODEMODEMODEMODEMO'
    # SECRET_KEY = 'sk_520e537c555e14637bdc8e0d'

    with open(IMAGE_PATH, 'rb') as image_file:
        img_base64 = base64.b64encode(image_file.read())

    url = 'https://api.openalpr.com/v2/recognize_bytes?recognize_vehicle=1&country=br&secret_key=%s' % (SECRET_KEY)
    r = requests.post(url, data = img_base64)

    r_dict = r.json()

    if len(r_dict['results']) > 0:
        print('...')
        plate = r_dict['results'][0]['plate']
        color = r_dict['results'][0]['vehicle']['color'][0]['name']
        make_model = r_dict['results'][0]['vehicle']['make_model'][0]['name'].replace('_',': ')
        year = r_dict['results'][0]['vehicle']['year'][0]['name']
        infos = '{} \n{} \n{} \n{}\n'.format(plate, make_model, year, color)
        print(infos)
        return infos
        # print(json.dumps(r.json(), indent=2))
    else:
        return None

def send(infos):
    # r = requests.get('https://so-si.herokuapp.com/placa/AAA1122')
    r = requests.get('https://so-si.herokuapp.com/placa/{}'.format(infos))
    # print(r.json)

if __name__=='__main__':
    picnameformat = 'capturies/frame_{}.jpeg'

    while True:
        picname = capture()
        infos = run_alpr(picname)
        if infos is not None:
            send(infos)
        time.sleep(3)
        # break