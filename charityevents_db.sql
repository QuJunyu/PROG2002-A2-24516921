-- 1. 创建数据库（作业要求命名）
CREATE DATABASE IF NOT EXISTS charityevents_db;
USE charityevents_db;

-- 2. 事件类别表
CREATE TABLE IF NOT EXISTS categories (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 3. 慈善机构表
CREATE TABLE IF NOT EXISTS organizations (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(200) NOT NULL,
    mission TEXT NOT NULL,
    contact_email VARCHAR(100) NOT NULL,
    contact_phone VARCHAR(20) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 4. 事件表（新增purpose字段，作业要求显示事件目的）
CREATE TABLE IF NOT EXISTS events (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(200) NOT NULL,
    description TEXT NOT NULL,
    purpose TEXT NOT NULL, -- 新增：事件目的（作业详情页要求）
    date DATETIME NOT NULL,
    location VARCHAR(200) NOT NULL,
    ticket_price DECIMAL(10,2) NOT NULL,
    goal_amount DECIMAL(15,2) NOT NULL,
    current_amount DECIMAL(15,2) DEFAULT 0.00,
    category_id INT NOT NULL,
    organization_id INT NOT NULL,
    is_suspended BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (category_id) REFERENCES categories(id) ON DELETE CASCADE,
    FOREIGN KEY (organization_id) REFERENCES organizations(id) ON DELETE CASCADE
);

-- 5. 插入类别
INSERT INTO categories (name) VALUES
('Fun Run'),
('Gala Dinner'),
('Silent Auction'),
('Concert');

-- 6. 插入机构
INSERT INTO organizations (name, mission, contact_email, contact_phone) VALUES
(
    'Community Care Foundation',
    'Our mission is to support vulnerable families in the local community through food banks, education grants, and medical assistance. We believe every individual deserves access to basic needs and opportunities to thrive.',
    'contact@ccfoundation.org',
    '+61 2 1234 5678'
);

-- 7. 插入8个样本事件（补充purpose字段内容）
INSERT INTO events (name, description, purpose, date, location, ticket_price, goal_amount, current_amount, category_id, organization_id, is_suspended) VALUES
-- Upcoming 事件
(
    'City Fun Run 2025',
    'A family-friendly 5km fun run! All proceeds go to local food banks. No experience needed—bring your kids, friends, and even pets for a day of fitness and charity. T-shirts and refreshments provided for all participants.',
    'Raise funds for local food banks to support low-income families with weekly meals.', -- 事件目的
    '2025-10-15 08:00:00',
    'Central Park, Sydney',
    25.00,
    50000.00,
    12500.00,
    1,
    1,
    FALSE
),
(
    'Charity Gala Dinner',
    'An elegant black-tie event featuring a 3-course meal, live jazz music, and guest speeches from community leaders. Silent auction with luxury items (e.g., hotel stays, concert tickets) will be held during the evening.',
    'Fund medical grants for low-income families to cover children’s hospital bills.', -- 事件目的
    '2025-11-20 19:00:00',
    'Harbor View Hotel, Melbourne',
    150.00,
    100000.00,
    35000.00,
    2,
    1,
    FALSE
),
(
    'Winter Concert for Kids',
    'Live classical music performance by the City Youth Orchestra. Program includes child-friendly pieces (e.g., "Peter and the Wolf"). Free entry, but donations are encouraged.',
    'Support education programs for disadvantaged children (school supplies, tutoring).', -- 事件目的
    '2025-12-05 14:00:00',
    'Town Hall, Brisbane',
    0.00,
    20000.00,
    8500.00,
    4,
    1,
    FALSE
),
(
    'Silent Auction: Art for Charity',
    'Bid on original artworks by local artists (paintings, sculptures, photography). 100% of proceeds go to community education grants.',
    'Provide scholarships for disadvantaged high school students to attend university.', -- 事件目的
    '2025-10-28 10:00:00',
    'Art Gallery, Perth',
    10.00,
    30000.00,
    9200.00,
    3,
    1,
    FALSE
),
(
    'Beach Clean & Fun Day',
    'Help clean Manly Beach and enjoy a day of games, food trucks, and live music. Prizes for the team that collects the most trash!',
    'Fund ocean conservation projects (coral reef restoration, marine plastic cleanup).', -- 事件目的
    '2025-11-01 09:00:00',
    'Manly Beach, Sydney',
    15.00,
    15000.00,
    4800.00,
    1,
    1,
    FALSE
),
-- Past 事件
(
    'Spring Fun Run 2025',
    'A successful 3km fun run held in September 2025. Over 500 participants joined, raising more than the $30,000 goal!',
    'Fund allergy research for children with severe food allergies.', -- 事件目的
    '2025-09-01 08:00:00',
    'Botanic Gardens, Sydney',
    20.00,
    30000.00,
    32000.00,
    1,
    1,
    FALSE
),
-- Suspended 事件
(
    'Charity Golf Tournament',
    'A golf tournament for experienced players. Prizes include a weekend getaway and golf equipment. Suspended due to venue maintenance.',
    'Raise funds for homeless shelters to provide winter bedding and meals.', -- 事件目的
    '2025-10-10 08:30:00',
    'Golf Club, Sydney',
    100.00,
    40000.00,
    5000.00,
    1,
    1,
    TRUE
),
(
    'Community Bake Sale',
    'Homemade cakes, cookies, and pies sold to raise funds for homeless shelters. Suspended due to low volunteer numbers.',
    'Support homeless shelters with daily meals and hygiene kits.', -- 事件目的
    '2025-10-05 10:00:00',
    'Community Center, Adelaide',
    5.00,
    8000.00,
    1200.00,
    3,
    1,
    TRUE
);
    TRUE
);