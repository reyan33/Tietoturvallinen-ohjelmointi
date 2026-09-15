<?php 
include 'connect.php';

/** @var PDO $conn */
?>

<ul>
    <hr>

    <?php
    $sql = "SELECT posts.*, users.realname, users.public_key
            FROM posts
            JOIN users ON posts.author = users.id;";

    try {
        $query = $conn->prepare($sql);
        $query->execute();
    } catch (PDOException $e) {
        die("Error: " . $e->getMessage());
    }

    $res = $query->fetchAll();

    foreach ($res as $row) {

        $role = $_SESSION['user']['role'];
        $userId = $_SESSION['user']['id'];

        $signatureStatus = null;

        if (!empty($row['signature'])) {

            $publicKey = $row['public_key'];

            if (!empty($publicKey)) {

                // Remove spaces and line breaks from the hexadecimal signature
                $signature = preg_replace('/\s+/', '', $row['signature']);

                // Convert hexadecimal signature into binary
                if (ctype_xdigit($signature) && strlen($signature) % 2 === 0) {
                    $decodedSignature = hex2bin($signature);
                } else {
                    $decodedSignature = false;
                }

                // Verify the signature using the author's public key
                if ($decodedSignature !== false) {

                    $result = openssl_verify(
                        $row['body'],
                        $decodedSignature,
                        $publicKey,
                        OPENSSL_ALGO_SHA256
                    );

                    if ($result === 1) {
                        $signatureStatus = 'valid';
                    } else {
                        $signatureStatus = 'invalid';
                    }

                } else {
                    $signatureStatus = 'invalid';
                }

            } else {
                $signatureStatus = 'invalid';
            }
        }
    ?>

        <li>
            <h3><?php echo htmlspecialchars($row['title']); ?></h3>

            <p>
                <i>
                    <?php
                    echo $row['posted'] . ' – ' . htmlspecialchars($row['realname']);
                    ?>
                </i>
            </p>

            <p><?php echo htmlspecialchars($row['body']); ?></p>

            <?php if ($signatureStatus === 'valid') { ?>
                <p>✅ Allekirjoitus on validi</p>
            <?php } ?>

            <?php if ($signatureStatus === 'invalid') { ?>
                <p>⚠️ Viestiä on muokattu</p>
            <?php } ?>

            <?php if (!empty($row['signature'])) { ?>

                <details>
                    <summary>Näytä allekirjoitustiedot</summary>

                    <p><strong>Julkinen avain:</strong></p>
                    <pre><?php echo htmlspecialchars($row['public_key']); ?></pre>

                    <p><strong>Allekirjoitus:</strong></p>
                    <pre><?php echo htmlspecialchars($row['signature']); ?></pre>
                </details>

            <?php } ?>

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