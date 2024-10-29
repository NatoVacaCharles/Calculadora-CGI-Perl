#!/usr/bin/perl

use strict;
use warnings;
use CGI;

my $calcular = CGI -> new;
my $operacion = $calcular->param('calcular');
my $resultado;

if ($operacion =~ /^-?\d+([\+\-\*\/]\d+)*$/){
    $resultado=calcular($operacion);
    print "<h3>El resultado $operacion es $resultado<h3>";
} else {
    print "<h3>Hubo un error en el resultado, revise su operación.<h3>";
}

sub calcular{
    my ($operacion)=@_;

    #Realizamos primero las multiplicaciones y las divisiones
    while ($operacion =~ /(-?\d+)([\*\/])(\d+)/){
        my ($primero, $operador, $segundo) = ($1, $2, $3);
        my $temporal = ($operador eq '*') ? $primero * $segundo : $primero / $segundo;
        $operacion =~ s/\Q$primero$operador$segundo\E/$temporal/;
    }

    #Realizamos después las sumas y las restas
    while ($operacion =~ /(-?\d+)([\+\-])(\d+)/){
        my ($primero, $operador, $segundo) = ($1, $2, $3);
	my $temporal = ($operador eq '+') ? $primero + $segundo : $primero - $segundo;
        $operacion =~ s/\Q$primero$operador$segundo\E/$temporal/;
    }

    return $operacion;
}