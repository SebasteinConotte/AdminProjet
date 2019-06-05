<?php
$servername = "51.77.203.87";
$username = "admin";
$password = "0I47Q(bxRIUC";
$bdd = new PDO('mysql:host=51.77.203.87;dbname=db_ephec;charset=utf8', $username, $password);
$req = $bdd->prepare('INSERT INTO CLIENT(NCLI, NOM, ADRESSE, LOCALITE, CAT, COMPTE) VALUES(?,?,?,?,?,?)');
$req->execute(array(
    $_POST['ncli'],
    $_POST['nom'],
    $_POST['adresse'],
    $_POST['localite'],
    NULL,
    0
));
echo 'les données ont été ajoutée !';
