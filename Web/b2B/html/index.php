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
<form action="action2.php" method="post">
    <p>
        INSERTION nouvelles données :<br>
        <label for="ncli">NCLI:</label>
        <input id="ncli" name="ncli" type="text" required><br>
        <label for="nom">Nom</label>
        <input id="nom" name="nom" type="text" required>
        <label for="adresse">Adresse</label>
        <input id="adresse" name="adresse" type="text" required>
        <label for="localite">Mot de passe</label>
        <input id="localite" name="localite" type="text" required>
    </p>
    <p><input type="submit" value="insérer"></p>
</form>

</body>
</html>
