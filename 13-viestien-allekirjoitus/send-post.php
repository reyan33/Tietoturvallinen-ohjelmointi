<?php
include 'connect.php';

/** @var PDO $conn */
session_start();

$title = $_POST['title'];
$body = $_POST['body'];
$signature = $_POST['signature'];
$userId = $_SESSION['user']['id'];
$today = date("Y-m-d");

$sql = "INSERT INTO posts (title, body, posted, author, signature)
        VALUES (:title, :body, :posted, :userId, :signature);";

try {
    $query = $conn->prepare($sql);
    $query->execute([
        'title' => $title,
        'body' => $body,
        'posted' => $today,
        'userId' => $userId,
        'signature' => $signature
    ]);

    header('Location: home.php');
    exit;
} catch (PDOException $e) {
    die('Virhe: ' . $e->getMessage());
}
?>