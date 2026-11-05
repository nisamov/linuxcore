<?php

// Una funcion es un bloque de código que se puede reutilizar en diferentes partes de un programa. Se definen con la palabra reservada function, seguida del nombre de la función y paréntesis. Dentro de los paréntesis se pueden definir parámetros que la función puede recibir. El código dentro de la función se ejecuta cuando se llama a la función por su nombre.
// Las funciones permiten realizar la misma tarea en diferentes partes del programa sin tener que escribir el mismo código varias veces, lo que facilita la lectura y el mantenimiento del código.
// Una funcion permite asignar un nombre a un bloque de código, lo que facilita su reutilización y mejora la legibilidad del código. Además, las funciones pueden recibir parámetros y devolver valores, lo que permite una mayor flexibilidad en su uso.

// Definición de una función
function saludar($nombre) {
    echo "Hola, " . $nombre . "!";
}

// Llamada a la función
saludar("Juan"); // Salida: Hola, Juan!

// Definición de una función que devuelve un valor
function sumar($a, $b) {
    return $a + $b;
}

// Llamada a la función y almacenamiento del valor devuelto
$resultado = sumar(5, 3);
echo "El resultado de la suma es: " . $resultado; // Salida: El resultado de la suma es: 8

// Una funcion puede devolver un valor utilizando la palabra reservada return. Cuando se llama a una función que devuelve un valor, se puede almacenar ese valor en una variable o utilizarlo directamente en una expresión.

function esPar($numero) {
    return $numero % 2 == 0;
}

// Llamada a la función y almacenamiento del valor devuelto
$numero = 4;
if (esPar($numero)) {
    echo $numero . " es un número par.";
} else {
    echo $numero . " es un número impar.";
}
