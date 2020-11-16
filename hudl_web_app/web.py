# Importing libraries that we would use from Flask and Python

from flask import Flask, request, render_template
import urllib, hashlib, os

app = Flask(__name__)

# a route where we will display a welcome form via an HTML template

@app.route("/")
def home():
    return render_template('index.html')
     
# a route where we translate user email from the welcome form to gavatar URL
@app.route("/avatar", methods=['GET', 'POST'])
def avatar():

    if request.method == 'POST':
        avatar = request.form.get('email')
        avatar = avatar.encode('utf-8')
        gravatar_url = "https://www.gravatar.com/avatar/" + hashlib.md5(avatar.lower()).hexdigest()

        return render_template('avatar.html', name=gravatar_url)

# a route to reply to GET /avatar/email request
@app.route("/avatar/<email>/")
def greet(email):

    msg = f'{email}'
    msg = msg.encode('utf-8')
    gravatar_url = "https://www.gravatar.com/avatar/" + hashlib.md5(msg.lower()).hexdigest()

    return render_template('avatar.html', name=gravatar_url)
    
  
if __name__ == "__main__": 
    app.run(host ='0.0.0.0', port = 5000, debug = True)
