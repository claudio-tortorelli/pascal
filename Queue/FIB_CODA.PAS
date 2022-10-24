program Fibonacci_ricorsivo_di_coda (input,output);
uses crt,dos;
const a=1; {costanti per fastfib}
      b=1;
      k=3;
{type}
var x,numero,scelta:longint;
    risultato,accum:longint;

{Funzione che restituisce l'n-esimo numero della successione di Fibonacci.
Rispetto alla versione seguente Š semplicemente ricorsiva, con complessit…
esponenziale. questo vuol dire che per valori abbastanza grandi di x
la memoria (stack) non pu• pi— gestire la ricorsione e si ha overflow.
P.s. gi… si pu• riscontrare differenza per il numero 30}
Function Fibonacci1(x:longint):longint;
begin
     if x=0 then Fibonacci1:=0
            else if x=1 then Fibonacci1:=1
                        else fibonacci1:=fibonacci1(x-1)+Fibonacci1(x-2);
end;

{Procedura per la funzione Fibonacci ricorsiva di coda: nonostante che
la procedura possa richiamare se stessa pi— volte, essendo di coda non
occupa lo stack (perchŠ viene trasformata in un normale ciclo iterativo).
In questa maniera la memoria non viene occupata per ogni ambiente chiamante
e si evitano gli overflow della prima versione( o meglio si evitano per
numeri bassi).
Questo grazie alla variabile temporanea temp e alla variabile accumulatrice
accum. Una volta che k>x la funzione Fibonacci Š calcolata e restituita in
accum; i casi base sono trattati a parte.      }

{k=3, a,b=1}
Procedure fastfib (a,b,k,x:longint;var accum:longint);
var temp:longint;
begin
     if x=0 then accum:=0
            else if x=1 then accum:=1
                        else begin
                             if k<=x then begin
                                          temp:=a+b;
                                          k:=k+1;
                                          accum:=temp;
                                          fastfib (b,temp,k,x,accum);
                                          end;
                             end;
end;

Procedure fastfib2 (a:longint;b:longint;x:longint;var accum:longint);
var temp:longint;
begin
     if x=0 then accum:=0
            else if x=1 then accum:=1
                        else begin
                             temp:=a+b;
                             accum:=temp;
                             fastfib2 (b,temp,x-1,accum);
                             end;
end;

{BODY}
Begin
clrscr;
repeat
                   clrscr;
                   gotoxy (10,5);
                   writeln('PROCEDURE FIBONACCI');
                   gotoxy (10,6);
                   WRITEln('___________________________________');
                   gotoxy (10,8);
                   writeln ('1:FIBONACCI RICORSIVO');
                   gotoxy (10,9);
                   writeln ('2:FIBONACCI RICORSIVO DI CODA');
                   gotoxy (10,11);
                   writeln ('0:ESCI');
                   readln(scelta);
                   case scelta of
                               0:exit;
                               1:BEGIN
                                      clrscr;
                                      gotoxy (10,5);
                                      writeln('Immetti il numero della successione da calcolare');
                                      readln(numero);
                                      risultato:=fibonacci1(numero);
                                      gotoxy (10,6);
                                      writeln('Il risultato Š ',risultato);
                                      readln;
                                 end;
                               2:begin
                                      clrscr;
                                      gotoxy (10,5);
                                      writeln('Immetti il numero della successione da calcolare');
                                      readln(numero);
                                      fastfib(a,b,k,numero,accum);
                                      risultato:=accum;
                                      gotoxy (10,6);
                                      writeln('Il risultato Š ',risultato);
                                      readln;
                                 end;

                               end; {case}
                   until scelta=0;

end.{BODY}