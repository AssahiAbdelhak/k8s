-- Script de création des tables pour la base de données des fruits
-- Basé sur les types TypeScript définis dans l'application frontend

-- Table des familles de fruits
CREATE TABLE families (
    id SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL UNIQUE
);

-- Table des couleurs
CREATE TABLE colors (
    id SERIAL PRIMARY KEY,
    name VARCHAR(20) NOT NULL UNIQUE
);

-- Table des vitamines
CREATE TABLE vitamins (
    id SERIAL PRIMARY KEY,
    name VARCHAR(20) NOT NULL UNIQUE
);

-- Table principale des fruits
CREATE TABLE fruits (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    name VARCHAR(100) NOT NULL,
    slug VARCHAR(100) NOT NULL UNIQUE,
    price DECIMAL(10,2) NOT NULL,
    quantity INTEGER NOT NULL DEFAULT 1,
    family_id INTEGER NOT NULL REFERENCES families(id),
    is_favorite BOOLEAN NOT NULL DEFAULT FALSE,
    in_bag BOOLEAN NOT NULL DEFAULT FALSE,
    description TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Table de liaison entre fruits et couleurs (relation many-to-many)
CREATE TABLE fruit_colors (
    fruit_id UUID REFERENCES fruits(id) ON DELETE CASCADE,
    color_id INTEGER REFERENCES colors(id) ON DELETE CASCADE,
    PRIMARY KEY (fruit_id, color_id)
);

-- Table de liaison entre fruits et vitamines (relation many-to-many)
CREATE TABLE fruit_vitamins (
    fruit_id UUID REFERENCES fruits(id) ON DELETE CASCADE,
    vitamin_id INTEGER REFERENCES vitamins(id) ON DELETE CASCADE,
    PRIMARY KEY (fruit_id, vitamin_id)
);

-- Insertion des familles
INSERT INTO families (name) VALUES
    ('Rose'),
    ('Citrus'),
    ('Nightshade'),
    ('Gourd'),
    ('Palm'),
    ('Cashew'),
    ('Berry'),
    ('Laurel'),
    ('Other');

-- Insertion des couleurs
INSERT INTO colors (name) VALUES
    ('Purple'),
    ('Green'),
    ('Brown'),
    ('Red'),
    ('Orange'),
    ('Yellow'),
    ('Blue'),
    ('Black');

-- Insertion des vitamines
INSERT INTO vitamins (name) VALUES
    ('Vitamin C'),
    ('Vitamin A'),
    ('Vitamin K'),
    ('Vitamin E'),
    ('Vitamin B6');

-- Insertion des fruits avec leurs descriptions
INSERT INTO fruits (name, slug, price, quantity, family_id, is_favorite, in_bag, description) VALUES
    ('Tangerine', 'tangerine', 2.00, 1, (SELECT id FROM families WHERE name = 'Citrus'), FALSE, FALSE, 
     'Tangerines are small citrus fruits that are similar in appearance to oranges, but they are smaller and have a thinner, easier-to-peel skin. They are typically sweet with a slightly tart flavor, and they are often juicier than oranges. Tangerines have a distinct aroma and a bright orange color.'),
    
    ('Melon', 'melon', 3.50, 1, (SELECT id FROM families WHERE name = 'Gourd'), FALSE, FALSE,
     'Melon is a broad term that refers to various fruits belonging to the Gourd family, including cantaloupe, honeydew, and watermelon. Melons are characterized by their sweet, juicy flesh and refreshing taste. Cantaloupes have a sweet and slightly musky flavor, honeydews are typically sweeter with a subtle honey-like taste, and watermelons have a crisp texture and a very sweet flavor with a hint of freshness.'),
    
    ('Watermelon', 'watermelon', 6.00, 1, (SELECT id FROM families WHERE name = 'Gourd'), FALSE, FALSE,
     'Watermelon is a large, round fruit with a thick green rind and juicy, red flesh dotted with black seeds (although seedless varieties are also common). Watermelons have a high water content, making them incredibly hydrating and refreshing. Their flavor is sweet and slightly tangy, with a crisp texture.'),
    
    ('Lemon', 'lemon', 1.50, 1, (SELECT id FROM families WHERE name = 'Citrus'), TRUE, FALSE,
     'Lemons are small, yellow citrus fruits with a bright, acidic flavor. They have a tart taste that can range from mildly sour to intensely puckering, depending on the ripeness of the fruit. Lemons are commonly used to add acidity and freshness to dishes, beverages, and desserts.'),
    
    ('Banana', 'banana', 5.00, 1, (SELECT id FROM families WHERE name = 'Other'), FALSE, FALSE,
     'Bananas are elongated, curved fruits with a thick, yellow skin that is easily peeled to reveal soft, creamy flesh. They have a sweet flavor with subtle notes of vanilla and a creamy texture. Bananas are rich in natural sugars, making them a popular choice for snacking, baking, and blending into smoothies.'),
    
    ('Pineapple', 'pineapple', 3.00, 1, (SELECT id FROM families WHERE name = 'Other'), FALSE, FALSE,
     'Pineapples are tropical fruits characterized by their spiky, rough skin and sweet, juicy flesh. They have a vibrant yellow color and a distinctively sweet and tangy flavor with hints of tropical notes. Pineapples can be enjoyed fresh, juiced, grilled, or incorporated into both sweet and savory dishes.'),
    
    ('Mango', 'mango', 5.00, 1, (SELECT id FROM families WHERE name = 'Cashew'), FALSE, FALSE,
     'Mangos are tropical fruits with a smooth, golden-yellow skin and juicy, sweet flesh surrounding a large, flat seed. They have a rich, creamy texture and a complex flavor profile that combines sweetness with tanginess and hints of tropical flavors such as peach, pineapple, and citrus. Mangos are often eaten fresh or used in smoothies, salads, salsas, and desserts.'),
    
    ('Red Apple', 'red-apple', 1.30, 1, (SELECT id FROM families WHERE name = 'Rose'), FALSE, FALSE,
     'Red apples are one of the most common varieties of apples. They have a shiny red skin and crisp, juicy flesh. Red apples typically have a balanced flavor profile, combining sweetness with a hint of tartness. They are versatile and can be eaten fresh, used in cooking, or pressed into juice.'),
    
    ('Green Apple', 'green-apple', 1.50, 1, (SELECT id FROM families WHERE name = 'Rose'), FALSE, FALSE,
     'Green apples, also known as Granny Smith apples, have a bright green skin and a tart, tangy flavor. They are known for their crisp texture and refreshing taste. Green apples are often used in baking, salads, and sauces, as their tartness adds a nice contrast to sweeter ingredients.'),
    
    ('Pear', 'pear', 2.50, 1, (SELECT id FROM families WHERE name = 'Rose'), FALSE, FALSE,
     'Pears are sweet and juicy fruits with a distinctive bell-like shape and smooth skin that can range in color from green to yellow to red. They have a delicate, floral flavor with a hint of sweetness and subtle grainy texture. Pears can be enjoyed fresh or used in desserts, salads, and savory dishes.'),
    
    ('Peach', 'peach', 3.00, 5, (SELECT id FROM families WHERE name = 'Rose'), FALSE, TRUE,
     'Peaches are soft, fuzzy fruits with a sweet and juicy flesh that ranges in color from yellow to orange. They have a rich, aromatic flavor with hints of floral and tropical notes. Peaches are commonly eaten fresh or used in desserts such as pies, cobblers, and preserves.'),
    
    ('Cherries', 'cherries', 4.00, 1, (SELECT id FROM families WHERE name = 'Rose'), FALSE, FALSE,
     'Cherries are small, round fruits with a shiny skin that can range in color from bright red to deep purple. They have a sweet and tangy flavor with a hint of tartness. Cherries are commonly enjoyed fresh as a snack or used in desserts, jams, and beverages.'),
    
    ('Strawberry', 'strawberry', 2.80, 1, (SELECT id FROM families WHERE name = 'Rose'), FALSE, FALSE,
     'Strawberries are heart-shaped fruits with a bright red color and small seeds covering their surface. They have a sweet and slightly tart flavor with a juicy and fragrant flesh. Strawberries are popular in desserts, salads, smoothies, and jams due to their delicious taste and vibrant color.'),
    
    ('Blueberries', 'blueberries', 4.50, 1, (SELECT id FROM families WHERE name = 'Berry'), FALSE, TRUE,
     'Blueberries are small, round berries with a deep blue-purple color and a slightly waxy coating. They have a sweet and mildly tart flavor with a juicy flesh. Blueberries are rich in antioxidants and are often enjoyed fresh as a snack or added to cereals, muffins, pancakes, and desserts.'),
    
    ('Grapes', 'grapes', 3.00, 1, (SELECT id FROM families WHERE name = 'Berry'), TRUE, FALSE,
     'Grapes are small, round or oval-shaped fruits that grow in clusters on vines. They come in various colors such as green, red, and purple. Grapes have a sweet and juicy flesh with a mild tartness, and their flavor can vary depending on the variety. They are commonly eaten fresh as a snack, used in salads, or processed into juices, wines, and raisins.'),
    
    ('Kiwi', 'kiwi', 1.00, 5, (SELECT id FROM families WHERE name = 'Other'), FALSE, FALSE,
     'Kiwi, also known as kiwifruit or Chinese gooseberry, is a small, oval-shaped fruit with brown, fuzzy skin and vibrant green flesh with tiny black seeds. Kiwi has a sweet and tangy flavor with tropical notes reminiscent of strawberries and melons. It is commonly eaten fresh, sliced, or used in fruit salads, smoothies, and desserts.'),
    
    ('Tomato', 'tomato', 1.50, 1, (SELECT id FROM families WHERE name = 'Nightshade'), FALSE, FALSE,
     'Although commonly mistaken for a vegetable, tomatoes are technically fruits. They come in various colors, including red, yellow, orange, and even purple, and they have a smooth, shiny skin. Tomatoes have a mildly sweet and tangy flavor with a juicy flesh and slightly acidic taste. They are versatile and used in salads, sauces, soups, sandwiches, and many other dishes.'),
    
    ('Olive', 'olive', 4.00, 1, (SELECT id FROM families WHERE name = 'Other'), FALSE, FALSE,
     'Olives are small, oval-shaped fruits with a smooth skin that can vary in color from green to black, depending on ripeness and variety. They have a rich, salty flavor with a unique buttery texture. Olives are often brined or cured before consumption and are commonly used in Mediterranean cuisine, salads, pizzas, and as a garnish.'),
    
    ('Coconut', 'coconut', 2.80, 1, (SELECT id FROM families WHERE name = 'Palm'), FALSE, FALSE,
     'Coconuts are large, brown fruits with a hard, hairy shell and sweet, white flesh inside. They have a tropical and slightly sweet flavor with a rich, creamy texture. Coconuts are used in various forms, including fresh coconut water, coconut milk, shredded coconut, and coconut oil. They are a staple ingredient in many tropical dishes and desserts.'),
    
    ('Avocado', 'avocado', 3.00, 1, (SELECT id FROM families WHERE name = 'Laurel'), FALSE, FALSE,
     'Avocado is a pear-shaped fruit with dark green or blackish skin and creamy, pale green flesh surrounding a large seed. Avocados have a buttery texture and a mild, nutty flavor with hints of sweetness and earthiness. They are often enjoyed fresh in salads, sandwiches, guacamole, and smoothies due to their creamy texture and rich flavor.'),
    
    ('Eggplant', 'eggplant', 1.80, 1, (SELECT id FROM families WHERE name = 'Nightshade'), FALSE, FALSE,
     'Eggplant, also known as aubergine, is a large, egg-shaped fruit with smooth, shiny skin that can vary in color from deep purple to white. Eggplants have a mild, slightly bitter flavor and a spongy texture when cooked. They are commonly used in various cuisines, such as Mediterranean and Asian, and can be grilled, roasted, fried, or stewed in dishes like ratatouille, moussaka, and curries.'),
    
    ('Cucumber', 'cucumber', 1.00, 1, (SELECT id FROM families WHERE name = 'Gourd'), TRUE, FALSE,
     'Cucumber is a cylindrical fruit with smooth, dark green skin and crisp, watery flesh. It has a mild, refreshing flavor with subtle hints of sweetness and a slight bitterness in the peel. Cucumbers are commonly eaten raw in salads, sandwiches, and as a crunchy snack. They are also used to make pickles and are a popular ingredient in chilled soups like gazpacho.'),
    
    ('Bell Pepper', 'bell-pepper', 1.30, 1, (SELECT id FROM families WHERE name = 'Nightshade'), FALSE, FALSE,
     'Bell peppers are large, bell-shaped fruits with glossy, smooth skin that comes in various colors, including green, red, yellow, and orange. They have a crisp texture and a sweet, slightly tangy flavor. Bell peppers are versatile and can be eaten raw in salads, stuffed, roasted, grilled, or sautéed in various dishes like stir-fries, fajitas, and pasta sauces.'),
    
    ('Hot Pepper', 'hot-pepper', 2.50, 1, (SELECT id FROM families WHERE name = 'Nightshade'), FALSE, FALSE,
     'Hot peppers, also known as chili peppers or chilies, come in a wide range of shapes, sizes, colors, and levels of spiciness. They contain capsaicin, a compound responsible for their heat. Hot peppers can have flavors ranging from mildly sweet to intensely spicy, depending on the variety. They are commonly used to add heat and flavor to dishes, sauces, salsas, and marinades.'),
    
    ('Pumpkin', 'pumpkin', 2.50, 1, (SELECT id FROM families WHERE name = 'Gourd'), FALSE, FALSE,
     'Pumpkin is a large, round fruit with a thick, orange or yellowish skin and sweet, fibrous flesh. It has a mild, earthy flavor with subtle hints of sweetness, making it versatile for both sweet and savory dishes. Pumpkins are commonly used in pies, soups, stews, curries, and baked goods like muffins and bread. Additionally, pumpkin seeds can be roasted and eaten as a snack or used as a garnish.');

-- Insertion des relations fruits-couleurs
-- Tangerine: Orange
INSERT INTO fruit_colors (fruit_id, color_id) 
SELECT f.id, c.id FROM fruits f, colors c 
WHERE f.slug = 'tangerine' AND c.name = 'Orange';

-- Melon: Green
INSERT INTO fruit_colors (fruit_id, color_id) 
SELECT f.id, c.id FROM fruits f, colors c 
WHERE f.slug = 'melon' AND c.name = 'Green';

-- Watermelon: Red, Green
INSERT INTO fruit_colors (fruit_id, color_id) 
SELECT f.id, c.id FROM fruits f, colors c 
WHERE f.slug = 'watermelon' AND c.name IN ('Red', 'Green');

-- Lemon: Yellow
INSERT INTO fruit_colors (fruit_id, color_id) 
SELECT f.id, c.id FROM fruits f, colors c 
WHERE f.slug = 'lemon' AND c.name = 'Yellow';

-- Banana: Yellow
INSERT INTO fruit_colors (fruit_id, color_id) 
SELECT f.id, c.id FROM fruits f, colors c 
WHERE f.slug = 'banana' AND c.name = 'Yellow';

-- Pineapple: Yellow, Green
INSERT INTO fruit_colors (fruit_id, color_id) 
SELECT f.id, c.id FROM fruits f, colors c 
WHERE f.slug = 'pineapple' AND c.name IN ('Yellow', 'Green');

-- Mango: Yellow, Red, Green
INSERT INTO fruit_colors (fruit_id, color_id) 
SELECT f.id, c.id FROM fruits f, colors c 
WHERE f.slug = 'mango' AND c.name IN ('Yellow', 'Red', 'Green');

-- Red Apple: Red
INSERT INTO fruit_colors (fruit_id, color_id) 
SELECT f.id, c.id FROM fruits f, colors c 
WHERE f.slug = 'red-apple' AND c.name = 'Red';

-- Green Apple: Green
INSERT INTO fruit_colors (fruit_id, color_id) 
SELECT f.id, c.id FROM fruits f, colors c 
WHERE f.slug = 'green-apple' AND c.name = 'Green';

-- Pear: Green
INSERT INTO fruit_colors (fruit_id, color_id) 
SELECT f.id, c.id FROM fruits f, colors c 
WHERE f.slug = 'pear' AND c.name = 'Green';

-- Peach: Orange
INSERT INTO fruit_colors (fruit_id, color_id) 
SELECT f.id, c.id FROM fruits f, colors c 
WHERE f.slug = 'peach' AND c.name = 'Orange';

-- Cherries: Red, Green
INSERT INTO fruit_colors (fruit_id, color_id) 
SELECT f.id, c.id FROM fruits f, colors c 
WHERE f.slug = 'cherries' AND c.name IN ('Red', 'Green');

-- Strawberry: Red
INSERT INTO fruit_colors (fruit_id, color_id) 
SELECT f.id, c.id FROM fruits f, colors c 
WHERE f.slug = 'strawberry' AND c.name = 'Red';

-- Blueberries: Blue, Black
INSERT INTO fruit_colors (fruit_id, color_id) 
SELECT f.id, c.id FROM fruits f, colors c 
WHERE f.slug = 'blueberries' AND c.name IN ('Blue', 'Black');

-- Grapes: Purple
INSERT INTO fruit_colors (fruit_id, color_id) 
SELECT f.id, c.id FROM fruits f, colors c 
WHERE f.slug = 'grapes' AND c.name = 'Purple';

-- Kiwi: Green, Brown
INSERT INTO fruit_colors (fruit_id, color_id) 
SELECT f.id, c.id FROM fruits f, colors c 
WHERE f.slug = 'kiwi' AND c.name IN ('Green', 'Brown');

-- Tomato: Red
INSERT INTO fruit_colors (fruit_id, color_id) 
SELECT f.id, c.id FROM fruits f, colors c 
WHERE f.slug = 'tomato' AND c.name = 'Red';

-- Olive: Green
INSERT INTO fruit_colors (fruit_id, color_id) 
SELECT f.id, c.id FROM fruits f, colors c 
WHERE f.slug = 'olive' AND c.name = 'Green';

-- Coconut: Brown
INSERT INTO fruit_colors (fruit_id, color_id) 
SELECT f.id, c.id FROM fruits f, colors c 
WHERE f.slug = 'coconut' AND c.name = 'Brown';

-- Avocado: Green, Brown
INSERT INTO fruit_colors (fruit_id, color_id) 
SELECT f.id, c.id FROM fruits f, colors c 
WHERE f.slug = 'avocado' AND c.name IN ('Green', 'Brown');

-- Eggplant: Purple
INSERT INTO fruit_colors (fruit_id, color_id) 
SELECT f.id, c.id FROM fruits f, colors c 
WHERE f.slug = 'eggplant' AND c.name = 'Purple';

-- Cucumber: Green
INSERT INTO fruit_colors (fruit_id, color_id) 
SELECT f.id, c.id FROM fruits f, colors c 
WHERE f.slug = 'cucumber' AND c.name = 'Green';

-- Bell Pepper: Green
INSERT INTO fruit_colors (fruit_id, color_id) 
SELECT f.id, c.id FROM fruits f, colors c 
WHERE f.slug = 'bell-pepper' AND c.name = 'Green';

-- Hot Pepper: Red
INSERT INTO fruit_colors (fruit_id, color_id) 
SELECT f.id, c.id FROM fruits f, colors c 
WHERE f.slug = 'hot-pepper' AND c.name = 'Red';

-- Pumpkin: Orange, Yellow
INSERT INTO fruit_colors (fruit_id, color_id) 
SELECT f.id, c.id FROM fruits f, colors c 
WHERE f.slug = 'pumpkin' AND c.name IN ('Orange', 'Yellow');

-- Insertion des relations fruits-vitamines
-- Tangerine: Vitamin C
INSERT INTO fruit_vitamins (fruit_id, vitamin_id) 
SELECT f.id, v.id FROM fruits f, vitamins v 
WHERE f.slug = 'tangerine' AND v.name = 'Vitamin C';

-- Melon: Vitamin A, Vitamin C
INSERT INTO fruit_vitamins (fruit_id, vitamin_id) 
SELECT f.id, v.id FROM fruits f, vitamins v 
WHERE f.slug = 'melon' AND v.name IN ('Vitamin A', 'Vitamin C');

-- Watermelon: Vitamin A, Vitamin C
INSERT INTO fruit_vitamins (fruit_id, vitamin_id) 
SELECT f.id, v.id FROM fruits f, vitamins v 
WHERE f.slug = 'watermelon' AND v.name IN ('Vitamin A', 'Vitamin C');

-- Lemon: Vitamin C
INSERT INTO fruit_vitamins (fruit_id, vitamin_id) 
SELECT f.id, v.id FROM fruits f, vitamins v 
WHERE f.slug = 'lemon' AND v.name = 'Vitamin C';

-- Banana: Vitamin B6
INSERT INTO fruit_vitamins (fruit_id, vitamin_id) 
SELECT f.id, v.id FROM fruits f, vitamins v 
WHERE f.slug = 'banana' AND v.name = 'Vitamin B6';

-- Pineapple: Vitamin C, Vitamin B6
INSERT INTO fruit_vitamins (fruit_id, vitamin_id) 
SELECT f.id, v.id FROM fruits f, vitamins v 
WHERE f.slug = 'pineapple' AND v.name IN ('Vitamin C', 'Vitamin B6');

-- Mango: Vitamin A, Vitamin C
INSERT INTO fruit_vitamins (fruit_id, vitamin_id) 
SELECT f.id, v.id FROM fruits f, vitamins v 
WHERE f.slug = 'mango' AND v.name IN ('Vitamin A', 'Vitamin C');

-- Red Apple: Vitamin C
INSERT INTO fruit_vitamins (fruit_id, vitamin_id) 
SELECT f.id, v.id FROM fruits f, vitamins v 
WHERE f.slug = 'red-apple' AND v.name = 'Vitamin C';

-- Green Apple: Vitamin C
INSERT INTO fruit_vitamins (fruit_id, vitamin_id) 
SELECT f.id, v.id FROM fruits f, vitamins v 
WHERE f.slug = 'green-apple' AND v.name = 'Vitamin C';

-- Pear: Vitamin C, Vitamin K
INSERT INTO fruit_vitamins (fruit_id, vitamin_id) 
SELECT f.id, v.id FROM fruits f, vitamins v 
WHERE f.slug = 'pear' AND v.name IN ('Vitamin C', 'Vitamin K');

-- Peach: Vitamin A, Vitamin C
INSERT INTO fruit_vitamins (fruit_id, vitamin_id) 
SELECT f.id, v.id FROM fruits f, vitamins v 
WHERE f.slug = 'peach' AND v.name IN ('Vitamin A', 'Vitamin C');

-- Cherries: Vitamin C
INSERT INTO fruit_vitamins (fruit_id, vitamin_id) 
SELECT f.id, v.id FROM fruits f, vitamins v 
WHERE f.slug = 'cherries' AND v.name = 'Vitamin C';

-- Strawberry: Vitamin C
INSERT INTO fruit_vitamins (fruit_id, vitamin_id) 
SELECT f.id, v.id FROM fruits f, vitamins v 
WHERE f.slug = 'strawberry' AND v.name = 'Vitamin C';

-- Blueberries: Vitamin C, Vitamin K
INSERT INTO fruit_vitamins (fruit_id, vitamin_id) 
SELECT f.id, v.id FROM fruits f, vitamins v 
WHERE f.slug = 'blueberries' AND v.name IN ('Vitamin C', 'Vitamin K');

-- Grapes: Vitamin C, Vitamin K
INSERT INTO fruit_vitamins (fruit_id, vitamin_id) 
SELECT f.id, v.id FROM fruits f, vitamins v 
WHERE f.slug = 'grapes' AND v.name IN ('Vitamin C', 'Vitamin K');

-- Kiwi: Vitamin C, Vitamin K
INSERT INTO fruit_vitamins (fruit_id, vitamin_id) 
SELECT f.id, v.id FROM fruits f, vitamins v 
WHERE f.slug = 'kiwi' AND v.name IN ('Vitamin C', 'Vitamin K');

-- Tomato: Vitamin A, Vitamin C
INSERT INTO fruit_vitamins (fruit_id, vitamin_id) 
SELECT f.id, v.id FROM fruits f, vitamins v 
WHERE f.slug = 'tomato' AND v.name IN ('Vitamin A', 'Vitamin C');

-- Olive: Vitamin E, Vitamin K
INSERT INTO fruit_vitamins (fruit_id, vitamin_id) 
SELECT f.id, v.id FROM fruits f, vitamins v 
WHERE f.slug = 'olive' AND v.name IN ('Vitamin E', 'Vitamin K');

-- Coconut: Vitamin B6
INSERT INTO fruit_vitamins (fruit_id, vitamin_id) 
SELECT f.id, v.id FROM fruits f, vitamins v 
WHERE f.slug = 'coconut' AND v.name = 'Vitamin B6';

-- Avocado: Vitamin K, Vitamin E
INSERT INTO fruit_vitamins (fruit_id, vitamin_id) 
SELECT f.id, v.id FROM fruits f, vitamins v 
WHERE f.slug = 'avocado' AND v.name IN ('Vitamin K', 'Vitamin E');

-- Eggplant: Vitamin K
INSERT INTO fruit_vitamins (fruit_id, vitamin_id) 
SELECT f.id, v.id FROM fruits f, vitamins v 
WHERE f.slug = 'eggplant' AND v.name = 'Vitamin K';

-- Cucumber: Vitamin K
INSERT INTO fruit_vitamins (fruit_id, vitamin_id) 
SELECT f.id, v.id FROM fruits f, vitamins v 
WHERE f.slug = 'cucumber' AND v.name = 'Vitamin K';

-- Bell Pepper: Vitamin A, Vitamin C
INSERT INTO fruit_vitamins (fruit_id, vitamin_id) 
SELECT f.id, v.id FROM fruits f, vitamins v 
WHERE f.slug = 'bell-pepper' AND v.name IN ('Vitamin A', 'Vitamin C');

-- Hot Pepper: Vitamin C
INSERT INTO fruit_vitamins (fruit_id, vitamin_id) 
SELECT f.id, v.id FROM fruits f, vitamins v 
WHERE f.slug = 'hot-pepper' AND v.name = 'Vitamin C';

-- Pumpkin: Vitamin A
INSERT INTO fruit_vitamins (fruit_id, vitamin_id) 
SELECT f.id, v.id FROM fruits f, vitamins v 
WHERE f.slug = 'pumpkin' AND v.name = 'Vitamin A';

-- Index pour améliorer les performances
CREATE INDEX idx_fruits_family_id ON fruits(family_id);
CREATE INDEX idx_fruits_slug ON fruits(slug);
CREATE INDEX idx_fruits_is_favorite ON fruits(is_favorite);
CREATE INDEX idx_fruits_in_bag ON fruits(in_bag);
CREATE INDEX idx_fruit_colors_fruit_id ON fruit_colors(fruit_id);
CREATE INDEX idx_fruit_colors_color_id ON fruit_colors(color_id);
CREATE INDEX idx_fruit_vitamins_fruit_id ON fruit_vitamins(fruit_id);
CREATE INDEX idx_fruit_vitamins_vitamin_id ON fruit_vitamins(vitamin_id);
