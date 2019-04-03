<?php
$servername = "85.10.205.173";
$username = "ephec_tp";
$password = "ephec0155";
$bdd = new PDO('mysql:host=85.10.205.173;dbname=db_ephec;charset=utf8', $username, $password);
//echo "Connected successfully";

$localite = $_POST['ville'];
$reponse = $bdd->prepare('SELECT * FROM CLIENT WHERE LOCALITE = ?');
$reponse->execute(array($localite));
$listeNom = '';
while ($donnees = $reponse->fetch()) {
    $listeNom .= '<li>'.$donnees['NOM'].'</li>';
}
$tab = array(
    'nom' => '<ul>'.$listeNom.'</ul>'
);

echo $tab['nom'];