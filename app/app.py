from flask import Flask
from kubernetes import client, config

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
        text += get_namespace() 
    except:
        print("not running in kubernetes")
    text += " Kube </h2>" 
    return text

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=8000)