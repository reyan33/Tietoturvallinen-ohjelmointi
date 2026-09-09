<?php

session_start();

if (!isset($_SESSION['user'])) {
    header('Location: index.php');
    exit;
}

include 'connect.php';

$id = $_GET['id'];

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

if (
    $role !== 'admin' &&
    $role !== 'moderator' &&
    $userId != $post['author']
) {
    die('You do not have permission to edit this post.');
}
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit post</title>
</head>

<body>

    <h1>Edit post</h1>

    <form action="update.php" method="post">

        <input type="hidden" name="id" value="<?php echo $post['id']; ?>">

        <label for="title">Title</label><br>
        <input
            type="text"
            name="title"
            id="title"
            value="<?php echo htmlspecialchars($post['title']); ?>"
            required
        ><br><br>

        <label for="body">Message</label><br>
        <textarea
            name="body"
            id="body"
            required
        ><?php echo htmlspecialchars($post['body']); ?></textarea><br><br>

        <input type="submit" value="Save">

    </form>

    <p><a href="home.php">Back</a></p>

</body>
</html>