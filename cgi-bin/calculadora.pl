#!/usr/bin/perl

use strict;
use warnings;
use CGI;

my $calcular = CGI -> new;
my $operacion = $calcular->param('calcular');
my $resultado;

if ($operacion =~ /^d+\+\-\*\/]\d+*$/){
    $resultado=calcular($operacion);
    print "<h3>El resultado $operacion es $resultado<h3>";
} else {
    print "<h3>Hubo un error en el resultado, revise su operación.<h3>";
}

sub calcular{
    my ($operacion)=@_;
    my $resultado=0;
    #Realizamos primero las multiplicaciones y las divisiones
    while ($operacion =~ /(-?\d+)([\*\/])(\d+)/){
        my ($primero, $operador, $segundo) = ($1, $2, $3);
        if ($temporal eq (*)){
	    $temporal = $primero * $segundo;
	} else {
	    $temporal = $primero / $segundo;
	}
        $resultado+=$operacion;
    }

    #Realizamos después las sumas y las restas
    while ($operacion =~ /(-?\d+)([\+\-])(\d+)/){
        my ($primero, $operador, $segundo) = ($1, $2, $3);
	if ($temporal eq (+)){
	    $temporal = $primero + $segundo;
	} else {
	    $temporal = $primero - $segundo;
	}
        $resultado+=$operacion;
    }

    return $operacion;
}