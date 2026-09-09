<?php

include 'connect.php';

$username = $_POST['username'];
$realname = $_POST['realname'];
$password = $_POST['password'];

$hashedPassword = password_hash($password, PASSWORD_DEFAULT);

$sql = "INSERT INTO users (username, realname, password)
        VALUES (:username, :realname, :password);";

try {
    $query = $conn->prepare($sql);
    $query->execute([
        'username' => $username,
        'realname' => $realname,
        'password' => $hashedPassword
    ]);

    header('Location: index.php');
    exit;
}
catch (PDOException $e) {
    die("Virhe: " . $e->getMessage());
}
?>