<?php
header('Access-Control-Allow-Origin: '.getenv('CORS_ALLOW_ORIGIN')); 
header('Access-Control-Allow-Credentials: true'); 
header('Access-Control-Allow-Headers: origin, content-type, accept, authorization'); 
header('Access-Control-Allow-Methods: GET, POST, PUT, DELETE, OPTIONS, HEAD'); 

// case insensitive with regex

//select annotation_name
//from annotation_names
//where annotation_name ~* '.*a1.*'
//LIMIT 20

include 'sqlConnection.php';

// get the row which contains all the values of the passed annotation
$annotation_name=".*".$_GET["annotation_name"].".*";
$stmt = $pdo->prepare("SELECT annotation_name FROM genomic_annotations.annotation_names WHERE annotation_name ~* ? LIMIT ?");
$stmt->bindValue(1, $annotation_name, PDO::PARAM_STR);
$stmt->bindValue(2, $_GET["limit"], PDO::PARAM_STR);
$stmt->execute();

// In json format return the list of annotation names
$annotationList = "";
while ($row = $stmt->fetch()) {
    $annotationList .= "\"$row[0]\",";
}
// drop the last comma and concatenate in json format
echo "[" . substr($annotationList, 0, -1) . "]";
?>