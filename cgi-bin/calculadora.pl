#!/usr/bin/perl

use strict;
use warnings;
use CGI;

my $calcular = CGI -> new;
print $calcular->header('text/html; charset=UTF-8');
print $calcular->start_html('Resultado');
my $operacion = $calcular->param('calcular');
my $resultado;

if ($operacion =~ /^-?\d+(\.\d+)?([\+\-\*\/]\d+(\.\d+)?)*$/){
    $resultado=calcular($operacion);
    print "<h1>El resultado de $operacion es $resultado</h1>";
} else {
    print "<h1>Hubo un error en el resultado, revise su operación.</h1>";
}

print $calcular -> end_html;

sub calcular{
    my ($operacion) = @_;
    my $resultado;
    $resultado=sumar(multiplicar($operacion));
    return $resultado;
}

sub multiplicar{
    my ($operacion) = @_;

    while ($operacion =~ /(-?\d+)(\.\d+)?([\*\/])(-?\d+)(\.\d+)?/) {
        my ($primero, $operador, $segundo) = ($1, $3, $4);
        if (defined $2){
            $primero.=$2;
        }
        if (defined $5){
            $segundo.=$5;
        }
        my $temporal = ($operador eq '*') ? $primero * $segundo : $primero / $segundo;
        $operacion =~ s/\Q$primero$operador$segundo\E/$temporal/;
    }

    return $operacion;
}

sub sumar{
    my ($operacion)=@_;

    while ($operacion =~ /(-?\d+)(\.\d+)?([\+\-])(-?\d+)(\.\d+)?/) {
        my ($primero, $operador, $segundo) = ($1, $3, $4);
        if (defined $2){
            $primero.=$2;
        }
        if (defined $5){
            $segundo.=$5;
        }
        my $temporal = ($operador eq '+') ? $primero + $segundo : $primero - $segundo;
        $operacion =~ s/\Q$primero$operador$segundo\E/$temporal/;
    }

    return $operacion;
}