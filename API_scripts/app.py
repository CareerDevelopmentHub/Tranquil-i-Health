from flask import Flask, request, jsonify
from google.cloud import language_v1
 
app = Flask(__name__)  
  
@app.route('/')      
def hello():
    return 'HELLO'

@app.route('/sen')
def sample_analyze_sentiment():
    content = request.args.get('content')
    client = language_v1.LanguageServiceClient()
    # content = 'Your text to analyze, e.g. Hello, world!'
    if isinstance(content, bytes):
        content = content.decode("utf-8")

    type_ = language_v1.Document.Type.PLAIN_TEXT
    document = {"type_": type_, "content": content}

    response = client.analyze_sentiment(request={"document": document})
    sentiment = response.document_sentiment
    res = f"Score: {sentiment.score}, Magnitude: {sentiment.magnitude}"
    return jsonify(res)

  
if __name__=='__main__':
   app.run(host='0.0.0.0')