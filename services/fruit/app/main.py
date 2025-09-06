from flask import Flask
from routes import bp
from flask_cors import CORS  # ← import this
from prometheus_flask_exporter import PrometheusMetrics



app = Flask('Fruit Service')
CORS(app)  # ← enable CORS globally
metrics = PrometheusMetrics(app)
app.register_blueprint(bp)

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
