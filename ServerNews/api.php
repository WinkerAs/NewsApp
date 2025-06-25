<?php
header('Content-Type: application/json');
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: POST, GET, OPTIONS');
header('Access-Control-Allow-Headers: Content-Type');

$host = 'localhost';
$db   = 'winkera5_newsDB';
$user = 'winkera5_admin';
$pass = 'qwyBX2000';
$dsn = "mysql:host=$host;dbname=$db;charset=utf8";

try {
    $pdo = new PDO($dsn, $user, $pass);
} catch (Exception $e) {
    http_response_code(500);
    echo json_encode(['error' => 'Database connection failed']);
    exit;
}

action: isset($_GET['action']) ? $_GET['action'] : '';

switch($_GET['action']) {
    case 'register':
        $data = json_decode(file_get_contents('php://input'), true);
        $username = $data['username'];
        $password = password_hash($data['password'], PASSWORD_BCRYPT);
        $stmt = $pdo->prepare('INSERT INTO users (username, password) VALUES (?, ?)');
        if ($stmt->execute([$username, $password])) {
            echo json_encode(['status' => 'success']);
        } else {
            http_response_code(400);
            echo json_encode(['error' => 'Registration failed']);
        }
        break;

    case 'login':
        $data = json_decode(file_get_contents('php://input'), true);
        $username = $data['username'];
        $password = $data['password'];
        $stmt = $pdo->prepare('SELECT * FROM users WHERE username = ?');
        $stmt->execute([$username]);
        $user = $stmt->fetch(PDO::FETCH_ASSOC);
        if ($user && password_verify($password, $user['password'])) {
            echo json_encode(['status' => 'success', 'user_id' => $user['id']]);
        } else {
            http_response_code(401);
            echo json_encode(['error' => 'Invalid credentials']);
        }
        break;

    case 'categories':
        $stmt = $pdo->query('SELECT * FROM categories');
        $cats = $stmt->fetchAll(PDO::FETCH_ASSOC);
        echo json_encode($cats);
        break;

    case 'news':
        $cat = isset($_GET['category_id']) ? intval($_GET['category_id']) : 0;
        if ($cat) {
            $stmt = $pdo->prepare('SELECT n.id,n.title,n.created_at,c.name as category FROM news n JOIN categories c ON n.category_id=c.id WHERE c.id=? ORDER BY n.created_at DESC');
            $stmt->execute([$cat]);
        } else {
            $stmt = $pdo->query('SELECT n.id,n.title,n.created_at,c.name as category FROM news n JOIN categories c ON n.category_id=c.id ORDER BY n.created_at DESC');
        }
        echo json_encode($stmt->fetchAll(PDO::FETCH_ASSOC));
        break;

    case 'news':
        $cat = isset($_GET['category_id']) ? intval($_GET['category_id']) : 0;
        if ($cat) {
            $stmt = $pdo->prepare(
                'SELECT n.id, n.title, n.image_url, n.created_at, c.name as category
                 FROM news n
                 JOIN categories c ON n.category_id=c.id
                 WHERE c.id=? ORDER BY n.created_at DESC'
            );
            $stmt->execute([$cat]);
        } else {
            $stmt = $pdo->query(
                'SELECT n.id, n.title, n.image_url, n.created_at, c.name as category
                 FROM news n
                 JOIN categories c ON n.category_id=c.id ORDER BY n.created_at DESC'
            );
        }
        echo json_encode($stmt->fetchAll(PDO::FETCH_ASSOC));
        break;

    case 'news_detail':
        $id = intval($_GET['id']);
        $stmt = $pdo->prepare(
            'SELECT n.id, n.title, n.content, n.image_url, n.created_at, c.name as category
             FROM news n
             JOIN categories c ON n.category_id=c.id WHERE n.id=?'
        );
        $stmt->execute([$id]);
        $item = $stmt->fetch(PDO::FETCH_ASSOC);
        if ($item) echo json_encode($item);
        else http_response_code(404) && print(json_encode(['error'=>'Not found']));
        break;

    default:
        http_response_code(400);
        echo json_encode(['error' => 'Invalid action']);
}
?>
