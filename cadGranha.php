<?php

ini_set('display_errors', 1);
ini_set('display_startup_errors', 1);
error_reporting(E_ALL);

// Definindo o tipo de conteúdo como JSON
header('Content-Type: application/json');

// Inclui a conexão compartilhada com o banco de dados
require_once 'conexao.php';
$con->set_charset('utf8');

// Lê a entrada JSON bruta
$jsonParam = json_decode(file_get_contents('php://input'), true);

if (!$jsonParam) {
    echo json_encode(['success' => false, 'message' => 'Dados JSON inválidos ou ausentes.']);
    exit;
}

// Extrai e valida dados do JSON
$nomeGranja       = trim($jsonParam['nomeGranja'] ?? '');
$latitude         = trim($jsonParam['Latitude'] ?? '');
$longitude        = trim($jsonParam['Longitude'] ?? '');
$nomeProprietario = trim($jsonParam['nomeProprietario'] ?? '');
$silos            = intval($jsonParam['Silos'] ?? 0);

// Validação de campos obrigatórios
if (empty($nomeGranja) || empty($latitude) || empty($longitude) || empty($nomeProprietario) || $silos <= 0) {
    echo json_encode(['success' => false, 'message' => 'Campos obrigatórios ausentes ou inválidos.']);
    exit;
}

// Prepara e vincula a consulta SQL
$stmt = $con->prepare(
    "INSERT INTO Granja (nomeGranja, Latitude, Longitude, nomeProprietario, Silos)
     VALUES (?, ?, ?, ?, ?)"
);

if (!$stmt) {
    echo json_encode(['success' => false, 'message' => 'Erro ao preparar a consulta: ' . $con->error]);
    exit;
}

$stmt->bind_param('ssssi', $nomeGranja, $latitude, $longitude, $nomeProprietario, $silos);

// Executa e retorna o resultado
if ($stmt->execute()) {
    echo json_encode(['success' => true, 'message' => 'Granja inserida com sucesso!', 'idGranja' => $stmt->insert_id]);
} else {
    echo json_encode(['success' => false, 'message' => 'Erro ao inserir granja: ' . $stmt->error]);
}

$stmt->close();
$con->close();

?>
