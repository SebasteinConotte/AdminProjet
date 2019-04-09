<?php

$servername = "85.10.205.173";
$username = "ephec_tp";
$password = "ephec0155";
$bdd = new PDO('mysql:host=85.10.205.173;dbname=db_ephec;charset=utf8', $username, $password);
$reponse = $bdd->query('SELECT distinct LOCALITE FROM CLIENT');
$listeVilles = array();
while ($donnees = $reponse->fetch()) {
    $listeVilles[] = $donnees['LOCALITE'];
}
?>
<html>
<head>
    <title>Nom et numéro de téléphone des membres</title>
</head>
<body>
<form action="action.php" method="post">
    <p>Ville de recherche:
        <select name="ville" size="1">
            <?php foreach ($listeVilles as $ville): ?>
                <option> <?= $ville ?> </option>
            <?php endforeach ?>
        </select></p>
    <p><input type="submit" value="OK"></p>
</form>
</body>
</html>
