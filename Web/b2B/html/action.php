<?php
$servername = "51.77.203.87";
$username = "admin";
$password = "0I47Q(bxRIUC";
$bdd = new PDO('mysql:host=51.77.203.87;dbname=db_ephec;charset=utf8', $username, $password);
$localite = $_POST['cat'];
$reponse = $bdd->prepare('SELECT * FROM CLIENT WHERE LOCALITE = ?');
$reponse->execute(array($localite));
$listeNom = '<table><tr><th>NCLI</th><th>NOM</th><th>ADRESSE</th><th>LOCALITE</th></tr>';
while ($donnees = $reponse->fetch()) {
    $listeNom .= '<tr><td>'.$donnees[0].'</td><td>'.$donnees[1].'</td><td>'.$donnees[2].'</td><td>'.$donnees[3].'</td></tr>';
}
$listeNom .= '</table>';
?>
<html>
<head>
    <style>
        table, td, tr {border: 1px solid black;border-collapse: collapse;padding: 15px;}
    </style>
</head>
<body>
<?= $listeNom ?>

</body>
</html>