// Al asignar (int) a una variable, se convierte a entero, eliminando la parte sobrante (decimal, texto, etc.) y devolviendo el valor entero.

$nota=7.50;
echo "La nota es: " . (int)$nota;
//devolvera 7

$valor="18 euros";
echo "El valor es: " . (int)$valor;
//devolvera 18

$altura="170";
echo "La altura es: " . (int)$altura;
//devolvera 170 -- sigue igual