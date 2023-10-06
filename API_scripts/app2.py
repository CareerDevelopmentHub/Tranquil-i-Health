from flask import Flask, request, jsonify
app = Flask(__name__)  
  
@app.route('/')      
def hello():
    return 'HELLO MED EXTRACT'

@app.route('/medinfo')
def get_med_info():
    text = request.args.get('text')
    import spacy
    import en_core_med7_lg
    med7 = spacy.load("en_core_med7_lg")
    doc = med7(text)
    res=[( ent.label_, ent.text) for ent in doc.ents]
    drugs = []
    strength=[]
    durations = []
    for item in res:
        if item[0] == 'DRUG':
            drugs.append(item[1])
        elif item[0] == 'DURATION':
            durations.append(item[1])
        else:
            strength.append(item[1])
    k=f"Drugs: {drugs}, Strength: {strength}, Durations: {durations}"
    return jsonify(k)
  
if __name__=='__main__':
   app.run(host='0.0.0.0')