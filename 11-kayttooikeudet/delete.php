<?php

session_start();

if (!isset($_SESSION['user'])) {
    header('Location: index.php');
    exit;
}

if ($_SESSION['user']['role'] !== 'admin') {
   die('You do not have permission to delete this post.');
}

include 'connect.php';

$id = $_GET['id'];

$sql = "DELETE FROM posts WHERE id = :id";

try {
    $query = $conn->prepare($sql);
    $query->execute(['id' => $id]);

    header('Location: home.php');
    exit;
}
catch (PDOException $e) {
    die("Virhe: " . $e->getMessage());
}
?>