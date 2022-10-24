program Gestione_code (input,output); {Gestisce le varie procedure sulle}
                                      {code considerate come liste}
uses crt,dos;
type lista=^nodo;       {definisce il tipo coda}
     nodo= record
           key:integer;
           next:lista;
           end;
     coda= record
           testa,fondo:lista;
           end;

var scelta,ins,x,sceincod,cont:integer;
    cod,newcod:coda;

{PROCEDURA CREAVUOTA}
{inizializza una coda e la restituisce}
Procedure Creavuota (var cod:coda);
begin
     clrscr;
     cod.testa:=nil;
     cod.fondo:=nil;
     GOTOXY (10,5);
     write('Ho inizializzato una nuova coda.');
     readln;
end;

{PROCEDURA EMPTY}
{Controlla se la coda passata come parametro Š vuota restituendo il valore
booleano in empty}
Function Empty (cod:coda):boolean;
begin
     if cod.testa=nil then empty:=true;
end;

{PROCEDURA EMPTY PER LISTA}
{Come sopra per• effettual la verifica su una lista}
Function Empty_LISTA (Testa:lista):boolean;
begin
     if testa=nil then empty_lista:=true;
end;

{PROCEDURA INCODA}
{Data una coda e un elemento, restituisce la coda originaria con l'elemento
aggiunto in fondo}
Procedure Incoda (var cod:coda; x:integer);
var temp:lista;
begin
     clrscr;
     if empty(cod)=true then begin
                        new (cod.testa);
                        cod.testa^.key:=x;
                        cod.testa^.next:=nil;
                        cod.fondo:=cod.testa;
                        end
                   else begin
                        new (temp);
                        cod.fondo^.next:=temp;
                        temp^.key:=x;
                        temp^.next:=nil;
                        cod.fondo:=temp;
                        end;
     GOTOXY (10,5);
     writeln('Ho aggiunto un elemento');
end;

{PROCEDURA FUORI CODA}
{Data una coda non vuota, estrae e restituisce l'elemento in testa alla coda
e la coda stessa con l'elemento cancellato}
Procedure Fuoricoda(var Cod:coda; var x:integer);
begin
     clrscr;
     if empty(cod)=true then begin
                        writeln ('ERRORE!! CODA VUOTA');
                        readln;
                        end
                   else begin
                        x:=cod.testa^.key;
                        if cod.testa=cod.fondo then begin
                                                    cod.testa:=nil;
                                                    cod.fondo:=nil;
                                                    end
                                               else cod.testa:=cod.testa^.next;
                        end;
     GOTOXY (10,5);
     write('Ho estratto il primo elemento');
     readln;
end;

{PROCEDURA STAMPA CODA}
{Data una coda stampa la successione dei nodi da sinistra a destra se la
coda Š non vuota, altrimenti d… un messaggio di errore}
Procedure Stampa_coda (cod:coda);
var Color:integer;
begin
     randomize;
     color:=random(15)+1;{per differenziare le code}
     textcolor(color);
     clrscr;
     CLRSCR;
     writeln('Cresce ------>');
     if empty(cod)=true then writeln('CODA VUOTA');
     while cod.testa<>nil do  begin
                              write (cod.testa^.key,' ');
                              cod.testa:=cod.testa^.next;
                              end;
                              readln;
     textcolor(15);
end;

{PROCEDURA FILTRO_P}
{Prende la coda in entrata e cancella tutti gli elementi che soddisfano
la propriet… P, restituendo una nuova coda con quegli stessi elementi
e la vecchia coda senza gli elementi estratti. La procedura lavora sulle
liste, ovvero scorre le due code considerando il solo puntatore testa
di ogni coda, che Š appunto una lista semplice}
Procedure Filtro_P (var testa:lista; var newcod:lista);

{Sottoprocedura P, testa se un elemento Š pari}
Function P(x:integer):boolean;
begin
     if (x mod 2)=0 then p:=true;
end;

begin
     if empty_lista(testa)=true then begin
                                     newcod:=nil;
                                     end
                                else begin
                                     if p(testa^.key)=true then begin
                                                                newcod:=testa;
                                                                testa:=testa^.next;
                                                                newcod^.next:=nil;
                                                                filtro_p(testa,newcod^.next);
                                                                end
                                                           else begin
                                                                filtro_p (testa^.next,newcod);
                                                                end;
                                end;
end;{procedura}

{BODY}
BEGIN
clrscr;
       repeat
                   clrscr;
                   gotoxy (10,5);
                   writeln('GESTIONE DELLE PROCEDURE SULLE CODE');
                   gotoxy (10,6);
                   WRITEln('___________________________________');
                   gotoxy (10,8);
                   writeln ('1:CREAVUOTA');
                   gotoxy (10,9);
                   writeln ('2:EMPTY');
                   gotoxy (10,10);
                   writeln ('3:IN CODA');
                   gotoxy (10,11);
                   writeln ('4:FUORICODA');
                   gotoxy (10,12);
                   writeln ('5:FILTRO P.');
                   gotoxy (10,13);
                   writeln ('6:STAMPA CODA');
                   gotoxy (10,14);
                   writeln ('0:ESCI');
                   readln(scelta);
                   case scelta of
                               0:exit;
                               1:Creavuota(cod);
                               2:begin
                                 clrscr;
                                 if empty(cod)=true then writeln ('La Coda Š vuota')
                                                    else writeln ('La coda ha almeno un elemento');
                                 readln;
                                 end;
                               3:Begin
                                      clrscr;
                                      gotoxy(10,5);
                                      write('1:Inserisci 5 elementi random in coda');
                                      gotoxy (10,7);
                                      write('2:Immetti un intero da inserire in coda ');
                                      readln(sceincod);
                                      if sceincod=2 then begin
                                                         readln (ins);
                                                         Incoda(cod,ins);
                                                         end;
                                      if sceincod=1 then begin
                                                         randomize;
                                                         for cont:=1 to 5 do begin
                                                                            ins:=random(10);
                                                                            Incoda(cod,ins);
                                                                            end; {for}
                                                         end;
                                                         {readln;}
                                 end;
                               4:begin
                                       Fuoricoda(cod,x);
                                       clrscr;
                                       gotoxy (10,5);
                                       write('L''elemento estratto dalla coda Š ',x);
                                       readln;
                                 end;
                                 5:begin
                                   Filtro_P (cod.testa,newcod.testa);
                                   stampa_coda (cod);
                                   stampa_coda (newcod);
                                   end;
                                 6:Stampa_coda(cod);
                                 end; {case}
                   until scelta=0;
readln
END. {BODY}



