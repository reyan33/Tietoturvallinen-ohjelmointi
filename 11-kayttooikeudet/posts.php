<?php 
include 'connect.php';

/** @var PDO $conn */
?>

<ul>
    <hr>

    <?php
    $sql = "SELECT * FROM posts;";

    try {
        $query = $conn->prepare($sql);
        $query->execute();
    } catch (PDOException $e) {
        die("Error: " . $e->getMessage());
    }

    $res = $query->fetchAll();

    foreach ($res as $row) {

        $author = array_filter(
            $_SESSION['users'],
            function($v, $k) use ($row) {
                return $v['id'] === $row['author'];
            },
            ARRAY_FILTER_USE_BOTH
        );

        $author = array_values($author);
        $author = $author[0];

        $role = $_SESSION['user']['role'];
        $userId = $_SESSION['user']['id'];
    ?>

        <li>
            <h3><?php echo htmlspecialchars($row['title']); ?></h3>

            <p>
                <i>
                    <?php
                    echo $row['posted'] . ' – ' . htmlspecialchars($author['realname']);
                    ?>
                </i>
            </p>

            <p><?php echo htmlspecialchars($row['body']); ?></p>

            <?php
            if (
                $role === 'admin' ||
                $role === 'moderator' ||
                $userId == $row['author']
            ) {
            ?>
               <a href="edit.php?id=<?php echo $row['id']; ?>">Edit</a> 
            <?php
            }

            if ($role === 'admin') {
            ?>
                <a href="delete.php?id=<?php echo $row['id']; ?>">Delete</a>
            <?php
            }
            ?>

            <hr>
        </li>

    <?php
    }
    ?>

</ul>