<?php
$servername = "51.77.203.87";
$username = "admin";
$password = "0I47Q(bxRIUC";
$bdd = new PDO('mysql:host=51.77.203.87;dbname=db_ephec;charset=utf8', $username, $password);
$reponse = $bdd->query('SELECT distinct LOCALITE FROM CLIENT');
$listeLocalite = array();
while ($donnees = $reponse->fetch()) {
    $listeLocalite[] = $donnees['LOCALITE'];
}
?>
<html>
<head>
    <title>Zone de recherches</title>
</head>
<body>
<form action="action.php" method="post">
    <p>Sélectionnez la zone de recherche :
        <select name="cat" size="1">
            <?php foreach ($listeLocalite as $cat): ?>
                <option> <?= $cat ?> </option>
            <?php endforeach ?>
        </select></p>
    <p><input type="submit" value="OK"></p>
</form>
</body>
</html>
