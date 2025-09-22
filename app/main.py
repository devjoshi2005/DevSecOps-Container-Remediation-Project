from flask import Flask, render_template, request, redirect, url_for

app = Flask(__name__)

@app.route('/')
def index():
    return render_template('index.html')

@app.route('/query', methods=['GET', 'POST'])
def query():
    if request.method == 'POST':
        return redirect(url_for('thankyou'))
    return render_template('query.html')

@app.route('/thankyou')
def thankyou():
    return render_template('thankyou.html')

@app.route('/docs')
def docs():
    return render_template('docs.html')

if __name__ == '__main__':
    app.run(host="0.0.0.0",debug=True)
