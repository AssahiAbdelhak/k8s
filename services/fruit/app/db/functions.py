from db.connection import getConnection

request = """
    SELECT f.id, f.name, f.price, f.quantity, f.slug,
        f.in_bag as "inBag", f.is_favorite as "isFavorite",
        fm.name as family,
        array_agg(DISTINCT c.name) as colors,
        array_agg(DISTINCT v.name) as vitamins
        FROM fruits f
        JOIN families fm ON f.family_id = fm.id
        LEFT JOIN fruit_colors fc ON f.id = fc.fruit_id
        LEFT JOIN fruit_vitamins fv ON f.id = fv.fruit_id
        JOIN colors c ON c.id = fc.color_id
        JOIN vitamins v ON v.id = fv.vitamin_id
"""

group_by = """
GROUP BY f.id, f.name, f.price, fm.name, f.in_bag, f.is_favorite
"""

def getFruits():
    conn = getConnection()
    cursor = conn.cursor()
    cursor.execute(f"""
        {request}
        {group_by};
    """)
    res = cursor.fetchall()
    # Get column names
    colnames = [desc[0] for desc in cursor.description]

    # Convert to list of dicts
    fruits = [dict(zip(colnames, row)) for row in res]
    cursor.close()
    conn.close()
    return fruits

def getFruit(id):
    conn = getConnection()
    cursor = conn.cursor()
    cursor.execute(f"""
        {request}
        WHERE f.id=%s
        {group_by};
    """,(id,))
    res = cursor.fetchall()
    # Get column names
    colnames = [desc[0] for desc in cursor.description]

    # Convert to list of dicts
    fruits = [dict(zip(colnames, row)) for row in res]
    cursor.close()
    conn.close()
    return fruits[0]

def getFruitsColors(): 
    conn = getConnection()
    cursor = conn.cursor()
    cursor.execute("""
        SELECT * 
        FROM colors;
    """)
    res = cursor.fetchall()
    colnames = [desc[0] for desc in cursor.description]
    colors = [dict(zip(colnames, row)) for row in res]
    cursor.close()
    conn.close()
    return colors

def getFavorites(): 
    conn = getConnection()
    cursor = conn.cursor()
    cursor.execute(f"""
        SELECT f.id, f.name, f.price, f.description,
        f.in_bag, f.is_favorite, f.quantity, f.slug,
        fm.name as family_name,
        array_agg(DISTINCT c.name) as colors,
        array_agg(DISTINCT v.name) as vitamins
        FROM fruits f
        JOIN families fm ON f.family_id = fm.id
        LEFT JOIN fruit_colors fc ON f.id = fc.fruit_id
        LEFT JOIN fruit_vitamins fv ON f.id = fv.fruit_id
        JOIN colors c ON c.id = fc.color_id
        JOIN vitamins v ON v.id = fv.vitamin_id
        WHERE is_favorite=true
        {group_by}, f.description,
        f.in_bag, f.is_favorite, f.quantity, f.slug;
    """)
    res = cursor.fetchall()
    colnames = [desc[0] for desc in cursor.description]
    favs = [dict(zip(colnames, row)) for row in res]
    cursor.close()
    conn.close()
    return favs

def triggerFavs(id): 
    conn = getConnection()
    cursor = conn.cursor()
    res = cursor.execute("""
        UPDATE fruits SET is_favorite = NOT is_favorite
        WHERE id=%s 
        RETURNING *;""", (id,))
    print(res)
    conn.commit()
    cursor.close()
    conn.close()


def getFruitsInCart(): 
    conn = getConnection()
    cursor = conn.cursor()
    cursor.execute(f"""
        {request} WHERE in_bag=true {group_by};
    """)
    res = cursor.fetchall()
    colnames = [desc[0] for desc in cursor.description]
    cart = [dict(zip(colnames, row)) for row in res]
    cursor.close()
    conn.close()
    return cart

def triggetInCart(id): 
    conn = getConnection()
    cursor = conn.cursor()
    cursor.execute("""
        UPDATE fruits SET in_bag = NOT in_bag WHERE id=%s;
    """, (id,))
    conn.commit()
    cursor.close()
    conn.close()

def addToCart(id): 
    conn = getConnection()
    cursor = conn.cursor()
    cursor.execute("""
        UPDATE fruits SET in_bag = true WHERE id=%s;
    """, (id,))
    conn.commit()
    cursor.close()
    conn.close()

def increaseQte(id): 
    conn = getConnection()
    cursor = conn.cursor()
    cursor.execute("UPDATE fruits SET quantity=quantity+1 WHERE id=%s;", (id,))
    conn.commit()
    cursor.close()
    conn.close()

def decreaseQte(id): 
    conn = getConnection()
    cursor = conn.cursor()
    cursor.execute("UPDATE fruits SET quantity=quantity-1 WHERE id=%s;", (id,))
    conn.commit()
    cursor.close()
    conn.close()

def getColors(): 
    conn = getConnection()
    cursor = conn.cursor()
    cursor.execute("SELECT * FROM colors;")
    res = cursor.fetchall()
    colnames = [desc[0] for desc in cursor.description]
    colors = [dict(zip(colnames, row)) for row in res]
    cursor.close()
    conn.close()
    return colors

def getFamilies(): 
    conn = getConnection()
    cursor = conn.cursor()
    cursor.execute("SELECT * FROM families;")
    res = cursor.fetchall()
    colnames = [desc[0] for desc in cursor.description]
    families = [dict(zip(colnames, row)) for row in res]
    cursor.close()
    conn.close()
    return families

def getVitamins(): 
    conn = getConnection()
    cursor = conn.cursor()
    cursor.execute("SELECT * FROM vitamins;")
    res = cursor.fetchall()
    colnames = [desc[0] for desc in cursor.description]
    vitamins = [dict(zip(colnames, row)) for row in res]
    cursor.close()
    conn.close()
    return vitamins


