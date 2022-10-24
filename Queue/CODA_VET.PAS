program Coda_vettore (input,output);
uses crt,dos;
const maxvet=4;
type codavet=record
             a:array[0..maxvet] of integer;
             front,rear:integer;
             end;
var coda:codavet;
    x,scelta,numero:integer;

{In questo programma si simula la gestione di una coda con un vettore di 5
elementi. La particolarit… Š che la coda si pu• saturare e che per evitare
che dopo tot cancellazioni risulti piena anche se non lo Š si considera il
vettore come circolare.}

Procedure Creavuota(var coda:codavet);
begin
     for x:=0 to maxvet do coda.a[x]:=0;
     coda.front:=0;
     coda.rear:=0;
end;

Function empty (coda:codavet):boolean;
begin
     if (coda.front=coda.rear) and (coda.a[coda.front]=0) then empty:=true
end;

Function Full(coda:codavet):boolean;
begin
     if (coda.a[coda.front]<>0) and (coda.front=coda.rear) then full:=true;
end;

Procedure Incoda(var coda:codavet;x:integer);
begin
     if full(coda)= true then begin
                              clrscr;
                              write('La coda Š piena');
                              readln;
                              end
                         else begin
                              coda.a[coda.front]:=x;
                              if coda.front=maxvet then coda.front:=0
                                                   else coda.front:=coda.front+1;
                              end;
end;

Procedure Fuoricoda(var coda:codavet;var x:integer);
begin
     if empty(coda)=true then begin
                              clrscr;
                              write ('La coda Š gi… vuota');
                              readln;
                              end
                         else begin
                              x:=coda.a[coda.rear];
                              coda.a[coda.rear]:=0;
                              if coda.rear=maxvet then coda.rear:=0
                                                  else coda.rear:=coda.rear+1;
                              end;
end;

{PROCEDURA STAMPA CODA}
{Data una coda stampa la successione dei nodi da sinistra a destra se la
coda Š non vuota, altrimenti d… un messaggio di errore}
Procedure Stampa_coda (cod:codavet);
var Color:integer;
begin
     randomize;
     color:=random(15)+1;{per differenziare le code}
     textcolor(color);
     CLRSCR;
     writeln('Cresce ------>');
     if empty(cod)=true then writeln('CODA VUOTA')
                        else  begin
                              for x:=0 to maxvet do begin
                                                write (cod.a[cod.rear],' ');
                                                if cod.rear=maxvet then cod.rear:=0
                                                                    else cod.rear:=cod.rear+1;
                                                          end;
                              end;
                           readln;
     textcolor(15);
end;



{BODY}
Begin
clrscr;
repeat
                   clrscr;
                   gotoxy (10,5);
                   writeln('PROCEDURE GESTIONE DI UNA CODA TRAMITE VETTORI');
                   gotoxy (10,6);
                   writeln('Max vettore coda=5');
                   gotoxy (10,7);
                   WRITEln('___________________________________');
                   gotoxy (10,8);
                   writeln ('1:EMPTY (dice se la coda Š vuota)');
                   gotoxy (10,9);
                   writeln ('2:FULL (dice se la coda Š piena)');
                   gotoxy (10,11);
                   writeln('3:INCODA (mette un elemento in fondo alla coda)');
                   gotoxy (10,12);
                   writeln('4:FUORICODA (Estrae un elemento dalla testa della coda)');
                   gotoxy (10,14);
                   writeln ('5:CREAVUOTA');
                   gotoxy (10,15);
                   writeln ('6:STAMPA CODA');
                   gotoxy (10,16);
                   writeln ('0:ESCI');
                   readln(scelta);
                   case scelta of
                               0:exit;
                               3:BEGIN
                                      clrscr;
                                      gotoxy (10,5);
                                      writeln('Immetti il numero da inserire in coda');
                                      readln(numero);
                                      incoda (coda,numero);
                                 end;
                               4:begin
                                      clrscr;
                                      gotoxy (10,5);
                                      fuoricoda (coda,numero);
                                      writeln('L''ultimo numero estratto dalla coda Š ',numero);
                                      readln;
                                 end;
                               1:begin
                                 clrscr;
                                 if empty(coda)=true then write('La coda Š vuota')
                                                     else write ('la coda contiene almeno un elemento');

                                 readln;
                                 end;
                               2:begin
                                 clrscr;
                                 if full(coda)=true then write('La coda Š piena')
                                                    else write('La coda non Š piena');
                                 readln;
                                 end;
                               5:Creavuota(coda);
                               6:stampa_coda(coda);
                               end; {case}
                   until scelta=0;
end.{BODY}