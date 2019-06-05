<?php
$servername = "51.77.203.87";
$username = "admin";
$password = "0I47Q(bxRIUC";
$bdd = new PDO('mysql:host=51.77.203.87;dbname=db_ephec;charset=utf8', $username, $password);
$req = $bdd->prepare('INSERT INTO CLIENT(NCLI, NOM, ADRESSE, LOCALITE, CAT, COMPTE) VALUES(:ncli, :nom, :adresse, :localite, :cat, :compte)');
$req->execute(array(
    'ncli'=> $_POST['ncli'],
    'nom' => $_POST['nom'],
    'adresse' => $_POST['adresse'],
    'localite' => $_POST['localite'],
    'cat' => null,
    'compte' => null
));
echo 'les données ont été ajoutée !';
