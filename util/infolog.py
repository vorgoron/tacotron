import atexit
from datetime import datetime
import json
from threading import Thread
from urllib.request import Request, urlopen


_format = '%Y-%m-%d %H:%M:%S.%f'
_file = None
_run_name = None
_slack_url = None


def init(filename, run_name, slack_url=None):
  global _file, _run_name, _slack_url
  _close_logfile()
  _file = open(filename, 'a', encoding="utf-8")
  _file.write('\n-----------------------------------------------------------------\n')
  _file.write('Starting new training run\n')
  _file.write('-----------------------------------------------------------------\n')
  _run_name = run_name
  _slack_url = slack_url


def log(msg, slack=False):
  _msg = msg.encode('utf-8')
  print(_msg)
  if _file is not None:
    _file.write('[%s]  %s\n' % (datetime.now().strftime(_format)[:-3], _msg))
  if slack and _slack_url is not None:
    Thread(target=_send_slack, args=(_msg,)).start()


def _close_logfile():
  global _file
  if _file is not None:
    _file.close()
    _file = None


def _send_slack(msg):
  req = Request(_slack_url)
  req.add_header('Content-Type', 'application/json')
  urlopen(req, json.dumps({
    'username': 'tacotron',
    'icon_emoji': ':taco:',
    'text': '*%s*: %s' % (_run_name, msg)
  }).encode())


atexit.register(_close_logfile)
