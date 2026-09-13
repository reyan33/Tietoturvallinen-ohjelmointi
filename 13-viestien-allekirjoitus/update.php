<?php

session_start();

if (!isset($_SESSION['user'])) {
    header('Location: index.php');
    exit;
}

include 'connect.php';

$id = $_POST['id'];
$title = $_POST['title'];
$body = $_POST['body'];


$sql = "SELECT * FROM posts WHERE id = :id";

try {
    $query = $conn->prepare($sql);
    $query->execute(['id' => $id]);
} catch (PDOException $e) {
    die("Error: " . $e->getMessage());
}

$post = $query->fetch();

if (!$post) {
    die('Post not found.');
}

$role = $_SESSION['user']['role'];
$userId = $_SESSION['user']['id'];

// Check permission

if (
    $role !== 'admin' &&
    $role !== 'moderator' &&
    $userId != $post['author']
) {
    die('You do not have permission to edit this post.');
}

// Update the post

$sql = "UPDATE posts
        SET title = :title, body = :body
        WHERE id = :id";

try {
    $query = $conn->prepare($sql);

    $query->execute([
        'title' => $title,
        'body' => $body,
        'id' => $id
    ]);

    header('Location: home.php');
    exit;

} catch (PDOException $e) {
    die("Error: " . $e->getMessage());
}
?>