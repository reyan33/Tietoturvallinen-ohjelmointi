<!DOCTYPE html>
<html lang="fi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Uusi käyttäjä</title>
</head>
<body>
    <h1>Luo uusi käyttäjä</h1>

    <form action="create-user.php" method="post">
        <label for="username">Käyttäjänimi</label>
        <input type="text" name="username" id="username" required><br>

        <label for="realname">Oikea nimi</label>
        <input type="text" name="realname" id="realname" required><br>

        <label for="password">Salasana</label>
        <input type="password" name="password" id="password" required><br>

        <input type="submit" value="Luo käyttäjä">
    </form>

    <p><a href="index.php">Takaisin kirjautumiseen</a></p>
</body>
</html>