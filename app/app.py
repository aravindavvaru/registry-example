from flask import Flask
import sys

app = Flask(__name__)

def get_namespace():
    v1 = client.CoreV1Api()
    nameSpaceList = v1.list_namespace()
    for nameSpace in nameSpaceList.items:
        print(nameSpace.metadata.name)

@app.route('/')
def main_root():
    text = "<h2>Hello "
    try:
        text += app.config.get('environment') 
    except:
        print("no enivonment variable passed")
    text += " Kube </h2>" 
    return text

if __name__ == "__main__":
    app.config['environment'] = sys.argv[1]
    app.run(host="0.0.0.0", port=8000)