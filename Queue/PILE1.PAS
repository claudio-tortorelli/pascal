Program Gestione_pile_puntatori (input,output);
uses crt,dos;
{const}
type lista=^nodo;
     nodo=record
          key:integer;
          next:lista;
          end;
     pila=lista;
var stack:pila;
    ins,cont,scelta,sceincod,x:integer;

Procedure Creavuota(var stack:pila);
begin
     clrscr;
     stack:=nil;
     writeln('Ho creato una nuova pila.');
     readln;
end;

Function Empty(stack:pila):boolean;
begin
     if stack=nil then empty:=true;
end;

Procedure Push(var stack:pila; x:integer);
var temp:lista;
begin
     if empty(stack)=true then begin
                                new(temp);
                                temp^.key:=x;
                                temp^.next:=nil;
                                stack:=temp;
                                end
                           else begin
                                new (temp);
                                temp^.key:=x;
                                temp^.next:=stack;
                                stack:=temp;
                                end;
end;

Procedure Pop (var stack:pila; var x:integer);
begin
     if empty(stack)=true then begin
                               clrscr;
                               gotoxy(10,5);
                               writeln ('La Pila Š gi… vuota');
                               readln;
                               end
                          else begin
                               x:=stack^.key;
                               stack:=stack^.next;
                               end;
end;

Procedure Stampa_pila (stack:pila);
begin
     CLRSCR;
     writeln('Cresce ------>');
     while stack<>nil do begin
                         write (stack^.key,' ');
                         stack:=stack^.next;
                         end;
     readln;
end;

{BODY}
Begin
clrscr;
       repeat
                   clrscr;
                   gotoxy (10,5);
                   writeln('GESTIONE DELLE PROCEDURE SULLE PILE CON PUNTATORI');
                   gotoxy (10,6);
                   WRITEln('_________________________________________________');
                   gotoxy (10,8);
                   writeln ('1:CREAVUOTA');
                   gotoxy (10,9);
                   writeln ('2:EMPTY');
                   gotoxy (10,10);
                   writeln ('3:PUSH');
                   gotoxy (10,11);
                   writeln ('4:POP');
                   gotoxy (10,12);
                   writeln ('5:FILTRO P. - Non attiva');
                   gotoxy (10,13);
                   writeln ('6:STAMPA PILA');
                   gotoxy (10,14);
                   writeln ('0:ESCI');
                   readln(scelta);
                   case scelta of
                               0:exit;
                               1:Creavuota(stack);
                               2:begin
                                 clrscr;
                                 if empty(stack)=true then writeln ('La Pila Š vuota')
                                                    else writeln ('La pila ha almeno un elemento');
                                 readln;
                                 end;
                               3:Begin
                                      clrscr;
                                      gotoxy(10,5);
                                      write('1:Inserisci 5 elementi random in pila');
                                      gotoxy (10,7);
                                      write('2:Immetti un intero da inserire in pila ');
                                      readln(sceincod);
                                      if sceincod=2 then begin
                                                         readln (ins);
                                                         push(stack,ins);
                                                         end;
                                      if sceincod=1 then begin
                                                         randomize;
                                                         for cont:=1 to 5 do begin
                                                                            clrscr;
                                                                            ins:=random(10);
                                                                            push(stack,ins);
                                                                            end; {for}
                                                         end;
                                                         {readln;}
                                 end;
                               4:begin
                                       pop(stack,x);
                                       clrscr;
                                       gotoxy (10,5);
                                       write('L''elemento estratto dalla pila Š ',x);
                                       readln;
                                 end;
                                 5:begin
                                   {Filtro_P (cod.testa,newcod.testa);
                                   stampa_coda (cod);
                                   stampa_coda (newcod);}
                                   end;
                                 6:Stampa_pila(stack);
                                 end; {case}
                   until scelta=0;
readln


end.{BODY}