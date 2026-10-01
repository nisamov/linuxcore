<?php
//ejemplo1
$suspensos = 5;
$partes = 3;
$expulsado = $suspensos >= 6 || $partes >= 3;
var_dump($expulsado); // devolverá true pues $partes es igual a 3, lo que cumple la condición de expulsión.
?>

<?php
// ejemplo2
$matriculado = true;
if ($matriculado) {
    echo "El alumno está matriculado";
} else {
    echo "El alumno no está matriculado";
}
?>

<?php
//ejemplo3
$matriculado2 = true;
$seguroescolar = false;

if ($matriculado2 && $seguroescolar) {
    echo "El alumno está matriculado y tiene seguro escolar";
} elseif ($matriculado2 && !$seguroescolar) {
    echo "El alumno está matriculado pero no tiene seguro escolar";
} else {
    echo "El alumno no está matriculado";
}
?>

<?php
//ejemplo4
//cuando se mezcla html y php, es necesario poner endif; al final de la estructura condicional
$a=10;
$b=20;
if ($a > $b):
    echo "A es mayor que B";
    ?>
    <p>A es mayor que B</p>
<?php
elseif ($a < $b):
    echo "A es menor que B";
    ?>
    <p>A es menor que B</p>
<?php
else:
    echo "A es igual a B";
    ?>
    <p>A es igual a B</p>
<?php
endif;