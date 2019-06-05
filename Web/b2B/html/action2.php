<?php
$servername = "51.77.203.87";
$username = "admin";
$password = "0I47Q(bxRIUC";
$bdd = new PDO('mysql:host=51.77.203.87;dbname=db_ephec;charset=utf8', $username, $password);
$localite = $_POST['cat'];
$bdd->exec('INSERT INTO CLIENT(NCLI, NOM, ADRESSE, LOCALITE, CAT, COMPTE)VALUES($_POST["ncli"],$_POST["nom"],$_POST["adresse"],$_POST["localite"],NULL,NULL)');

echo 'les données ont été ajoutée !';
