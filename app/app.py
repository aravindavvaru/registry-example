import sys
from flask import Flask
import argparse

app = Flask(__name__)

def get_env(arg_env):
    global curr_env
    curr_env = arg_env

@app.route('/')
def main_root():
    text = "<h2>Hello " + curr_env + " Kube</h2>"
    return text 
if __name__ == '__main__':
    parser = argparse.ArgumentParser(description='Description of your program')
    parser.add_argument('-e','--environ', help='environment value', required=False)
    args = vars(parser.parse_args())
    if len(sys.argv) > 1 :
        arg_env = args['environ']
    else:
        arg_env = ""
    get_env(arg_env)
    app.run(host="0.0.0.0", port=8000)