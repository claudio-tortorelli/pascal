unit liste;

interface
uses crt,dos;
type tipokey=integer;
     lista=^nodo;       {definisce il tipo catena}
     nodo= record
           key:tipokey;
           next:lista;
           end;

Procedure Crea_nuova_lista (var catena:lista);
Procedure Insert (var catena:lista; x:tipokey);
Procedure Stampa_lista (catena:lista);
Procedure Fuori_lista (var catena:lista; var x:tipokey);
Function Dividi_pari (catena:lista):lista;
Procedure Dividiin2 (listOrig:lista; var l1,l2:lista);
Procedure Fondi_liste_ord(l1,l2:lista;var fusio:lista);
Procedure reverse_lista(listorig:lista;var newlist:lista);
Procedure Mergesort (var catena:lista);
Function Contanodi_lista(catena:lista):integer;
Function Cons (nodo1,nodo2:lista):lista;
function Append_liste (l1,l2:lista):lista;
Procedure del_int_lista (var l1:lista);
Procedure ListaOrd(ll:lista;var ris:boolean);
Procedure Del_Y (var L:lista;y,i:integer);

var ris:boolean;

{------------------------}
IMPLEMENTATION

{                               COMPITO 17/9/98
1) Procedura che data una lista L, una chiave Y e un intero i>0 cancella
dalla lista 'i-esima occorrenza di Y in L se esiste}
Procedure Del_Y (var L:lista;y,i:integer);
var temp:integer; l1,l2:lista;
begin
     temp:=0;
     if l<>nil then
                begin
                 l1:=l;
                 l2:=l^.next;
                 if (l1^.key=y) and (i=1) then l:=l2
                    else
                        begin
                          if (l1^.key=y) then temp:=1;
                          while l2<>nil do
                                          begin
                                            if l2^.key=y then temp:=temp+1;
                                            IF TEMP=I then l1^.next:=l2^.next;
                                            l1:=l1^.next;
                                            l2:=l2^.next;
                                          end;
                        end;
                 end;
end;


{                               COMPITO 11/7/97
Procedura che data una lista restituisce ris=true se la lista risulta
ordinata in ordine crescente. }
{ris=false}
Procedure ListaOrd(ll:lista;var ris:boolean);
begin
     if ll<>nil then
                  begin
                    if ll^.next<>nil then
                                       if ll^.key<ll^.next^.key then listaord(ll^.next,ris)
                                                                else
                                                                  ris:=false
                                     else
                                         ris:=true;
                  end
                else ris:=false;
end;

Procedure Crea_nuova_lista (var catena:lista);
var temp:lista;
begin
     new(temp);
     temp:=nil;
     catena:=temp;
end;

{inserisce un elemento nella testa della lista e ne aggiorna il puntatore}
Procedure Insert (var catena:lista; x:tipokey);
var temp:lista;
begin
  if catena=nil then begin
                    new (temp);
                    temp^.key:=x;
                    temp^.next:=nil;
                    catena:=temp;
                    end
               else begin
                    new (temp);
                    temp^.key:=x;
                    temp^.next:=catena;
                    catena:=temp;
                    end;
end;

Procedure Stampa_lista (catena:lista);
begin
     writeln;
     if catena=nil then begin
                       write('La lista Š vuota!');
                       end
                  else begin
                       while catena<>nil do begin
                                            write(catena^.key,' ');
                                            catena:=catena^.next;
                                            end;
                       end;
readln;
end;

{estrae il primo elemento della lista non vuota}
Procedure Fuori_lista (var catena:lista; var x:tipokey);
begin
     if catena=nil then begin
                       clrscr;
                       write('La lista Š vuota!');
                       end
                  else begin
                       x:=catena^.key;
                       catena:=catena^.next;
                       clrscr;
                       write('Il numero estratto dalla lista Š ',x);
                       end;
readln;
end;

{Restituisce il puntatore alla lista degli elementi di ordine pari
mentre quello alla lista originaria punta ai dispari. Non Š ricorsivo di coda}
Function Dividi_pari (catena:lista):lista;
var temp:lista;
begin
     if (catena=nil) and (catena^.next=nil) then dividi_pari:=nil
                  else begin
                       temp:=catena^.next;
                       catena^.next:=temp^.next;
                       temp^.next:=dividi_pari(temp^.next);
                       dividi_pari:=temp;
                       end;
end;

{Procedura che divide la lista originale in due sottoliste che puntano
agli elementi di ordine pari e dispari. La lista originaria si perde (a meno
di non salvarla prima della procedura). E' ricorsivo di coda}
Procedure Dividiin2 (listOrig:lista; var l1,l2:lista);
begin
   if listorig=nil then begin
                         l1:=nil; l2:=nil;
                       end
                  else if listorig^.next=nil then begin
                                               l1:=listorig;
                                               l2:=nil;
                                               end
                                          else begin
                                               l1:=listorig;
                                               l2:=listorig^.next;
                                               dividiin2(listorig^.next^.next,l1^.next,l2^.next);
                                               end;
end;

{Procedura che fonde due liste in maiera ordinata}
Procedure Fondi_liste_ord(l1,l2:lista;var fusio:lista);
begin
     if l1=nil then fusio:=l2
               else if l2=nil then fusio:=l1
                              else begin
                                   if l1^.key<=l2^.key then
                                                      begin
                                                          fusio:=l1;
                                                          {fusio^.next:=nil;}
                                                          fondi_liste_ord(l1^.next,l2,fusio^.next);
                                                      end
                                                      else
                                                      begin
                                                           fusio:=l2;
                                                           {fusio^.next:=nil;}
                                                           fondi_liste_ord(l1,l2^.next,fusio^.next);
                                                      end;
                                   end;
end;

Function Cons (nodo1,nodo2:lista):lista;
begin
     nodo1^.next:=nodo2;
     cons:=nodo1;
end;

function Append_liste (l1,l2:lista):lista;
begin
     if l1=nil then append_liste:=l2
               else if l2=nil then append_liste:=l1
                              else begin
                                   append_liste:=cons (l1,append_liste (l1^.next,l2));
                                   end;
end;


{Procedura che data una lista restituisce il puntatore all'inversa. Fatta come
ricorsiva di coda (altrimenti come function Š pi— semplice)}
Procedure reverse_lista(listorig:lista;var newlist:lista);
var temp:lista;
begin
     if listorig<>nil then begin
                           new(temp);
                           temp^.key:=listorig^.key;
                           temp^.next:=newlist;
                           newlist:=temp;
                           reverse_lista(listorig^.next,newlist);
                           end
                      else if newlist=nil then begin
                                               write('La lista oggetto Š vuota!');
                                               readln;
                                               end;
end;



Procedure Mergesort (var catena:lista);
var l1,l2,altralista:lista;
begin
     if (catena<>nil) and (catena^.next<>nil) then begin
                                                 dividiin2(catena,l1,l2);
                                                 mergesort(l1);
                                                 mergesort(l2);
                                                 fondi_liste_ord (l1,l2,altralista);
                                                 catena:=altralista;
                                                 end;
end;

Function Contanodi_lista(catena:lista):integer;
var temp:integer;
begin
     temp:=0;
     while catena<>nil do begin
                          temp:=temp+1;
                          catena:=catena^.next;
                          end;
     contanodi_lista:=temp;
end;

Procedure del_int_lista (var l1:lista);
var m,n,cont,numnodi,x:tipokey;
    temp1,temp2,temp3:lista;
begin
     if l1<>nil then begin
                     writeln ('Immetti i due estremi (esclusi) dell''intervallo da cancellare');
                     readln(m,n);
                     numnodi:=contanodi_lista(l1);
                     if (m>n) or (m<0) or (n>numnodi) or (m>numnodi) then write('Estremi errati: m deve essere < di n!')
                            else begin
                                 cont:=1;
                                 temp1:=l1;
                                 crea_nuova_lista(temp3);
                                 while (cont<>m) do begin
                                                    insert(temp3,temp1^.key);
                                                    cont:=cont+1;
                                                    temp1:=temp1^.next;
                                                    end;
                                 temp2:=temp1;
                                 while cont<>n do begin
                                                  cont:=cont+1;
                                                  temp2:=temp2^.next;
                                                  end;
                                 temp1^.next:=temp2;
                                 while temp3<>nil do begin
                                                     fuori_lista(temp3,x);
                                                     insert(temp1,x);
                                                     end;{while}
                                 l1:=temp1;
                                 end;{if2}
                     end;{if1}
readln;
end;

end.{UNIT}