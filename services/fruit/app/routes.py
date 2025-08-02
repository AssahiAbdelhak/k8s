from db.functions import getFruits,getVitamins, addToCart, getFamilies, decreaseQte,triggetInCart, increaseQte, getFruitsInCart, getFruitsColors, getFruit, triggerFavs, getFavorites
from flask import jsonify, Blueprint

bp = Blueprint("routes", __name__)

@bp.route('/fruits', methods=['GET'])
def get_fruits():
    return jsonify(getFruits())

@bp.route('/fruits/<string:id>', methods=['GET'])
def get_fruit(id):
    print(id)
    return jsonify(getFruit(id))

@bp.route('/colors', methods=['GET'])
def get_colors():
    return jsonify(getFruitsColors())

@bp.route('/favs', methods=['GET'])
def get_favs():
    return jsonify(getFavorites())

@bp.route('/favs/<string:id>', methods=['PUT'])
def trigger_favs(id):
    triggerFavs(id)
    return jsonify(getFruit(id))

@bp.route('/cart', methods=['GET'])
def get_cart():
    return jsonify(getFruitsInCart())

@bp.route('/cart/<string:id>', methods=['PUT'])
def trigger_cart(id):
    jsonify(triggetInCart(id))
    return jsonify(getFruit(id))

@bp.route('/addTocart/<string:id>', methods=['PUT'])
def ad_to_cart(id):
    jsonify(addToCart(id))
    return jsonify(getFruit(id))

@bp.route('/fruits/increase/<string:id>', methods=['PUT'])
def increase_qte(id):
    return jsonify(increaseQte(id))

@bp.route('/fruits/decrease/<string:id>', methods=['PUT'])
def decrease_qte(id):
    return jsonify(decreaseQte(id))

@bp.route('/families', methods=['GET'])
def get_families():
    return jsonify(getFamilies())

@bp.route('/vitamins', methods=['GET'])
def get_vitamins():
    return jsonify(getVitamins())

