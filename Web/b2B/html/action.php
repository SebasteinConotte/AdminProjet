<?php
$servername = "51.77.203.87";
$username = "admin";
$password = "0I47Q(bxRIUC";
$bdd = new PDO('mysql:host=51.77.203.87;dbname=db_ephec;charset=utf8', $username, $password);
$localite = $_POST['cat'];
$reponse = $bdd->prepare('SELECT * FROM CLIENT WHERE LOCALITE = ?');
$reponse->execute(array($localite));
$listeNom = '<style>table, td, tr {border: 1px solid black;border-collapse: collapse;padding: 15px;}</style><table><tr><th>NCLI</th><th>NOM</th><th>ADRESSE</th><th>LOCALITE</th><th>CAT</th><th>COMMANDES</th></tr>';
while ($donnees = $reponse->fetch()) {
    $listeNom .= '<tr><td>'.$donnees[0].'</td><td>'.$donnees[1].'</td><td>'.$donnees[2].'</td><td>'.$donnees[3].'</td><td>'.$donnees[4].'</td>';
    $test = $bdd->prepare('SELECT * FROM COMMANDE WHERE NCLI = ?');
    $test->execute(array($donnees[0]));
    $listeNom .= '<td>';
    while ($donneesTest = $test->fetch()) {
        $listeNom .= '<li>' . $donneesTest[0] .' '. $donneesTest[2] . '</li>';
    }
    $listeNom .= '</td></tr>';
}
$listeNom .= '</table>';
echo $listeNom;

